//
//  InputPhoneNumberView.h
//  NNB
//
//  Created by 贾远潮 on 2017/12/20.
//  Copyright © 2017年 贾远潮. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SaasModel.h"

UIKIT_EXTERN CGFloat const kInputPhoneNumberViewHeight;

@interface InputPhoneNumberView : UIView

/**
 Saas信息
 */
@property (nonatomic, strong) SaasModel *saasModel;

@property (nonatomic, strong) NSString *phoneNumber;

/**
 点击了下一步的回调，回调中两个参数第一个为手机号码  第二个为输入框中内容（带空格的手机号）
 */
@property (nonatomic, copy) void(^nextStepBlock)(NSString *phoneNumber,NSString *textFieldText);
@property (nonatomic, copy) void(^agreementBlock)(void);
@property (nonatomic, copy) void(^privacyBlock)(void);

/**
 成为第一响应者
 */
- (void)isBecomeFirstResponder;

/**
 释放第一响应着
 */
- (void)resignTheFirstResponder;

@end
