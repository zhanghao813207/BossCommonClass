//
//  MQTTClientModel.m
//  Rinnai
//
//  Created by 朱天聪 on 2018/5/10.
//  Copyright © 2018年 欧客云. All rights reserved.
//

#import "MQTTClientModel.h"
#import "WifiManager.h"
#import "BossMethodDefine.h"
#import "BossCache.h"
#import "MQTTDefine.h"
#import "QLifeAES256.h"
#import "JYCSimpleToolClass.h"
#import <FirebaseCrashlytics/FIRCrashlytics.h>

@interface MQTTClientModel () <MQTTSessionManagerDelegate,WifiManagerDelegate>

@property (nonatomic, strong) NSString *accountId;

@property (nonatomic,strong) MQTTCFSocketTransport *myTransport;
/// 订阅的事件
@property (nonatomic,strong) NSMutableDictionary *subedDict;

@property (nonatomic, strong) dispatch_source_t heartbeatTimer;

@end
@implementation MQTTClientModel

+ (instancetype)sharedInstance {
    static MQTTClientModel *user = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        user = [[MQTTClientModel alloc]init];
    });
    return user;
}

- (void)connect:(NSString *) accountId {
    self.accountId = accountId?:@"";
    NSString *clientId = [NSString stringWithFormat:@"%@%@%@",mqttClientId,[JYCSimpleToolClass getUUID],accountId];
#ifdef kBossManager
    
#else
    NSDictionary *param = @{
        @"AccountId": self.accountId?:@"无",
        @"mqttServer": mqttServer?:@"无",
        @"mqttPort": @(mqttPort),
        @"mqttUserName": mqttUserName?:@"无",
        @"mqttPassword": mqttPassword?:@"无",
    };
    [[FIRCrashlytics crashlytics] setCustomValue:param forKey:@"MQTTMsg"];
    // 如果当家或骑士是第一次安装，莫名导致崩溃，所以第一次安装时不链接MQTT，并上传日志，查看信息
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"hasLaunch"]) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"hasLaunch"];
        return;
    }
#endif
    [self.mySessionManager connectTo:mqttServer
                                port:mqttPort
                                 tls:NO
                           keepalive:60
                               clean:YES
                                auth:YES
                                user:mqttUserName
                                pass:mqttPassword
                                will:NO/////will为no 下面的will一定为默认
                           willTopic:nil
                             willMsg:nil
                             willQos:MQTTQosLevelAtMostOnce
                      willRetainFlag:NO
                        withClientId:clientId
                      securityPolicy:nil
                        certificates:nil
                       protocolLevel:4
                      connectHandler:^(NSError *error) {
                          NSLog(@"%@",error);
                      }];
}

- (void)disconnect {
    [self.mySessionManager disconnectWithDisconnectHandler:^(NSError *error) {
        NSLog(@"断开连接  error = %@",[error description]);
    }];
}


- (void)reConnect {
    
    // 是否启动UMS
    if(!kCache.checkStartUMS){
        return;
    }
    
    if (self.mySessionManager && self.mySessionManager.port) {
        self.mySessionManager.delegate = self;
        [self.mySessionManager connectToLast:^(NSError *error) {
            NSLog(@"重新连接  error = %@",[error description]);
        }];
        self.mySessionManager.subscriptions = self.subedDict;
    }
    else {
        [self connect:self.accountId];
    }
    
}

#pragma mark ---- dealloc
- (void)dealloc {
    dispatch_source_cancel(self.heartbeatTimer);
    self.heartbeatTimer = nil;
    [self.mySessionManager setDelegate:nil];
    self.mySessionManager = nil;
}

#pragma mark ---- 状态
- (void)sessionManager:(MQTTSessionManager *)sessionManager didChangeState:(MQTTSessionManagerState)newState {
    switch (newState) {
        case MQTTSessionManagerStateConnected:
        {
            NSLog(@"eventCode -- 连接成功");
            // 订阅消息
            if (self.accountId) {
                [self.subedDict removeAllObjects];
                [self addSubscribeTopic:self.accountId];
                [self subscribeTopics];
            }
            // 启动定时发布心跳包
            [self startTimer];
            self.isConnect = true;
            
        }
            break;
        case MQTTSessionManagerStateConnecting:
            NSLog(@"eventCode -- 连接中");
            break;
        case MQTTSessionManagerStateClosed:
            NSLog(@"eventCode -- 连接被关闭");
            // 取消定时发送心跳包
            [self  stopTimer];
            self.isConnect = false;
            break;
        case MQTTSessionManagerStateError:
            NSLog(@"eventCode -- 连接错误");
            // 取消定时发送心跳包
            [self  stopTimer];
            self.isConnect = false;
            break;
        case MQTTSessionManagerStateClosing:
            NSLog(@"eventCode -- 关闭中");
            
            break;
        case MQTTSessionManagerStateStarting:
            NSLog(@"eventCode -- 连接开始");
            
            break;
            
        default:
            break;
    }
}

