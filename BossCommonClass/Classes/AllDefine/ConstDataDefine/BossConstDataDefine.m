//
//  BossConstDataDefine.m
//  BasicCommonClass
//
//  Created by 贾远潮 on 2018/3/12.
//

#import "BossConstDataDefine.h"

@implementation BossConstDataDefine

///**
// *  true 是打开调试模式
// *  false 是关闭调试模式
// */
//#define Debug


#pragma mark -- 访问域名
#ifdef Debug
///*-------------*********移动测试环境公共接口********-------*/
/** 测试环境总域名 URL*/

//NSString *const BossBasicURL = @"https://boss-api-dev.aoaosong.com/1.0/";

//NSString *const BossBasicURL = @"http://123.124.17.55:8051/1.0/";

// 后端刘昌颜 ip
//NSString *const BossBasicURL = @"http://192.168.1.144:8081/1.0/";

// 后端段飞 ip
//NSString *const BossBasicURL = @"http://192.168.1.127:8081/1.0/";

#else
/*-------------*********移动正式环境公共接口********-------*/
/** 正式环境总域名 URL*/
NSString *const BossBasicURL = @"https://boss-api.aoaosong.com/1.0/";
#endif

#pragma mark -- ACCESS_KEY 和 SECRET_KEY

#ifdef Debug
NSString *const ACCESS_KEY = @"5aab926e14fef90e81eba4e5";
NSString *const SECRET_KEY = @"5aab926e14fef90e81eba4e6";
#else
NSString *const ACCESS_KEY = @"5ac19960ce6d2ab290eca20a";
NSString *const SECRET_KEY = @"5ac19960ce6d2ab290eca20b";
#endif

NSString *const APPCODE = @"aoao_boss_app_ios";

BOOL const kIsAlertPassword = NO;

NSString *const SOBOT_KEY = @"20631dce86e641aca874c6d50562056f";

NSString *const APPDOWNLOADURL = @"https://itunes.apple.com/us/app/id1391525314?l=zh&ls=1&mt=8";

#pragma mark --UserDefaultKey

// 保存账号信息
NSString *const AccountInfoKey = @"AccountInfoKey";

@end
