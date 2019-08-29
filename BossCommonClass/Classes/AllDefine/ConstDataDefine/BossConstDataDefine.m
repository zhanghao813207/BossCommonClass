//
//  BossConstDataDefine.m
//  BasicCommonClass
//
//  Created by 贾远潮 on 2018/3/12.
//

#import "BossConstDataDefine.h"

@implementation BossConstDataDefine

#pragma mark-- 访问域名

#ifdef DEBUG

#ifdef kBossOwner
// BossOwner

NSString *const BossBasicPrefix = @"qlife";

NSString *const BossUmsPrefix = @"boss";

// dev
NSString *const BossBasicURL   = @"https://boss-api-dev.aoaosong.com:9040/1.0/";
NSString *const BossBasicURLV2 = @"https://boss-api-dev.aoaosong.com:9040/2.0/";
NSString *const ACCESS_KEY     = @"5277d8d0265d5ae93e23da9a640fe354";
NSString *const SECRET_KEY     = @"d9ccf222c2a9e1378de3bff603bfde96";

NSString *const MessageBasicURL   = @"https://boss-quhuo-api.aoaosong.com:9090/1.0/";
NSString *const MessageBasicURLV2 = @"https://boss-quhuo-api.aoaosong.com:9090/2.0/";

// QA
//NSString *const BossBasicURL   = @"https://boss-quhuo-api.aoaosong.com:9070/1.0/";
//NSString *const BossBasicURLV2 = @"https://boss-quhuo-api.aoaosong.com:9070/2.0/";
//NSString *const ACCESS_KEY     = @"e6d14e49b8589e95508e6245d6628337";
//NSString *const SECRET_KEY     = @"a6b0a55291872fa9e2c3707285f297d2";
//
//NSString *const MessageBasicURL   = @"https://boss-quhuo-api.aoaosong.com:9090/1.0/";
//NSString *const MessageBasicURLV2 = @"https://boss-quhuo-api.aoaosong.com:9090/2.0/";

// Demo
//NSString *const BossBasicURL    = @"https://boss-quhuo-api.aoaosong.com:1082/1.0/";
//NSString *const BossBasicURLV2  = @"https://boss-quhuo-api.aoaosong.com:1082/2.0/";
//NSString *const ACCESS_KEY      = @"3f92d896b23d960e529048c2fc2ab762";
//NSString *const SECRET_KEY      = @"2fd89206dd6edd7b87b8833ba6bed5a9";
//
//NSString *const MessageBasicURL   = @"https://boss-api-dev.aoaosong.com:1083/2.0/";
//NSString *const MessageBasicURLV2 = @"https://boss-api-dev.aoaosong.com:1083/2.0/";

#elif defined kBossKnight
// BossKnight

NSString *const BossBasicPrefix = @"qlife";

NSString *const BossUmsPrefix = @"boss";

// dev
NSString *const BossBasicURL   = @"https://boss-api-dev.aoaosong.com:9040/1.0/";
NSString *const BossBasicURLV2 = @"https://boss-api-dev.aoaosong.com:9040/2.0/";
NSString *const ACCESS_KEY     = @"e2ee2080d71f31b7e5794089ec5ddadc";
NSString *const SECRET_KEY     = @"717285b895ddce6a8197e4b9773800c8";

NSString *const MessageBasicURL   = @"https://boss-quhuo-api.aoaosong.com:9090/1.0/";
NSString *const MessageBasicURLV2 = @"https://boss-quhuo-api.aoaosong.com:9090/2.0/";

// QA
//NSString *const BossBasicURL   = @"https://boss-quhuo-api.aoaosong.com:9070/1.0/";
//NSString *const BossBasicURLV2 = @"https://boss-quhuo-api.aoaosong.com:9070/2.0/";
//NSString *const ACCESS_KEY     = @"e6d14e49b8589e95508e6245d6628337";
//NSString *const SECRET_KEY     = @"a6b0a55291872fa9e2c3707285f297d2";
//
//NSString *const MessageBasicURL   = @"https://boss-quhuo-api.aoaosong.com:9090/1.0/";
//NSString *const MessageBasicURLV2 = @"https://boss-quhuo-api.aoaosong.com:9090/2.0/";

