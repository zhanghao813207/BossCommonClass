//
//  MQTTClientModel.m
//  Rinnai
//
//  Created by 朱天聪 on 2018/5/10.
//  Copyright © 2018年 Hadlinks. All rights reserved.
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

/**
 定时器
 */
@property (nonatomic, strong) dispatch_source_t timer;

@property (nonatomic, assign) BOOL isSSL;

@property (nonatomic,strong) MQTTCFSocketTransport *myTransport;

//订阅的topic
@property (nonatomic,strong) NSMutableDictionary *subedDict;

@end
@implementation MQTTClientModel

+ (instancetype)sharedInstance {
    static MQTTClientModel *user = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        user = [[MQTTClientModel alloc]init];
        [WifiManagerInstance addDelegate:user];
        
    });
    return user;
}

- (void)connect:(NSString *) accountId {
    self.accountId = accountId;
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
    
    
    self.isDiscontent = NO;
    self.mySessionManager.subscriptions = self.subedDict;
}

- (void)disconnect {
    
    self.isDiscontent = YES;
    //    self.isContented = NO;
    [self.mySessionManager disconnectWithDisconnectHandler:^(NSError *error) {
        NSLog(@"断开连接  error = %@",[error description]);
    }];
    [self.mySessionManager setDelegate:nil];
    self.mySessionManager = nil;
    
}


- (void)reConnect {
    
    // 是否启动UMS
    if(!kCache.checkStartUMS){
        return;
    }
    
    if (self.mySessionManager && self.mySessionManager.port) {
        self.mySessionManager.delegate = self;
        self.isDiscontent = NO;
        [self.mySessionManager connectToLast:^(NSError *error) {
            NSLog(@"重新连接  error = %@",[error description]);
        }];
        self.mySessionManager.subscriptions = self.subedDict;
        
    }
    else {
        [self connect:self.accountId];
    }
    
}

#pragma mark - WifiManagerDelegate
- (void)manager:(WifiManager *)manager reachabilityChanged:(NetworkStatus)status {
    if (status == NotReachable) {
        [self disconnect];
#warning 网络改变所以设备离线
    }
    else if (self.mySessionManager.state != MQTTSessionManagerStateConnected) {
        [self reConnect];
    }
    
}

#pragma mark - 绑定

- (MQTTSSLSecurityPolicy *)customSecurityPolicy
{
    
    MQTTSSLSecurityPolicy *securityPolicy = [MQTTSSLSecurityPolicy policyWithPinningMode:MQTTSSLPinningModeNone];
    
    securityPolicy.allowInvalidCertificates = YES;
    securityPolicy.validatesCertificateChain = YES;
    securityPolicy.validatesDomainName = NO;
    return securityPolicy;
}


#pragma mark ---- 状态
- (void)sessionManager:(MQTTSessionManager *)sessionManager didChangeState:(MQTTSessionManagerState)newState {
    switch (newState) {
        case MQTTSessionManagerStateConnected:
        {
            NSLog(@"eventCode -- 连接成功");
            // 启动定时发布心跳包
            [self countDownWithTopic:@"ums/"];
            
            // 订阅消息
            [self subscribeTopic:self.accountId];
        }
            break;
        case MQTTSessionManagerStateConnecting:
            NSLog(@"eventCode -- 连接中");
            
            break;
        case MQTTSessionManagerStateClosed:
            NSLog(@"eventCode -- 连接被关闭");
            [self cancelTimer];
            // 取消定时发送心跳包
            break;
        case MQTTSessionManagerStateError:
            NSLog(@"eventCode -- 连接错误");
            [self cancelTimer];
            // 取消定时发送心跳包
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
    
    // TODO:
    [[NSNotificationCenter defaultCenter] postNotificationName:@"message" object:nil];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"receiveMessage" object:decodeObj];
    
}


#pragma mark - 订阅
- (void)subscribeTopic:(NSString *)topic{
    
    NSLog(@"当前需要订阅-------- topic = %@",topic);
    
    if (![self.subedDict.allKeys containsObject:topic]) {
        [self.subedDict setObject:[NSNumber numberWithLong:MQTTQosLevelAtLeastOnce] forKey:topic];
        NSLog(@"订阅字典 ----------- = %@",self.subedDict);
        NSLog(@"%@",self.subedDict);
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
    [self.mySessionManager sendData:data topic:topic qos:2 retain:NO];
}
- (void)sendDataToTopic:(NSString *)topic str:(NSString *)str {
    
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    [self.mySessionManager sendData:data topic:topic qos:2 retain:NO];
}
- (void)sendDataToTopic:(NSString *)topic data:(NSData *)data {
    [self.mySessionManager sendData:data topic:topic qos:2 retain:NO];
}

#pragma mark - 定时器

/**
 启动定时器
 
 */
- (void)countDownWithTopic:(NSString *)topic {
    /** 获取一个全局的线程来运行计时器*/
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    /** 创建一个计时器*/
    self.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
    /** 设置计时器, 这里是每10毫秒执行一次*/
    dispatch_source_set_timer(self.timer, dispatch_walltime(nil, 0), 60000*NSEC_PER_MSEC, 0);
    /** 设置计时器的里操作事件*/
    dispatch_source_set_event_handler(self.timer, ^{
        if(kCache.deviceToken){

            NSDictionary *dic = @{@"event_name":@"heartbeat",@"payload":@{@"account_id":self.accountId}};
            NSLog(@"MQTTClientModel->countDownWithTopic->heartbeat \n %@",dic);
            NSData *data = [QLifeAES256 dataWithEncodeObj:dic password:mqttSecretKey];
            [self sendDataToTopic:topic data:data];
    
        }
    });
    dispatch_resume(self.timer);
}

- (void)cancelTimer {
    if(self.timer){
        dispatch_cancel(self.timer);
        self.timer = nil;
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

- (NSMutableDictionary *)subedDict {
    if (!_subedDict) {
        _subedDict = [NSMutableDictionary dictionary];
    }
    return _subedDict;
}
@end

