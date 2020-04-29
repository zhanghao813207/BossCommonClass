//
//  InputCodeView.h
//  验证码输入页
//
//  Created by 贾远潮 on 2017/12/20.
//

#import <UIKit/UIKit.h>

UIKIT_EXTERN CGFloat const kInputCodeViewHeight;
@class InputCodeView;

/**
 倒计时状态

 - InputCodeViewStatusNomal: 默认状态
 - InputCodeViewStatusBegainCount: 开始倒计时
 - InputCodeViewStatusCounting: 倒计时中
 */
typedef NS_ENUM(NSInteger, InputCodeViewStatus) {
    InputCodeViewStatusNomal,
    InputCodeViewStatusBegainCount,
    InputCodeViewStatusCounting,
};

/**
 验证码输入代理
 */
@protocol InputCodeViewDelegate <NSObject>

/**
 开始倒计时

 @param inputCodeView 验证码输入View
 */
- (void)inputCodeViewWillStartCount:(InputCodeView *)inputCodeView;

@optional

/**
 倒计时中

 @param inputCodeView 验证码输入View
 */
- (void)inputCodeViewDidStartCount:(InputCodeView *)inputCodeView;

/**
 倒计时结束

 @param inputCodeView 验证码输入View
 */
- (void)inputCodeViewDidFinishedCountDown:(InputCodeView *)inputCodeView;

@end

@interface InputCodeView : UIView

/**
 验证码输入代理
 */
@property (nonatomic, weak) id<InputCodeViewDelegate> delegate;

/**
 倒计时状态
 */
@property (nonatomic, assign) InputCodeViewStatus inputCodeViewStatus;

/**
 手机号
 */
@property (nonatomic, strong) NSString *phoneNumber;

/**
 语音验证码标记
 默认不显示
 */
@property (nonatomic, assign) BOOL showVoiceCode;

/**
 点击语音验证回调
 */
@property (nonatomic, copy) void (^voiceCodeBlock)(void);

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
