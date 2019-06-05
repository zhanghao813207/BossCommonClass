//
//  MQTTDefine.m
//  AFNetworking
//
//  Created by 张浩 on 2019/5/29.
//

#import "MQTTDefine.h"

@implementation MQTTDefine

#ifdef DEBUG

// local

//NSString *const mqttServer = @"192.168.10.62";
//NSInteger const mqttPort   = 1883;
//
//NSString *const mqttUserName = @"im_server";
//NSString *const mqttPassword = @"im_server-123";
//NSString *const mqttClientId = @"im_server";
//
//NSString *const mqttSecretKey = @"cc6803a649ff7f3f036566d1421c4315";

// dev

NSString *const mqttServer = @"boss-api-dev.aoaosong.com";
NSInteger const mqttPort   = 1883;

NSString *const mqttUserName = @"im_server";
NSString *const mqttPassword = @"im_server-123";
NSString *const mqttClientId = @"im_server";

NSString *const mqttSecretKey = @"cc6803a649ff7f3f036566d1421c4315";

#else
// release

NSString *const mqttServer = @"boss-api-dev.aoaosong.com";
NSInteger const mqttPort   = 1883;

NSString *const mqttUserName = @"im_server";
NSString *const mqttPassword = @"im_server-123";
NSString *const mqttClientId = @"im_server";

NSString *const mqttSecretKey = @"cc6803a649ff7f3f036566d1421c4315";

#endif

@end
