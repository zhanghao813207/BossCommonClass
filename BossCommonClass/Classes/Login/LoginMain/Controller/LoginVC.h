//
//  LoginVC.h
//  NNB
//
//  Created by 贾远潮 on 2017/12/20.
//  Copyright © 2017年 贾远潮. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginVC : UIViewController

/**
 当前操作View
 */
typedef NS_ENUM(NSInteger, OperatingView) {
    MerchantCodeView,   // 输入商户号View
    PhoneNumberView,    // 输入手机号View
    CodeView,           // 输入验证码View
};

/**
 登陆成功回调
 */
@property (nonatomic, copy) void(^loginSuccessBlock)(BOOL isLogin);

@end
