//
//  InputCodeView.h
//  NNB
//
//  Created by 贾远潮 on 2017/12/20.
//  Copyright © 2017年 贾远潮. All rights reserved.
//

#import <UIKit/UIKit.h>

UIKIT_EXTERN CGFloat const kInputCodeViewHeight;
@class InputCodeView;
typedef NS_ENUM(NSInteger, InputCodeViewStatus) {
    InputCodeViewStatusNomal,
    InputCodeViewStatusBegainCount,
    InputCodeViewStatusCounting,
};

@protocol InputCodeViewDelegate <NSObject>

- (void)inputCodeViewWillStartCount:(InputCodeView *)inputCodeView;

@optional

- (void)inputCodeViewDidStartCount:(InputCodeView *)inputCodeView;

- (void)inputCodeViewDidFinishedCountDown:(InputCodeView *)inputCodeView;

@end


@interface InputCodeView : UIView

@property (nonatomic, weak) id<InputCodeViewDelegate> delegate;

@property (nonatomic, assign) InputCodeViewStatus inputCodeViewStatus;

@property (nonatomic, strong) NSString *phoneNumber;

@property (nonatomic, assign) BOOL showVoiceCode;

@property (nonatomic, copy) void (^voiceCodeBlock)();

/**
 点击了下一步的回调，回调中两个参数第一个为手机号码  第二个为验证码
 */
@property (nonatomic, copy) void(^inputCodeEndBlock)(NSString *phoneNumber,NSString *code);

/**
 成为第一响应者
 */
- (void)isBecomeFirstResponder;

/**
 最后一个输入框成为第一响应者
 */
- (void)isLastBecomeFirstResponder;

/**
 释放第一响应着
 */
- (void)resignTheFirstResponder;

@end
