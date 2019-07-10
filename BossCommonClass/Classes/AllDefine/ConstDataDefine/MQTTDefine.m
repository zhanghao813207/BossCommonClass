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

//    NSString *const mqttServer = @"192.168.10.69";
//    NSInteger const mqttPort   = 1883;
//
//    NSString *const mqttUserName = @"im_server";
//    NSString *const mqttPassword = @"im_server-123";
//    NSString *const mqttClientId = @"im_server";
//
//    NSString *const mqttSecretKey = @"cc6803a649ff7f3f036566d1421c4315";

    // dev

    NSString *const mqttServer = @"boss-api-dev.aoaosong.com";
    NSInteger const mqttPort   = 1883;

    NSString *const mqttUserName = @"im_server";
    NSString *const mqttPassword = @"im_server-123";
    NSString *const mqttClientId = @"im_server";

    NSString *const mqttSecretKey = @"cc6803a649ff7f3f036566d1421c4315";

#else

    // release

    NSString *const mqttServer = @"ums-mt.aoaosong.com";
    NSInteger const mqttPort   = 1883;

#ifdef kBossKnight

    NSString *const mqttUserName = @"aoao_boss_app_ios";
    NSString *const mqttPassword = @"f241c529e2da4695bb3d6ef4abafd10b";

#elif defined kBossManager

    NSString *const mqttUserName = @"aoao_boss_manager_ios";
    NSString *const mqttPassword = @"4e3993b160ea47b898bb6b2737b8b6ec";

#elif defined kBossOwner

    NSString *const mqttUserName = @"qlife_ios";
    NSString *const mqttPassword = @"79a6bcac9a4e43a7aebcb856ae0d9165";

#else

    NSString *const mqttUserName = @"im_server";
    NSString *const mqttPassword = @"im_server-123";

#endif

NSString *const mqttClientId = @"im_server-";

NSString *const mqttSecretKey = @"6fc6baf2875911e9bc42526af7764f64";

#endif

@end
