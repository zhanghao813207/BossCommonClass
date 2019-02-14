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

// local
// NSString *const BossBasicURL = @"http://192.168.1.110:8081/1.0/";
// NSString *const BossBasicURLV2 = @"http://192.168.1.110:8081/2.0/";

// dev
NSString *const BossBasicURL = @"https://boss-api-dev.aoaosong.com/1.0/";
NSString *const BossBasicURLV2 = @"https://boss-api-dev.aoaosong.com/2.0/";

// test
// NSString *const BossBasicURL = @"http://123.124.17.55:8051/1.0/";
// NSString *const BossBasicURLV2 = @"http://123.124.17.55:8051/2.0/";

// NSString *const BossBasicURL = @"https://boss-api-dev.aoaosong.com:8201/1.0/";
// NSString *const BossBasicURLV2 = @"https://boss-api-dev.aoaosong.com:8201/2.0/";

#else
/*-------------*********移动正式环境公共接口********-------*/
// release
NSString *const BossBasicURL = @"https://boss-api.aoaosong.com/1.0/";
NSString *const BossBasicURLV2 = @"https://boss-api.aoaosong.com/2.0/";

#endif

#pragma mark -- ACCESS_KEY 和 SECRET_KEY


#ifdef kBossKnight

    #ifdef DEBUG
    // NSString *const ACCESS_KEY = @"5c0a1988ce6d2a984c1fe91f";
    // NSString *const SECRET_KEY = @"5c0a1988ce6d2a984c1fe920";

    // dev
    NSString *const ACCESS_KEY = @"5c0a1988ce6d2a984c1fe91f";
    NSString *const SECRET_KEY = @"5c0a1988ce6d2a984c1fe920";
    #else
    NSString *const ACCESS_KEY = @"5ac19960ce6d2ab290eca20a";
    NSString *const SECRET_KEY = @"5ac19960ce6d2ab290eca20b";
    #endif

    NSString *const APPCODE = @"aoao_boss_app_ios";
    NSString *const APP_ID = @"5c0a1988ce6d2a984c1fe8fc";

    NSString *const APPDOWNLOADURL = @"https://itunes.apple.com/us/app/id1391525314?l=zh&ls=1&mt=8";

#elif defined kBossManager

    #ifdef DEBUG
    // local
    // NSString *const ACCESS_KEY = @"5b73cbd5ce6d2a6036a46685";
    // NSString *const SECRET_KEY = @"5b73cbd5ce6d2a6036a46686";

    // dev
    NSString *const ACCESS_KEY = @"5c0a1988ce6d2a984c1fe925";
    NSString *const SECRET_KEY = @"5c0a1988ce6d2a984c1fe926";

    #else
    NSString *const ACCESS_KEY = @"5b73cbd5ce6d2a6036a46685";
    NSString *const SECRET_KEY = @"5b73cbd5ce6d2a6036a46686";
    #endif

    NSString *const APPCODE = @"aoao_boss_manager_ios";
    NSString *const APP_ID = @"5c0a1988ce6d2a984c1fe900";

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

CGFloat const kKeyBordAnimationDuration = 0.25f; // 键盘动画持续时间

#pragma mark --UserDefaultKey

// 保存账号信息
NSString *const AccountInfoKey = @"AccountInfoKey";

@end
