//
//  MQTTDefine.h
//  AFNetworking
//
//  Created by 张浩 on 2019/5/29.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MQTTDefine : NSObject

// MQTT服务器地址
UIKIT_EXTERN NSString *const mqttServer;

// MQTT端口
UIKIT_EXTERN NSInteger const mqttPort;

// 用户名
UIKIT_EXTERN NSString *const mqttUserName;

// 密钥
UIKIT_EXTERN NSString *const mqttPassword;

// client id
UIKIT_EXTERN NSString *const mqttClientId;

// secret key
UIKIT_EXTERN NSString *const mqttSecretKey;

@end

NS_ASSUME_NONNULL_END
