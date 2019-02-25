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

// dev
NSString *const BossBasicURL = @"https://saas-api-dev.aoaosong.com//1.0/";
NSString *const BossBasicURLV2 = @"https://saas-api-dev.aoaosong.com/2.0/";

#else
/*-------------*********移动正式环境公共接口********-------*/
// release
NSString *const BossBasicURL = @"https://boss-api.aoaosong.com/1.0/";
NSString *const BossBasicURLV2 = @"https://boss-api.aoaosong.com/2.0/";

#endif

#pragma mark -- ACCESS_KEY 和 SECRET_KEY

NSString *const ACCESS_KEY = @"5c6bb6fcce6d2a1779126214";
NSString *const SECRET_KEY = @"5c6bb6fcce6d2a1779126215";

#pragma mark -- APPCODE 和 APP_ID

#ifdef kBossKnight

    NSString *const APPCODE = @"aoao_boss_app_ios";
    NSString *const APP_ID = @"5c0a1988ce6d2a984c1fe8fc";

    NSString *const APPDOWNLOADURL = @"https://itunes.apple.com/us/app/id1391525314?l=zh&ls=1&mt=8";

#elif defined kBossManager

    NSString *const APPCODE = @"aoao_boss_manager_ios";
    NSString *const APP_ID = @"5c0a1988ce6d2a984c1fe900";

    NSString *const APPDOWNLOADURL = @"https://itunes.apple.com/us/app/id1425789658?l=zh&ls=1&mt=8";

#else

    NSString *const APPCODE = @"aoao_boss_app_ios";

    NSString *const APPDOWNLOADURL = @"https://itunes.apple.com/us/app/id1391525314?l=zh&ls=1&mt=8";
#endif

BOOL const kIsAlertPassword = NO;

NSString *const SOBOT_KEY = @"20631dce86e641aca874c6d50562056f";

CGFloat const kKeyBordAnimationDuration = 0.25f; // 键盘动画持续时间

#pragma mark --UserDefaultKey

// 存放商户信息
NSString *const SAAS_KEY = @"saas_key";

// 存放员工/骑士信息
NSString *const ACCOUNT_KEY = @"account_key";

// 多帐号信息
NSString *const ACCOUNT_LIST_KEY = @"account_list_key";

@end
