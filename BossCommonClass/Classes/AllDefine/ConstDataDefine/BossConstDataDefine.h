//
//  BossConstDataDefine.h
//  BasicCommonClass
//
//  Created by 贾远潮 on 2018/3/12.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface BossConstDataDefine : NSObject

UIKIT_EXTERN NSString * BossBasicURL;

UIKIT_EXTERN NSString * BossBasicURLV2;
// CMD前缀 默认Boss 项目不同前缀不同
UIKIT_EXTERN NSString *const BossBasicPrefix;

UIKIT_EXTERN NSString *ACCESS_KEY;

UIKIT_EXTERN NSString *SECRET_KEY;

UIKIT_EXTERN NSString *MessageBasicURL;

UIKIT_EXTERN NSString *MessageBasicURLV2;
// 路由scheme
UIKIT_EXTERN NSString *const SCHEME;

// CMD前缀
UIKIT_EXTERN NSString *const BossUmsPrefix;

UIKIT_EXTERN NSString *const APPCODE;

UIKIT_EXTERN NSString *const AGREEMENTURL;

UIKIT_EXTERN NSString *const AGREEMENTTITLE;

UIKIT_EXTERN BOOL const kIsAlertPassword;

UIKIT_EXTERN NSString *const SOBOT_KEY;  // 智齿客服的企业编号

UIKIT_EXTERN NSString *const APPDOWNLOADURL; // app在appStore的下载链接

UIKIT_EXTERN CGFloat const kKeyBordAnimationDuration; // 键盘动画持续时间

// 会议基础URL
UIKIT_EXTERN NSString * MeetingBasicURL;

//数据中台基础URL（用于薪资贷）
UIKIT_EXTERN NSString * SalaryLoanBasicURL;

UIKIT_EXTERN NSString *const APPSTOREID; //在APPStroeS中应用的id

/********* userdefaultKey ************/

#pragma mark -- kUserDefault Key

// 存放商户信息
UIKIT_EXTERN NSString *const SAAS_KEY;

// 存放人员/骑士信息
UIKIT_EXTERN NSString *const ACCOUNT_KEY;

// 多帐号信息
UIKIT_EXTERN NSString *const ACCOUNT_LIST_KEY;

//最后一次登录手机号
UIKIT_EXTERN NSString *const LAST_LOGIN_PHONE_KEY;

// 退出登录列表
UIKIT_EXTERN NSString *const LOGOUT_PHONE_LIST_KEY;

// 刷新的token
UIKIT_EXTERN NSString *const REFRESH_TOKEN ;

@end
