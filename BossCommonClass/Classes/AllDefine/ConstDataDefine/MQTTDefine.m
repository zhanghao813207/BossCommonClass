//
//  MQTTDefine.m
//  AFNetworking
//
//  Created by 张浩 on 2019/5/29.
//

#import "MQTTDefine.h"

@implementation MQTTDefine

#ifdef DEBUG
// Dev/QA 默认测试环境
NSString * mqttServer = @"boss-api-dev.aoaosong.com";
NSInteger  mqttPort   = 1883;

NSString * mqttUserName = @"im_server";
NSString * mqttPassword = @"im_server-123";
NSString * mqttClientId = @"im_server";

NSString * mqttSecretKey = @"cc6803a649ff7f3f036566d1421c4315";

#else

// release

NSString * mqttServer = @"ums-mt.aoaosong.com";
NSInteger  mqttPort   = 1883;

#ifdef kBossKnight

NSString * mqttUserName = @"aoao_boss_app_ios";
NSString * mqttPassword = @"f241c529e2da4695bb3d6ef4abafd10b";

#elif defined kBossManager

NSString * mqttUserName = @"aoao_boss_manager_ios";
NSString * mqttPassword = @"4e3993b160ea47b898bb6b2737b8b6ec";

#elif defined kBossOwner

NSString * mqttUserName = @"qlife_ios";
NSString * mqttPassword = @"79a6bcac9a4e43a7aebcb856ae0d9165";

#else

NSString * mqttUserName = @"im_server";
NSString * mqttPassword = @"im_server-123";

#endif

NSString * mqttClientId = @"im_server-";

NSString * mqttSecretKey = @"6fc6baf2875911e9bc42526af7764f64";

#endif

@end
