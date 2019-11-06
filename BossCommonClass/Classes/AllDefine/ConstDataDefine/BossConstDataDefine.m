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

#ifdef kBossManager
// 之家配置(测试)

NSString *const BossBasicPrefix = @"boss";

NSString *const BossUmsPrefix = @"boss";

// Dev/Demo/QA
NSString * BossBasicURL   = @"https://saas-api-dev.aoaosong.com/1.0/";
NSString * BossBasicURLV2 = @"https://saas-api-dev.aoaosong.com/2.0/";
NSString * ACCESS_KEY     = @"5c6bb6fcce6d2a1779126214";
NSString * SECRET_KEY     = @"5c6bb6fcce6d2a1779126215";

// Ums
// Dev/QA
NSString * MessageBasicURL   = @"https://boss-quhuo-api.aoaosong.com:9090/1.0/";
NSString * MessageBasicURLV2 = @"https://boss-quhuo-api.aoaosong.com:9090/2.0/";
// Demo
//NSString * MessageBasicURL   = @"https://boss-api-dev.aoaosong.com:1083/1.0/";
//NSString * MessageBasicURLV2 = @"https://boss-api-dev.aoaosong.com:1083/2.0/";

#else
// 骑士 当家 配置(测试)

NSString *const BossBasicPrefix = @"qlife";

NSString *const BossUmsPrefix = @"boss";
// dev
NSString * BossBasicURL;
NSString * BossBasicURLV2;
NSString * ACCESS_KEY;
NSString * SECRET_KEY;
// dev 默认测试环境

NSString * MessageBasicURL   = @"https://boss-quhuo-api.aoaosong.com:9090/1.0/";
NSString * MessageBasicURLV2 = @"https://boss-quhuo-api.aoaosong.com:9090/2.0/";


#endif

// meeting basic url
// Dev/QA
NSString * MeetingBasicURL = @"https://boss-quhuo.aoaosong.com:9030/meeting/";
// Demo
//NSString *const MeetingBasicURL = @"https://boss-quhuo.aoaosong.com:2090/meeting/";
#else

#ifdef kBossOwner
// 生产环境 Boss老板
NSString * BossBasicURL    = @"https://qlife-api.aoaosong.com/1.0/";
NSString * BossBasicURLV2  = @"https://qlife-api.aoaosong.com/2.0/";
NSString *const BossBasicPrefix = @"qlife";
NSString * ACCESS_KEY      = @"7827bafd44edad630286e406579ee76d";
NSString * SECRET_KEY      = @"09d93665b7c63d85607176aeaf6411ee";

// 生产环境 Boss老板消息服务
NSString * MessageBasicURL   = @"https://ums-api.aoaosong.com/1.0/";
NSString * MessageBasicURLV2 = @"https://ums-api.aoaosong.com/2.0/";
NSString *const BossUmsPrefix     = @"boss";
#elif defined kBossKnight
// 生产环境 Boss骑士
NSString * BossBasicURL    = @"https://qlife-api.aoaosong.com/1.0/";
NSString * BossBasicURLV2  = @"https://qlife-api.aoaosong.com/2.0/";
NSString *const BossBasicPrefix = @"qlife";
NSString * ACCESS_KEY      = @"e837806cdf3a33e1340383fe4607f48e";
NSString * SECRET_KEY      = @"8499a637c20d6d7bb7c08da2d0a74f81";

// 生产环境 Boss老板消息服务
NSString * MessageBasicURL   = @"https://ums-api.aoaosong.com/1.0/";
NSString * MessageBasicURLV2 = @"https://ums-api.aoaosong.com/2.0/";
NSString *const BossUmsPrefix     = @"boss";
#else
// release
// 生产环境 Boss之家
NSString * BossBasicURL    = @"https://saas-api.aoaosong.com/1.0/";
NSString * BossBasicURLV2  = @"https://saas-api.aoaosong.com/2.0/";
NSString *const BossBasicPrefix = @"boss";
NSString * ACCESS_KEY      = @"5c779ed4887d1f45fc349753";
NSString * SECRET_KEY      = @"5c779ed4887d1f45fc349754";

// 生产环境 Boss之家 消息服务
NSString * MessageBasicURL   = @"https://ums-api.aoaosong.com/1.0/";
NSString * MessageBasicURLV2 = @"https://ums-api.aoaosong.com/2.0/";
NSString *const BossUmsPrefix     = @"boss";
#endif

// 会议基础URL
NSString * MeetingBasicURL = @"https://qlife-apps.aoaosong.com/meeting/";

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


// 刷新的token
NSString *const REFRESH_TOKEN = @"refresh_token";

@end
