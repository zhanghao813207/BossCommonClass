//
//  BossConstDataDefine.m
//  BasicCommonClass
//
//  Created by 贾远潮 on 2018/3/12.
//

#import "BossConstDataDefine.h"

@implementation BossConstDataDefine

#pragma mark -- 访问域名
#ifdef DEBUG
///*-------------*********移动测试环境公共接口********-------*/
/** 测试环境总域名 URL*/
NSString *const BossBasicURL = @"https:nnb-api-v2-dev.o3cloud.cn/2.0";
#else
/*-------------*********移动正式环境公共接口********-------*/
/** 正式环境总域名 URL*/
NSString *const BossBasicURL = @"https://nnb-api-v2.o3cloud.cn/2.0";
#endif

#pragma mark -- ACCESS_KEY 和 SECRET_KEY

#ifdef DEBUG
NSString *const ACCESS_KEY = @"cd1577396e897202cd627fe7a7863213";
NSString *const SECRET_KEY = @"bb0ff82cef95f159c0013d9a0249f0e1";
#else
NSString *const ACCESS_KEY = @"9cebc6a65415167804d397b0fa3debc8";
NSString *const SECRET_KEY = @"c50b708089c9fcaac9040649dc86c667";
#endif

NSString *const SOBOT_KEY = @"20631dce86e641aca874c6d50562056f";

#pragma mark --UserDefaultKey

// 保存账号信息
NSString *const AccountInfoKey = @"AccountInfoKey";

@end
