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

@interface MQTTClientModel () <MQTTSessionManagerDelegate,WifiManagerDelegate>

@property (nonatomic, strong) NSString *accountId;

@property (nonatomic,strong) MQTTCFSocketTransport *myTransport;
/// 订阅的事件
@property (nonatomic,strong) NSMutableDictionary *subedDict;

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
    
    self.mySessionManager.subscriptions = self.subedDict;
}

- (void)disconnect {
    //    self.isContented = NO;
    [self.mySessionManager disconnectWithDisconnectHandler:^(NSError *error) {
        NSLog(@"断开连接  error = %@",[error description]);
    }];
    [self.mySessionManager setDelegate:nil];
    self.mySessionManager = nil;
    [self.subedDict removeAllObjects];
    
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

#pragma mark ---- 状态
- (void)sessionManager:(MQTTSessionManager *)sessionManager didChangeState:(MQTTSessionManagerState)newState {
    switch (newState) {
        case MQTTSessionManagerStateConnected:
        {
            self.isConnect = true;
            NSLog(@"eventCode -- 连接成功");
            // 订阅消息
            if (self.accountId) {
                [self subscribeTopic:self.accountId];
            }
            // 启动定时发布心跳包
            [self countDownWithTopic:@"ums/"];
        }
            break;
        case MQTTSessionManagerStateConnecting:
            NSLog(@"eventCode -- 连接中");
            
            break;
        case MQTTSessionManagerStateClosed:
            NSLog(@"eventCode -- 连接被关闭");
            self.isConnect = false;
            // 取消定时发送心跳包
            break;
        case MQTTSessionManagerStateError:
            NSLog(@"eventCode -- 连接错误");
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
- (void)subscribeTopic:(NSString *)topic{
    
    NSLog(@"当前需要订阅-------- topic = %@",topic);
    if (![self.subedDict.allKeys containsObject:topic]) {
        [self.subedDict setObject:[NSNumber numberWithLong:MQTTQosLevelAtLeastOnce] forKey:topic];
        NSLog(@"订阅字典 ----------- = %@",self.subedDict);
        self.mySessionManager.subscriptions =  self.subedDict;
    }
    else {
        NSLog(@"已经存在，不用订阅");
    }
    
}

#pragma mark - 取消订阅
- (void)unsubscribeTopic:(NSString *)topic {
    
    NSLog(@"当前需要取消订阅-------- topic = %@",topic);
    
    if ([self.subedDict.allKeys containsObject:topic]) {
        [self.subedDict removeObjectForKey:topic];
        NSLog(@"更新之后的订阅字典 ----------- = %@",self.subedDict);
        self.mySessionManager.subscriptions =  self.subedDict;
    }
    else {
        NSLog(@"不存在，无需取消");
    }
    
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

#pragma mark - 启动心跳
- (void)countDownWithTopic:(NSString *)topic {
    if (self.isConnect == false) {
        return;
    }
    // 发送心跳信息
    __weak typeof(self) weakSelf = self;
    if(kCache.deviceToken && self.mySessionManager) {
        NSDictionary *dic = @{@"event_name":@"heartbeat",@"payload":@{@"account_id":self.accountId?:@""}};
        NSLog(@"MQTTClientModel->countDownWithTopic->heartbeat \n %@",dic);
        NSData *data = [QLifeAES256 dataWithEncodeObj:dic password:mqttSecretKey];
        [weakSelf sendDataToTopic:topic data:data];
    }
    
    int64_t delayInSeconds = 60;      // 心跳间隔60s
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf countDownWithTopic:topic];
        });
    });
}

#pragma mark - 懒加载
- (MQTTSessionManager *)mySessionManager {
    if (!_mySessionManager) {
        
        _mySessionManager = [[MQTTSessionManager alloc]init];
        _mySessionManager.delegate = self;
    }
    return _mySessionManager;
}

- (NSMutableDictionary *)subedDict {
    if (!_subedDict) {
        _subedDict = [NSMutableDictionary dictionary];
    }
    return _subedDict;
}
@end