#pragma mark MQTTSessionManagerDelegate
- (void)handleMessage:(NSData *)data onTopic:(NSString *)topic retained:(BOOL)retained {

    NSString *dataStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    id decodeObj = [QLifeAES256 objDecodeWithString:dataStr password:mqttSecretKey];
    NSLog(@"--------------   handleMessage ------------ \n %@", dataStr);
//    msgtype 60公告 70会议 40单聊
    NSDictionary *msgDic = decodeObj;
    NSDictionary *dic = msgDic[@"payload"];
    int type = [dic[@"msg_type"] intValue];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"message" object:nil];
    if (type == 40) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"receiveMessage" object:decodeObj];
    }
}


#pragma mark - 订阅

- (void)addSubscribeTopic:(NSString *)topic {
    if (![self.subedDict.allKeys containsObject:topic]) {
        [self.subedDict setObject:[NSNumber numberWithLong:MQTTQosLevelAtLeastOnce] forKey:topic];
        NSLog(@"订阅字典 ----------- = %@",self.subedDict);
    }
    else {
        NSLog(@"已经存在，不用订阅");
    }
}

/// 订阅主题
- (void)subscribeTopics {
    self.mySessionManager.subscriptions = self.subedDict;
}

#pragma mark - 发布消息
- (void)sendDataToTopic:(NSString *)topic dict:(NSDictionary *)dict {
    
    NSLog(@"发送命令 topic = %@  dict = %@",topic,dict);
    NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:0 error:nil];
    [self.mySessionManager sendData:data topic:topic qos:1 retain:NO];
}
- (void)sendDataToTopic:(NSString *)topic str:(NSString *)str {
    
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    [self.mySessionManager sendData:data topic:topic qos:1 retain:NO];
}
- (void)sendDataToTopic:(NSString *)topic data:(NSData *)data {
    [self.mySessionManager sendData:data topic:topic qos:1 retain:NO];
}

#pragma mark - 启动/停止心跳

- (void)startTimer{
    if(self.isConnect){
        return;
    }
    dispatch_resume(self.heartbeatTimer);
}

- (void)stopTimer{
    if(self.isConnect){
        dispatch_suspend(self.heartbeatTimer);
    }
}

- (void)countDownWithTopic:(NSString *)topic {
    // 发送心跳信息
    __weak typeof(self) weakSelf = self;
    if(kCache.deviceToken) {
        NSDictionary *dic = @{@"event_name":@"heartbeat",@"payload":@{@"account_id":self.accountId?:@""}};
        NSLog(@"MQTTClientModel->countDownWithTopic->heartbeat \n %@",dic);
        NSData *data = [QLifeAES256 dataWithEncodeObj:dic password:mqttSecretKey];
        [weakSelf sendDataToTopic:topic data:data];
    }
}

#pragma mark - 懒加载
- (MQTTSessionManager *)mySessionManager {
    if (!_mySessionManager) {
        
        _mySessionManager = [[MQTTSessionManager alloc]init];
        _mySessionManager.delegate = self;
    }
    return _mySessionManager;
}

- (dispatch_source_t)heartbeatTimer {
    if(!_heartbeatTimer) {
        __weak typeof(self) weakSelf = self;
        int64_t delayInSeconds = 60;      // 心跳间隔60s
        NSString *hearbeatTopic = @"ums/";
        _heartbeatTimer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0,  0, dispatch_get_main_queue());
        dispatch_source_set_timer(_heartbeatTimer, DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC, 0);
        dispatch_source_set_event_handler(_heartbeatTimer, ^(void){
            [weakSelf countDownWithTopic:hearbeatTopic];
        });
    }
    return _heartbeatTimer;
}

- (NSMutableDictionary *)subedDict {
    if (!_subedDict) {
        _subedDict = [NSMutableDictionary dictionary];
    }
    return _subedDict;
}
@end

