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

UIKIT_EXTERN NSString *const ACCESS_KEY;

UIKIT_EXTERN NSString *const SECRET_KEY;

UIKIT_EXTERN NSString *const APPCODE;

UIKIT_EXTERN BOOL const kIsAlertPassword;

UIKIT_EXTERN NSString *const SOBOT_KEY;  // 智齿客服的企业编号

UIKIT_EXTERN NSString *const APPDOWNLOADURL; // app在appStore的下载链接

UIKIT_EXTERN CGFloat const kKeyBordAnimationDuration; // 键盘动画持续时间

/********* userdefaultKey ************/

UIKIT_EXTERN NSString *const AccountInfoKey; // 存放登录的用户信息

@end
