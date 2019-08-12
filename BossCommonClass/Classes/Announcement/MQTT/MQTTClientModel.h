//
//  MQTTClientModel.h
//  Rinnai
//
//  Created by 朱天聪 on 2018/5/10.
//  Copyright © 2018年 Hadlinks. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MQTTPackage.h"
#import <MQTTClient/MQTTClient.h>

#define MQTTClientModelStance [MQTTClientModel sharedInstance]

@interface MQTTClientModel : NSObject

@property (nonatomic, assign) BOOL isConnect;

@property (nonatomic,strong) MQTTSessionManager *mySessionManager;

+ (instancetype)sharedInstance;

- (void)connect:(NSString *) accountId;

- (void)disconnect;

- (void)reConnect;

/**
 订阅主题
 
 @param topic 主题
 */
typedef void (^SubscribeTopicHandler)(NSString *topic, BOOL success);

- (void)subscribeTopic:(NSString *)topic;

/**
 取消订阅
 
 @param topic 主题
 */
- (void)unsubscribeTopic:(NSString *)topic;

/**
 发布消息
 */
- (void)sendDataToTopic:(NSString *)topic dict:(NSDictionary *)dict;
- (void)sendDataToTopic:(NSString *)topic str:(NSString *)str;
- (void)sendDataToTopic:(NSString *)topic data:(NSData *)data;
@end
