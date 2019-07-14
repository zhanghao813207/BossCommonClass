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

#ifdef kBossOwner
    // deva
    // 测试环境 Boss老板
    NSString *const BossBasicURL = @"https://boss-api-dev.aoaosong.com:8481/1.0/";
    NSString *const BossBasicURLV2 = @"https://boss-api-dev.aoaosong.com:8481/2.0/";
    NSString *const BossBasicPrefix = @"qlife";
    NSString *const ACCESS_KEY = @"3f92d896b23d960e529048c2fc2ab762";
    NSString *const SECRET_KEY = @"2fd89206dd6edd7b87b8833ba6bed5a9";
    // 质检环境 Boss老板
//    NSString *const BossBasicURL = @"https://boss-api-dev.aoaosong.com:8483/1.0/";
//    NSString *const BossBasicURLV2 = @"https://boss-api-dev.aoaosong.com:8483/2.0/";
//    NSString *const BossBasicPrefix = @"qlife";
//    NSString *const ACCESS_KEY = @"6ad99b0c7144b5a4bfbf0962c9f682e2";
//    NSString *const SECRET_KEY = @"e84c63f2d69b0409a681a384b157c8fa";

//    NSString *const BossBasicURL = @"http://192.168.10.57:8083/1.0/";
//    NSString *const BossBasicURLV2 = @"http://192.168.10.57:8083/2.0/";
//    NSString *const BossBasicPrefix = @"qlife";
//    NSString *const ACCESS_KEY = @"3f92d896b23d960e529048c2fc2ab762";
//    NSString *const SECRET_KEY = @"2fd89206dd6edd7b87b8833ba6bed5a9";

    // 测试环境消息服务
//   NSString *const MessageBasicURL = @"http://192.168.10.62:8082/2.0/";
//   NSString *const MessageBasicURLV2 = @"http://192.168.10.62:8082/2.0/";
//   NSString *const BossUmsPrefix = @"boss";

//   NSString *const MessageBasicURL = @"http://192.168.10.5:8112/2.0/";
//   NSString *const MessageBasicURLV2 = @"http://192.168.10.5:8112/2.0/";
//   NSString *const BossUmsPrefix = @"boss";

    NSString *const MessageBasicURL = @"https://boss-api-dev.aoaosong.com:8009/2.0/";
    NSString *const MessageBasicURLV2 = @"https://boss-api-dev.aoaosong.com:8009/2.0/";
    NSString *const BossUmsPrefix = @"boss";

//
#else
    // dev
    // 测试环境 Boss之家 骑士
    NSString *const BossBasicURL = @"https://saas-api-dev.aoaosong.com/1.0/";
    NSString *const BossBasicURLV2 = @"https://saas-api-dev.aoaosong.com/2.0/";
    NSString *const BossBasicPrefix = @"boss";
    NSString *const ACCESS_KEY = @"5c6bb6fcce6d2a1779126214";
    NSString *const SECRET_KEY = @"5c6bb6fcce6d2a1779126215";

    // 消息服务
    NSString *const MessageBasicURL = @"https://boss-api-dev.aoaosong.com:8009/2.0/";
    NSString *const MessageBasicURLV2 = @"https://boss-api-dev.aoaosong.com:8009/2.0/";
    NSString *const BossUmsPrefix = @"boss";
//    // dev
//    // 测试环境 Boss之家 骑士
//    NSString *const BossBasicURL = @"http://192.168.10.69:8081/1.0/";
//    NSString *const BossBasicURLV2 = @"http://192.168.10.69:8081/2.0/";
//    NSString *const BossBasicPrefix = @"boss";
//    NSString *const ACCESS_KEY = @"5c0a1988ce6d2a984c1fe925";
//    NSString *const SECRET_KEY = @"5c0a1988ce6d2a984c1fe926";
//
//    // 消息服务
//    NSString *const MessageBasicURL = @"http://192.168.10.69:8082/2.0/";
//    NSString *const MessageBasicURLV2 = @"http://192.168.10.69:8082/2.0/";
//    NSString *const BossUmsPrefix = @"boss";
#endif

// 会议基础URL
NSString *const MeetingBasicURL = @"https://boss-dev.aoaosong.com:8112/";

