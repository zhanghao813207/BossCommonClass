//
//  InputCodeView.m
//  输入验证码View
//
//  Created by 贾远潮 on 2017/12/20
//

#import "InputCodeView.h"
#import "CodeView.h"
#import "CountdownView.h"
#import "BossBasicDefine.h"

/**
 输入验证码View高度
 */
CGFloat const kInputCodeViewHeight = 242;

@interface InputCodeView()<CountdownViewDelegate>

@property (nonatomic, strong) UILabel *sendPhoneNumberLabel;

@property (nonatomic, strong) UILabel *inputCodeNoticeLabel;

@property (nonatomic, strong) CodeView *codeView;

@property (nonatomic, strong) CountdownView *countDownView;

@property (nonatomic, strong) UIButton *voiceCodeButton;

@end

@implementation InputCodeView

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self addSubview:self.sendPhoneNumberLabel];
        [self addSubview:self.inputCodeNoticeLabel];
        [self addSubview:self.codeView];
        [self addSubview:self.countDownView];
        [self addSubview:self.voiceCodeButton];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.sendPhoneNumberLabel];
        [self addSubview:self.inputCodeNoticeLabel];
        [self addSubview:self.codeView];
        [self addSubview:self.countDownView];
        [self addSubview:self.voiceCodeButton];
    }
    return self;
}

- (void)setPhoneNumber:(NSString *)phoneNumber
{
    if (_phoneNumber != phoneNumber) {
        _phoneNumber = phoneNumber;
        self.sendPhoneNumberLabel.text = [NSString stringWithFormat:@"验证码已发送到 %@",phoneNumber];
    }
}

- (void)setInputCodeViewStatus:(InputCodeViewStatus)inputCodeViewStatus
{
    _inputCodeViewStatus = inputCodeViewStatus;
    switch (inputCodeViewStatus) {
        case InputCodeViewStatusNomal:
            self.countDownView.countViewStatus = CountViewStatusNomal;
            break;
        case InputCodeViewStatusBegainCount:
            self.countDownView.countViewStatus = CountViewStatusBegainCount;
            break;
        case InputCodeViewStatusCounting:
            self.countDownView.countViewStatus = CountViewStatusCounting;
            break;
        default:
            break;
    }
}

/**
 成为第一响应者
 */
- (void)isBecomeFirstResponder
{
    [self.codeView isBecomeFirstResponder];
}

/**
 释放第一响应着
 */
- (void)resignTheFirstResponder
{
    [self.codeView resignTheFirstResponder];
}

/**
 最后输入框成为第一响应者
 */
- (void)isLastBecomeFirstResponder
{
    [self.codeView isLastBecomeFirstResponder];
}

- (void)setShowVoiceCode:(BOOL)showVoiceCode
{
    _showVoiceCode = showVoiceCode;
    self.voiceCodeButton.hidden = !showVoiceCode;
}

- (void)voiceCodeButtonAction:(UIButton *)sender
{
    DLog(@"语音验证码按钮被点击");
    if (self.voiceCodeBlock) {
        self.voiceCodeBlock();
    }
}

#pragma mark  -----CountDownDelegete
- (void)timeCountDownViewWillStartCount:(CountdownView *)countView
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(inputCodeViewWillStartCount:)]) {
        [self.delegate inputCodeViewWillStartCount:self];
    }
}



- (UILabel *)sendPhoneNumberLabel
{
    if (!_sendPhoneNumberLabel) {
        CGFloat y = IsPhone_Size_4 ? 8 : 18;
        _sendPhoneNumberLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, y, kScreenWidth - 40, 16)];
        _sendPhoneNumberLabel.textColor = kHexRGBA(0x000000, 0.4);
        _sendPhoneNumberLabel.font = BossRegularFont(16.f);
    }
    return _sendPhoneNumberLabel;
}

- (UILabel *)inputCodeNoticeLabel
{
    if (!_inputCodeNoticeLabel) {
        _inputCodeNoticeLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(self.sendPhoneNumberLabel.frame) + 10, kScreenWidth - 40, 22)];
        _inputCodeNoticeLabel.font = BossRegularFont(16.f);
        _inputCodeNoticeLabel.textColor = kHexRGBA(0x000000, 0.2);
        _inputCodeNoticeLabel.text = @"输入验证码";
    }
    return _inputCodeNoticeLabel;
}


- (CodeView *)codeView
{
    if (!_codeView) {
        CGFloat height = IsPhone_Size_4 ? 40 : 47;
        _codeView = [[CodeView alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(self.inputCodeNoticeLabel.frame) + 10, kScreenWidth - 40, height) maxNumber:6];
        WS(weakSelf);
        [_codeView setInputCodeEndBlock:^(NSString *code) {
            NSString *phoneNumber = [weakSelf.phoneNumber stringByReplacingOccurrencesOfString:@" " withString:@""];
            if (weakSelf.inputCodeEndBlock) {
                weakSelf.inputCodeEndBlock(phoneNumber, code);
            }
        }];
        
    }
    return _codeView;
}

- (CountdownView *)countDownView
{
    if (_countDownView == nil) {
        CGFloat y = IsPhone_Size_4 ? CGRectGetMaxY(self.codeView.frame) : CGRectGetMaxY(self.codeView.frame) + 25;
        _countDownView = [[CountdownView alloc] initWithFrame:CGRectMake((kScreenWidth - 100) / 2.0, y, 100, 50) countTime:60];
        _countDownView.delegate = self;
    }
    return _countDownView;
}


/**
 初始化语音验证码按钮

 @return 语音验证码
 */
- (UIButton *)voiceCodeButton
{
    if (!_voiceCodeButton) {
        CGFloat y = IsPhone_Size_4 ? CGRectGetMaxY(self.codeView.frame) + 60 : CGRectGetMaxY(self.codeView.frame) + 105;
        _voiceCodeButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _voiceCodeButton.frame = CGRectMake(20, y, kScreenWidth - 40, 14);
        _voiceCodeButton.titleLabel.font = BossRegularFont(14.f);
        [_voiceCodeButton setTitle:@"收不到验证码？试一试语音验证码" forState:UIControlStateNormal];
        [_voiceCodeButton setTitleColor:kHexRGB(0x000000) forState:UIControlStateNormal];
        [_voiceCodeButton setImage:[[UIImage imageNamed:@"voiceIcon"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
        _voiceCodeButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        CGFloat width = IsPhone_Size_4 ? 15 * 12 + 5 : 15 * 14 + 5;
        _voiceCodeButton.imageEdgeInsets = UIEdgeInsetsMake(0, width, 0, -width);
        _voiceCodeButton.titleEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 10);
        [_voiceCodeButton addTarget:self action:@selector(voiceCodeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        _voiceCodeButton.hidden = YES;
    }
    return _voiceCodeButton;
}


@end
