//
//  CodeView.h
//  验证码View - 六个框框
//
//  Created by 贾远潮 on 2017/12/20.
//  Copyright © 2017年 贾远潮. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CodeView : UIView

- (__kindof CodeView *)initWithFrame:(CGRect)frame
                           maxNumber:(NSInteger)maxNumber;

/**
 点击了下一步的回调，回调中两个参数第一个为手机号码  第二个为验证码
 */
@property (nonatomic, copy) void(^inputCodeEndBlock)(NSString *code);

/**
 第一个输入框成为第一响应者
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