// Demo
//NSString *const BossBasicURL    = @"https://boss-quhuo-api.aoaosong.com:1082/1.0/";
//NSString *const BossBasicURLV2  = @"https://boss-quhuo-api.aoaosong.com:1082/2.0/";
//NSString *const ACCESS_KEY      = @"500aa2ba0e248edff26c502ac11d8f41";
//NSString *const SECRET_KEY      = @"f175a2c83bbec7732c6acd0c8b405504";
//
//NSString *const MessageBasicURL   = @"https://boss-api-dev.aoaosong.com:1083/2.0/";
//NSString *const MessageBasicURLV2 = @"https://boss-api-dev.aoaosong.com:1083/2.0/";

#else
// BossManager

NSString *const BossBasicPrefix = @"boss";

NSString *const BossUmsPrefix = @"boss";

// Dev/Demo/QA
NSString *const BossBasicURL   = @"https://saas-api-dev.aoaosong.com/1.0/";
NSString *const BossBasicURLV2 = @"https://saas-api-dev.aoaosong.com/2.0/";
NSString *const ACCESS_KEY     = @"5c6bb6fcce6d2a1779126214";
NSString *const SECRET_KEY     = @"5c6bb6fcce6d2a1779126215";

// Ums
// Dev/QA
NSString *const MessageBasicURL   = @"https://boss-quhuo-api.aoaosong.com:9090/1.0/";
NSString *const MessageBasicURLV2 = @"https://boss-quhuo-api.aoaosong.com:9090/2.0/";
// Demo
//NSString *const MessageBasicURL   = @"https://boss-api-dev.aoaosong.com:1083/1.0/";
//NSString *const MessageBasicURLV2 = @"https://boss-api-dev.aoaosong.com:1083/2.0/";
#endif

// meeting basic url
// Dev/QA
NSString *const MeetingBasicURL = @"https://boss-quhuo.aoaosong.com:9030/meeting/";
// Demo
//NSString *const MeetingBasicURL = @"https://boss-quhuo.aoaosong.com:2090/meeting/";
#else

#ifdef kBossOwner
// 生产环境 Boss老板
NSString *const BossBasicURL    = @"https://qlife-api.aoaosong.com/1.0/";
NSString *const BossBasicURLV2  = @"https://qlife-api.aoaosong.com/2.0/";
NSString *const BossBasicPrefix = @"qlife";
NSString *const ACCESS_KEY      = @"7827bafd44edad630286e406579ee76d";
NSString *const SECRET_KEY      = @"09d93665b7c63d85607176aeaf6411ee";

// 生产环境 Boss老板消息服务
NSString *const MessageBasicURL   = @"https://ums-api.aoaosong.com/1.0/";
NSString *const MessageBasicURLV2 = @"https://ums-api.aoaosong.com/2.0/";
NSString *const BossUmsPrefix     = @"boss";
#elif defined kBossKnight
// 生产环境 Boss骑士
NSString *const BossBasicURL    = @"https://qlife-api.aoaosong.com/1.0/";
NSString *const BossBasicURLV2  = @"https://qlife-api.aoaosong.com/2.0/";
NSString *const BossBasicPrefix = @"qlife";
NSString *const ACCESS_KEY      = @"e837806cdf3a33e1340383fe4607f48e";
NSString *const SECRET_KEY      = @"8499a637c20d6d7bb7c08da2d0a74f81";

// 生产环境 Boss老板消息服务
NSString *const MessageBasicURL   = @"https://ums-api.aoaosong.com/1.0/";
NSString *const MessageBasicURLV2 = @"https://ums-api.aoaosong.com/2.0/";
NSString *const BossUmsPrefix     = @"boss";
#else
// release
// 生产环境 Boss之家
NSString *const BossBasicURL    = @"https://saas-api.aoaosong.com/1.0/";
NSString *const BossBasicURLV2  = @"https://saas-api.aoaosong.com/2.0/";
NSString *const BossBasicPrefix = @"boss";
NSString *const ACCESS_KEY      = @"5c779ed4887d1f45fc349753";
NSString *const SECRET_KEY      = @"5c779ed4887d1f45fc349754";

