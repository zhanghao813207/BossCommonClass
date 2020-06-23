//
//  InputMerchantCodeView.m
//  AFNetworking
//
//  Created by 张浩 on 2019/2/18.
//

#import "InputMerchantCodeView.h"
#import "BossBasicDefine.h"
#import "Masonry.h"

CGFloat const kInputMerchantCodeViewHeight = 240;

@interface InputMerchantCodeView ()<UITextFieldDelegate>

/**
 商户号输入框
 */
@property (nonatomic, strong) UITextField *merchantCodeTextField;

/**
 下划线
 */
@property (nonatomic, strong) UIView *line;

/**
 错误提示框
 */
@property (nonatomic, strong) UILabel *errorNoticeLabel;

/**
 下一步按钮
 */
@property (nonatomic, strong) NNBButton *nextStepButton;

@end

@implementation InputMerchantCodeView

@synthesize merchantCode = _merchantCode;

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.merchantCodeTextField];
        [self addSubview:self.line];
        [self addSubview:self.errorNoticeLabel];
        [self addSubview:self.nextStepButton];
    }
    
    [self.merchantCodeTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(IsPhone_Size_4 ? 30 : 36);
        make.left.mas_equalTo(self).with.offset(20);
        make.top.mas_equalTo(self).with.offset(IsPhone_Size_4 ? 34 : 70);
        make.right.mas_equalTo(self).with.offset(-20);
    }];
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(1);
        make.left.mas_equalTo(self).with.offset(20);
    make.top.mas_equalTo(self.merchantCodeTextField.mas_bottom).with.offset(10);
        make.right.mas_equalTo(self).with.offset(-20);
    }];
    
    [self.errorNoticeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(17);
        make.left.mas_equalTo(self).with.offset(20);
        make.top.mas_equalTo(self.line.mas_bottom).with.offset(10);
        make.right.mas_equalTo(self).with.offset(-20);
    }];
    
    return self;
}

- (void)isBecomeFirstResponder
{
    [self.merchantCodeTextField becomeFirstResponder];
}

- (void)resignTheFirstResponder
{
    [self.merchantCodeTextField resignFirstResponder];
}

- (void)setMerchantCode:(NSString *)merchantCode
{
    _merchantCode = merchantCode;
    self.nextStepButton.clickEnable = ![JYCSimpleToolClass stringIsEmpty:merchantCode];
    self.merchantCodeTextField.text = merchantCode;
}

- (void)nextStepButtonAction:(UIButton *)sender
{
    DLog(@"下一步");
    self.errorNoticeLabel.hidden = YES;
    if (self.nextStepBlock) {
        self.nextStepBlock(self.merchantCode);
    }
}

#pragma mark --UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if([string isEqualToString:@""]){ // 删除字符
        self.nextStepButton.clickEnable = textField.text.length > 1;
    }else if(string.length == 1){ // 输入字符
        self.nextStepButton.clickEnable = YES;
    }
    self.errorNoticeLabel.hidden = YES;
    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField
{
    self.nextStepButton.clickEnable = NO;
    self.errorNoticeLabel.hidden = YES;
    return YES;
}

#pragma mark --lazy

- (UITextField *)merchantCodeTextField
{
    if (!_merchantCodeTextField) {
        _merchantCodeTextField = [[UITextField alloc] init];
        _merchantCodeTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _merchantCodeTextField.font = BossBlodFont(25.f);
        NSMutableAttributedString *placeholderAttString = [[NSMutableAttributedString alloc] initWithString:@"请输入商户号"];
        [placeholderAttString addAttributes:@{NSFontAttributeName:BossRegularFont(25.f)} range:NSMakeRange(0, placeholderAttString.length)];
        _merchantCodeTextField.attributedPlaceholder = placeholderAttString;
        _merchantCodeTextField.textColor = [UIColor colorNamed:@"boss_000000-80_FFFFFF-80"];
        _merchantCodeTextField.delegate = self;
        _merchantCodeTextField.keyboardType = UIKeyboardTypeDefault;
        _merchantCodeTextField.tintColor = kAppMainColor;
    }
    return _merchantCodeTextField;
}

- (UIView *)line
{
    if (!_line) {
        _line = [[UIView alloc] init];
        _line.backgroundColor = [UIColor colorNamed:@"boss_000000-20_FFFFFF-20"];
    }
    return _line;
}

- (UILabel *)errorNoticeLabel
{
    if (!_errorNoticeLabel) {
        _errorNoticeLabel = [[UILabel alloc] init];
        _errorNoticeLabel.text = @"错误";
        _errorNoticeLabel.font = BossRegularFont(12.f);
        _errorNoticeLabel.textColor = [UIColor colorNamed:@"boss_D0021B-40_FF2729"];
        _errorNoticeLabel.hidden = YES;
    }
    return _errorNoticeLabel;
}

- (NNBButton *)nextStepButton
{
    if (!_nextStepButton) {
        CGFloat Y = IsPhone_Size_4 ? kInputMerchantCodeViewHeight - 47 - 63: kInputMerchantCodeViewHeight - 47;
        _nextStepButton = [NNBButton buttonWithFrame:CGRectMake(0, Y, kScreenWidth, 47)];
        _nextStepButton.clickEnable = NO;
        [_nextStepButton setTitle:@"下一步" forState:UIControlStateNormal];
        _nextStepButton.backgroundColor = [UIColor colorNamed:@"boss_479CFF_0087FF"];
        [_nextStepButton addTarget:self action:@selector(nextStepButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _nextStepButton;
}

- (NSString *)merchantCode
{
    return self.merchantCodeTextField.text;
}

@end
