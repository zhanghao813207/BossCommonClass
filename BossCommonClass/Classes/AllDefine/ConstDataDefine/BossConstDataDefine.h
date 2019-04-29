//
//  BossConstDataDefine.h
//  BasicCommonClass
//
//  Created by 贾远潮 on 2018/3/12.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface BossConstDataDefine : NSObject

UIKIT_EXTERN NSString *const BossBasicURL;

UIKIT_EXTERN NSString *const BossBasicURLV2;

UIKIT_EXTERN NSString *const ACCESS_KEY;

UIKIT_EXTERN NSString *const SECRET_KEY;

UIKIT_EXTERN NSString *const MessageBasicURL;

UIKIT_EXTERN NSString *const MessageBasicURLV2;

UIKIT_EXTERN NSString *const MessageACCESS_KEY;

UIKIT_EXTERN NSString *const MessageSECRET_KEY;

UIKIT_EXTERN NSString *const APPCODE;

UIKIT_EXTERN BOOL const kIsAlertPassword;

UIKIT_EXTERN NSString *const SOBOT_KEY;  // 智齿客服的企业编号

UIKIT_EXTERN NSString *const APPDOWNLOADURL; // app在appStore的下载链接

UIKIT_EXTERN CGFloat const kKeyBordAnimationDuration; // 键盘动画持续时间

/********* userdefaultKey ************/

#pragma mark -- kUserDefault Key

// 存放商户信息
UIKIT_EXTERN NSString *const SAAS_KEY;

// 存放员工/骑士信息
UIKIT_EXTERN NSString *const ACCOUNT_KEY;

// 多帐号信息
UIKIT_EXTERN NSString *const ACCOUNT_LIST_KEY;

//最后一次登录手机号
UIKIT_EXTERN NSString *const LAST_LOGIN_PHONE_KEY;

// 退出登录列表
UIKIT_EXTERN NSString *const LOGOUT_PHONE_LIST_KEY;

@end