// 生产环境 Boss之家 消息服务
NSString *const MessageBasicURL   = @"https://ums-api.aoaosong.com/1.0/";
NSString *const MessageBasicURLV2 = @"https://ums-api.aoaosong.com/2.0/";
NSString *const BossUmsPrefix     = @"boss";
#endif

// 会议基础URL
NSString *const MeetingBasicURL = @"https://qlife-apps.aoaosong.com/meeting/";

#endif

#pragma mark-- ACCESS_KEY 和 SECRET_KEY

#pragma mark-- APPCODE 和 APP_ID

#ifdef kBossKnight

NSString *const APPCODE        = @"qlife-knight-ios";
NSString *const APP_ID         = @"5c0a1988ce6d2a984c1fe8fc";
NSString *const AGREEMENTURL   = @"http://boss-dev.aoaosong.com/static/agreement-knight.html";
NSString *const AGREEMENTTITLE = @"登录代表您已同意Boss骑士用户协议与隐私政策";
NSString *const APPDOWNLOADURL = @"https://itunes.apple.com/us/app/id1391525314?l=zh&ls=1&mt=8";
NSString *const SCHEME         = @"qhqs";
#elif defined kBossManager

NSString *const APPCODE        = @"aoao_boss_manager_ios";
NSString *const APP_ID         = @"5c0a1988ce6d2a984c1fe900";
NSString *const AGREEMENTTITLE = @"登录代表您已同意Boss之家用户协议与隐私政策";
NSString *const AGREEMENTURL   = @"http://boss-dev.aoaosong.com/static/agreement-home.html";
NSString *const SCHEME         = @"qhzj";
NSString *const APPDOWNLOADURL = @"https://itunes.apple.com/us/app/id1425789658?l=zh&ls=1&mt=8";

#elif defined kBossOwner

NSString *const APPCODE        = @"qlife-ios";
NSString *const APP_ID         = @"5cc8173bce6d2a0961c4fa2e";
NSString *const SCHEME         = @"qhlb";
NSString *const AGREEMENTTITLE = @"登录代表您已同意Boss老板用户协议与隐私政策";
NSString *const AGREEMENTURL   = @"http://boss-dev.aoaosong.com/static/agreement-boss.html";
NSString *const APPDOWNLOADURL = @"https://itunes.apple.com/us/app/id1425789658?l=zh&ls=1&mt=8";

#else
NSString *const AGREEMENTTITLE = @"登录代表您已同意Boss之家用户协议与隐私政策";
NSString *const APPCODE        = @"aoao_boss_app_ios";
NSString *const SCHEME         = @"qhlb";
NSString *const AGREEMENTURL   = @"http://boss-dev.aoaosong.com/static/agreement-boss.html";
NSString *const APPDOWNLOADURL = @"https://itunes.apple.com/us/app/id1391525314?l=zh&ls=1&mt=8";
#endif

#ifdef kBossOwner
// 当家
NSString *const APPSTOREID = @"1466744567";
#elif defined kBossKnight
// 骑士
NSString *const APPSTOREID = @"1391525314";
#elif defined kBossManager
//之家
NSString *const APPSTOREID = @"1425789658";
#else
// 当家
NSString *const APPSTOREID = @"1425789658";
#endif

BOOL const kIsAlertPassword = NO;

NSString *const SOBOT_KEY = @"20631dce86e641aca874c6d50562056f";

CGFloat const kKeyBordAnimationDuration = 0.25f;  // 键盘动画持续时间

#pragma mark--UserDefaultKey

// 存放商户信息
NSString *const SAAS_KEY = @"saas_key";

// 存放人员/骑士信息
NSString *const ACCOUNT_KEY = @"account_key";

// 多帐号信息
NSString *const ACCOUNT_LIST_KEY = @"account_list_key";

// 最后一次登录手机号
NSString *const LAST_LOGIN_PHONE_KEY = @"last_login_phone_key";

// 退出登录列表
NSString *const LOGOUT_PHONE_LIST_KEY = @"logout_phone_list_key";

@end
