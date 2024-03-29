//
//  LoginVC.h
//  NNB
//
//  Created by 贾远潮 on 2017/12/20.
//

#import <UIKit/UIKit.h>
#import "BossViewController.h"
@interface LoginVC : BossViewController

/**
 当前操作View
 */
typedef NS_ENUM(NSInteger, OperatingView) {
    MerchantCodeView,   // 输入商户号View
    PhoneNumberView,    // 输入手机号View
    PhoneCodeView,      // 输入验证码View
};

@property (nonatomic, assign) BOOL addAccount;

/**
 登陆成功回调 true：登录成功  false：点击了返回按钮
 */
@property (nonatomic, copy) void(^loginSuccessBlock)(BOOL isLogin);


@property(nullable, nonatomic,strong) UINavigationController *lastNavigationController; // If this view controller has been pushed onto a navigation controller, return it.

@property(nullable, nonatomic,strong) UITabBarController *currentTabbarController; 

@end
