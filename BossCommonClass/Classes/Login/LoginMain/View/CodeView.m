//
//  CodeView.m
//  NNB
//
//  Created by 贾远潮 on 2017/12/20.
//  Copyright © 2017年 贾远潮. All rights reserved.
//

#import "CodeView.h"
#import "NNBBasicDefine.h"
@interface CodeView()<UITextFieldDelegate>

@property (nonatomic, strong) NSMutableArray *textArray;

@property (nonatomic, strong) NSString *codeString;

@end

@implementation CodeView

- (__kindof CodeView *)initWithFrame:(CGRect)frame
                           maxNumber:(NSInteger)maxNumber
{
    if (self = [super initWithFrame:frame]) {
        if (maxNumber < 1) {
            return self;
        }
        
        [self.textArray removeAllObjects];
        CGFloat marginAll = (self.width - self.height * maxNumber);
        CGFloat margin = marginAll > 0 ? marginAll / (maxNumber - 1) : 0;
        for (NSInteger i = 0; i < maxNumber; i++) {
            UITextField *codeTextField = [[UITextField alloc] initWithFrame:CGRectMake((self.height + margin) * i, 0, self.height, self.height)];
            codeTextField.layer.cornerRadius = 2.f;
            codeTextField.layer.borderColor = kHexRGBA(0x000000, 0.6).CGColor;
            codeTextField.layer.borderWidth = 0.5f;
            codeTextField.textAlignment = NSTextAlignmentCenter;
            codeTextField.delegate = self;
            codeTextField.tag = 1000 + i;
            codeTextField.font = NNBBlodFont(25.f);
            codeTextField.textColor = kHexRGBA(0x000000, 0.8);
            codeTextField.keyboardType = UIKeyboardTypeNumberPad;
            codeTextField.tintColor = kMainColor;
            [self addSubview:codeTextField];
            [self.textArray addObject:codeTextField];
        }
    }
    return self;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField.text.length > 0) {
        return NO;
    }
    NSInteger index = textField.tag - 1000;
    if (index > 0) {
        for (NSInteger i = 0; i < index; i++) {
            UITextField *textField = self.textArray[i];
            if (textField.text.length == 0) {
                return NO;
            }
        }
    }
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField.text.length >= 1 && ![string isEqualToString:@""]) {
        NSInteger index = textField.tag - 1000;
        if (index + 2 < self.textArray.count) {
            UITextField *textField = self.textArray[index + 1];
            textField.text = string;
            UITextField *firstTextField = self.textArray[index + 2];
            [firstTextField performSelector:@selector(becomeFirstResponder) withObject:nil afterDelay:0.1];
        } else if (index + 2 == self.textArray.count){
            UITextField *textField = self.textArray[index + 1];
            textField.text = string;
            [textField performSelector:@selector(becomeFirstResponder) withObject:nil afterDelay:0.1];
            [self performSelector:@selector(inputEnd) withObject:nil afterDelay:0.25];
        } else if (index + 1 == self.textArray.count){
            [self performSelector:@selector(inputEnd) withObject:nil afterDelay:0.25];
        }
        return NO;
    } else if(textField.text.length == 0 && ![string isEqualToString:@""]){
        NSInteger index = textField.tag - 1000;
        if (index + 1 < self.textArray.count) {
            UITextField *textField = self.textArray[index + 1];
            [textField performSelector:@selector(becomeFirstResponder) withObject:nil afterDelay:0.1];
        } else if(index + 1 == self.textArray.count) {
            [self performSelector:@selector(inputEnd) withObject:nil afterDelay:0.25];
        }
        return YES;
    } else if (textField.text.length <= 1 && [string isEqualToString:@""]){
        NSInteger index = textField.tag - 1000;
        if (index - 1 >= 0) {
            UITextField *textField = self.textArray[index - 1];
            [textField performSelector:@selector(becomeFirstResponder) withObject:nil afterDelay:0.1];
        }
        return YES;
    }
    return YES;
}

- (void)inputEnd
{
    if (self.inputCodeEndBlock) {
        DLog(@"self.codeString = %@",self.codeString);
        self.inputCodeEndBlock(self.codeString);
    }
}

/**
 第一个输入框成为第一响应者
 */
- (void)isBecomeFirstResponder
{
    if (self.textArray.count > 0) {
        for (UITextField *textField in self.textArray) {
            textField.text = @"";
        }
        UITextField *textField = self.textArray[0];
        [textField becomeFirstResponder];
    }
}


/**
 最后一个输入框成为第一响应者
 */
- (void)isLastBecomeFirstResponder
{
    if (self.textArray.count > 0) {
        UITextField *textField = self.textArray.lastObject;
        [textField becomeFirstResponder];
        for (UITextField *textField in self.textArray) {
            textField.text = @"";
        }
    }
}

/**
 释放第一响应着
 */
- (void)resignTheFirstResponder
{
    [self endEditing:YES];
}

- (NSMutableArray *)textArray
{
    if (!_textArray) {
        _textArray = [NSMutableArray array];
    }
    return _textArray;
}


- (NSString *)codeString
{
    NSString *code = @"";
    for (UITextField *textField in self.textArray) {
        code = [code stringByAppendingFormat:@"%@",textField.text];
    }
    _codeString = code;
    return _codeString;
}


@end
