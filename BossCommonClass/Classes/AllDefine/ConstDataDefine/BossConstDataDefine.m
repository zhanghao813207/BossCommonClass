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

//NSString *const BossBasicURL = @"https://boss-api-dev.aoaosong.com/1.0/";

//NSString *const BossBasicURL = @"http://123.124.17.55:8051/1.0/";

// 后端刘昌颜 ip
//NSString *const BossBasicURL = @"http://192.168.1.144:8081/1.0/";

// 后端段飞 ip
//NSString *const BossBasicURL = @"http://192.168.1.113:8081/1.0/";

// 后端潘总 ip
NSString *const BossBasicURL = @"http://192.168.1.121:8080/1.0/";



#else
/*-------------*********移动正式环境公共接口********-------*/
///** 正式环境总域名 URL*/
NSString *const BossBasicURL = @"https://boss-api.aoaosong.com/1.0/";
#endif

#pragma mark -- ACCESS_KEY 和 SECRET_KEY


#ifdef kBossKnight

    #ifdef DEBUG
    NSString *const ACCESS_KEY = @"5aab926e14fef90e81eba4e5";
    NSString *const SECRET_KEY = @"5aab926e14fef90e81eba4e6";
    #else
    NSString *const ACCESS_KEY = @"5ac19960ce6d2ab290eca20a";
    NSString *const SECRET_KEY = @"5ac19960ce6d2ab290eca20b";
    #endif

    NSString *const APPCODE = @"aoao_boss_app_ios";

    NSString *const APPDOWNLOADURL = @"https://itunes.apple.com/us/app/id1391525314?l=zh&ls=1&mt=8";

#elif defined kBossManager

    #ifdef DEBUG
//    NSString *const ACCESS_KEY = @"5b4703f05ac78422a669bc9c";
//    NSString *const SECRET_KEY = @"5b4703f05ac78422a669bc9d";

    NSString *const ACCESS_KEY = @"5b73cbd5ce6d2a6036a46685";
    NSString *const SECRET_KEY = @"5b73cbd5ce6d2a6036a46686";
    #else
    NSString *const ACCESS_KEY = @"5b73cbd5ce6d2a6036a46685";
    NSString *const SECRET_KEY = @"5b73cbd5ce6d2a6036a46686";
    #endif

    NSString *const APPCODE = @"aoao_boss_manager_ios";

    NSString *const APPDOWNLOADURL = @"https://itunes.apple.com/us/app/id1425789658?l=zh&ls=1&mt=8";

#else

    #ifdef DEBUG
    NSString *const ACCESS_KEY = @"5aab926e14fef90e81eba4e5";
    NSString *const SECRET_KEY = @"5aab926e14fef90e81eba4e6";
    #else
    NSString *const ACCESS_KEY = @"5ac19960ce6d2ab290eca20a";
    NSString *const SECRET_KEY = @"5ac19960ce6d2ab290eca20b";
    #endif

    NSString *const APPCODE = @"aoao_boss_app_ios";

    NSString *const APPDOWNLOADURL = @"https://itunes.apple.com/us/app/id1391525314?l=zh&ls=1&mt=8";
#endif

BOOL const kIsAlertPassword = NO;

NSString *const SOBOT_KEY = @"20631dce86e641aca874c6d50562056f";

#pragma mark --UserDefaultKey

// 保存账号信息
NSString *const AccountInfoKey = @"AccountInfoKey";

@end