#else

#ifdef kBossOwner
// 生产环境 Boss老板
NSString *const BossBasicURL = @"https://qlife-api.aoaosong.com/1.0/";
NSString *const BossBasicURLV2 = @"https://qlife-api.aoaosong.com/2.0/";
NSString *const BossBasicPrefix = @"qlife";
NSString *const ACCESS_KEY = @"7827bafd44edad630286e406579ee76d";
NSString *const SECRET_KEY = @"09d93665b7c63d85607176aeaf6411ee";
// 生产环境 Boss老板消息服务
NSString *const MessageBasicURL = @"https://ums-api.aoaosong.com/1.0/";
NSString *const MessageBasicURLV2 = @"https://ums-api.aoaosong.com/2.0/";
NSString *const BossUmsPrefix = @"boss";
#else
// release
// 生产环境之家 骑士 基础服务
NSString *const BossBasicURL = @"https://saas-api.aoaosong.com/1.0/";
NSString *const BossBasicURLV2 = @"https://saas-api.aoaosong.com/2.0/";
NSString *const BossBasicPrefix = @"boss";
NSString *const ACCESS_KEY = @"5c779ed4887d1f45fc349753";
NSString *const SECRET_KEY = @"5c779ed4887d1f45fc349754";

// 生产环境之家 骑士 消息服务
NSString *const MessageBasicURL = @"https://ums-api.aoaosong.com/1.0/";
NSString *const MessageBasicURLV2 = @"https://ums-api.aoaosong.com/2.0/";
NSString *const BossUmsPrefix = @"boss";
#endif

// 会议基础URL
NSString *const MeetingBasicURL = @"https://boss.aoaosong.com/";

#endif

#pragma mark -- ACCESS_KEY 和 SECRET_KEY

#pragma mark -- APPCODE 和 APP_ID

#ifdef kBossKnight

NSString *const APPCODE = @"aoao_boss_app_ios";
NSString *const APP_ID = @"5c0a1988ce6d2a984c1fe8fc";
NSString *const AGREEMENTURL = @"http://boss-dev.aoaosong.com/static/agreement-knight.html";
NSString *const AGREEMENTTITLE = @"登录代表您已同意Boss骑士用户协议与隐私政策";
NSString *const APPDOWNLOADURL = @"https://itunes.apple.com/us/app/id1391525314?l=zh&ls=1&mt=8";
NSString *const SCHEME = @"qhqs";
#elif defined kBossManager

NSString *const APPCODE = @"aoao_boss_manager_ios";
NSString *const APP_ID = @"5c0a1988ce6d2a984c1fe900";
NSString *const AGREEMENTTITLE = @"登录代表您已同意Boss之家用户协议与隐私政策";
NSString *const AGREEMENTURL = @"http://boss-dev.aoaosong.com/static/agreement-home.html";
NSString *const SCHEME = @"qhzj";
NSString *const APPDOWNLOADURL = @"https://itunes.apple.com/us/app/id1425789658?l=zh&ls=1&mt=8";

#elif defined kBossOwner

    NSString *const APPCODE = @"qlife-ios";
    NSString *const APP_ID = @"5cc8173bce6d2a0961c4fa2e";
    NSString *const SCHEME = @"qhlb";
    NSString *const AGREEMENTTITLE = @"登录代表您已同意Boss老板用户协议与隐私政策";
    NSString *const AGREEMENTURL = @"http://boss-dev.aoaosong.com/static/agreement-boss.html";
    NSString *const APPDOWNLOADURL = @"https://itunes.apple.com/us/app/id1425789658?l=zh&ls=1&mt=8";

#else
NSString *const AGREEMENTTITLE = @"登录代表您已同意Boss之家用户协议与隐私政策";
NSString *const APPCODE = @"aoao_boss_app_ios";
NSString *const SCHEME = @"qhlb";
NSString *const AGREEMENTURL = @"http://boss-dev.aoaosong.com/static/agreement-boss.html";
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

// 最后一次登录手机号
NSString *const LAST_LOGIN_PHONE_KEY = @"last_login_phone_key";

// 退出登录列表
NSString *const LOGOUT_PHONE_LIST_KEY = @"logout_phone_list_key";

@end
