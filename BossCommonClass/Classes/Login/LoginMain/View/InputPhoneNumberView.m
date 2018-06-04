//
//  InputPhoneNumberView.m
//  NNB
//
//  Created by 贾远潮 on 2017/12/20.
//  Copyright © 2017年 贾远潮. All rights reserved.
//

#import "InputPhoneNumberView.h"
#import "BossBasicDefine.h"
CGFloat const kInputPhoneNumberViewHeight = 263;

@interface InputPhoneNumberView()<UITextFieldDelegate>

@property (nonatomic, strong) UITextField *phoneTextField;

@property (nonatomic, strong) UIView *line;

@property (nonatomic, strong) UILabel *errorNoticeLabel;

@property (nonatomic, strong) NNBButton *nextStepButton;

@end

@implementation InputPhoneNumberView

@synthesize phoneNumber = _phoneNumber;

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.phoneTextField];
        [self addSubview:self.line];
        [self addSubview:self.errorNoticeLabel];
        [self addSubview:self.nextStepButton];
    }
    return self;
}

- (void)nextStepButtonAction:(UIButton *)sender
{
    DLog(@"下一步");
    NSString *phone = [self.phoneTextField.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (phone.length < 11) {
        self.errorNoticeLabel.hidden = NO;
        return;
    }
    BOOL isPhone = [JYCSimpleToolClass isPhoneStringWithString:phone];
    if (!isPhone) {
        self.errorNoticeLabel.hidden = NO;
        return;
    }
    self.errorNoticeLabel.hidden = YES;
    if (self.nextStepBlock) {
        self.nextStepBlock(phone,self.phoneTextField.text);
    }

}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField.text.length >= 13 && ![string isEqualToString:@""]) {
        return NO;
    }
    if (textField.text.length == 1 && [string isEqualToString:@""]) {
        self.nextStepButton.clickEnable = NO;
        self.errorNoticeLabel.hidden = YES;
    } else {
        self.nextStepButton.clickEnable = YES;
    }
    if ((textField.text.length == 3 || textField.text.length == 8) && ![string isEqualToString:@""]) {
        textField.text = [textField.text stringByAppendingString:@" "];
    }
    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField
{
    self.nextStepButton.clickEnable = NO;
    self.errorNoticeLabel.hidden = YES;
    return YES;
}

- (void)isBecomeFirstResponder
{
    [self.phoneTextField becomeFirstResponder];
}

- (void)resignTheFirstResponder
{
    [self.phoneTextField resignFirstResponder];
}

- (UITextField *)phoneTextField
{
    if (!_phoneTextField) {
        CGFloat Y = IsPhone_Size_4 ? 34 : 70;
        CGFloat height = IsPhone_Size_4 ? 30 : 36;
        _phoneTextField = [[UITextField alloc] initWithFrame:CGRectMake(20, Y, kScreenWidth - 40, height)];
        _phoneTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _phoneTextField.font = BossBlodFont(25.f);
        NSMutableAttributedString *placeholderAttString = [[NSMutableAttributedString alloc] initWithString:@"请输入手机号码"];
        [placeholderAttString addAttributes:@{NSFontAttributeName:BossRegularFont(25.f)} range:NSMakeRange(0, placeholderAttString.length)];
        _phoneTextField.attributedPlaceholder = placeholderAttString;
        _phoneTextField.textColor = kHexRGBA(0x0000000, 0.8);
        _phoneTextField.delegate = self;
        _phoneTextField.keyboardType = UIKeyboardTypeNumberPad;
        _phoneTextField.tintColor = kAppMainColor;
    }
    return _phoneTextField;
}

- (UIView *)line
{
    if (!_line) {
        _line = [[UIView alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(self.phoneTextField.frame) + 10, kScreenWidth - 40, 1)];
        _line.backgroundColor = kHexRGBA(0x000000, 0.2);
    }
    return _line;
}

- (UILabel *)errorNoticeLabel
{
    if (!_errorNoticeLabel) {
        _errorNoticeLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(self.line.frame) + 10, kScreenWidth - 40, 17)];
        _errorNoticeLabel.text = @"您的手机号格式不正确";
        _errorNoticeLabel.font = BossRegularFont(12.f);
        _errorNoticeLabel.textColor = kHexRGBA(0xD0021B, 0.4);
        _errorNoticeLabel.hidden = YES;
    }
    return _errorNoticeLabel;
}

- (NNBButton *)nextStepButton
{
    if (!_nextStepButton) {
        CGFloat Y = IsPhone_Size_4 ? kInputPhoneNumberViewHeight - 47 - 63: kInputPhoneNumberViewHeight - 47;
        _nextStepButton = [NNBButton buttonWithFrame:CGRectMake(0, Y, kScreenWidth, 47)];
        _nextStepButton.clickEnable = NO;
        [_nextStepButton setTitle:@"下一步" forState:UIControlStateNormal];
        [_nextStepButton addTarget:self action:@selector(nextStepButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _nextStepButton;
}

- (NSString *)phoneNumber
{
    _phoneNumber = [self.phoneTextField.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    return _phoneNumber;
}


@end
