//
//  CountdownView.m
//  倒计时View
//
//  Created by 贾远潮 on 2017/12/7.
//  Copyright © 2017年 贾远潮. All rights reserved.
//

#import "CountdownView.h"
#import "BossBasicDefine.h"
@interface CountdownView ()

@property (nonatomic, assign) NSInteger countTime;

@property (nonatomic, assign) NSInteger realTime;

@property (nonatomic, strong) UIButton *sendMsgButton;

@property (nonatomic, strong) UILabel *countDownLabel;

@property (nonatomic, strong) NSTimer *countDownTimer;

@end

@implementation CountdownView

- (instancetype)initWithFrame:(CGRect)frame countTime:(NSInteger)countTime
{
    if (self = [super initWithFrame:frame]) {
        _countTime = countTime;
        _realTime = countTime;
        _countViewStatus = CountViewStatusNomal;
        [self addSubview:self.sendMsgButton];
        [self addSubview:self.countDownLabel];
        [self changeTheButtonStatus];
//        self.layer.masksToBounds = YES;
//        self.layer.cornerRadius = 2;
    }
    return self;
}

- (void)changeTheButtonStatus
{
    if (self.countViewStatus == CountViewStatusCounting) {
//        self.sendMsgButton.layer.borderColor = kHexRGB(0Xe0e0e0).CGColor;
//        self.sendMsgButton.backgroundColor = kHexRGB(0Xe0e0e0);
//        [self.sendMsgButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        self.sendMsgButton.enabled = NO;
        self.sendMsgButton.hidden = YES;
        self.countDownLabel.hidden = NO;
    } else if(self.countViewStatus == CountViewStatusNomal){
        self.sendMsgButton.hidden = NO;
        self.countDownLabel.hidden = YES;
        self.sendMsgButton.layer.borderColor = kHexRGBA(0x000000, 0.4).CGColor;
        self.sendMsgButton.layer.borderWidth = 0.5f;
//        self.sendMsgButton.backgroundColor = kColoWhite;
        [self.sendMsgButton setTitleColor:kHexRGBA(0x000000, 0.4) forState:UIControlStateNormal];
        self.sendMsgButton.enabled = YES;
        [self.sendMsgButton setTitle:@"重发验证码" forState:UIControlStateNormal];
    } else if(self.countViewStatus == CountViewStatusBegainCount){
        self.sendMsgButton.hidden = NO;
        self.countDownLabel.hidden = YES;
        self.sendMsgButton.layer.borderColor = kHexRGBA(0x000000, 0.4).CGColor;
        self.sendMsgButton.layer.borderWidth = 0.5f;
//        self.sendMsgButton.backgroundColor = kColoWhite;
        [self.sendMsgButton setTitleColor:kHexRGBA(0x000000, 0.4) forState:UIControlStateNormal];
        self.sendMsgButton.enabled = NO;
        [self.sendMsgButton setTitle:@"发送中..." forState:UIControlStateNormal];
    }
}

- (void)updateCountDownButtonTitle
{
    if (self.countViewStatus == CountViewStatusCounting) {
        if (self.realTime >= 0) {
            NSString *title = [NSString stringWithFormat:@"%ld",self.realTime];
            self.countDownLabel.text = title;
//            [self.sendMsgButton setTitle:title forState:UIControlStateNormal];
        }
    }
}

- (void)updateRemaindTime:(NSTimer *)timer
{
    
    if (self.realTime >= 2) {
        self.realTime -= 1;
        [self updateCountDownButtonTitle];
    } else {
        self.countViewStatus = CountViewStatusNomal;
        [self changeTheButtonStatus];
        [self stopCounting];
        if (self.delegate && [self.delegate respondsToSelector:@selector(timeCountDownViewDidFinishedCountDown:)]) {
            [self.delegate timeCountDownViewDidFinishedCountDown:self];
        }
    }
}

- (void)count {
    [self stopCounting];
    self.realTime = self.countTime;
    [self updateCountDownButtonTitle];
    [self startCount];
    if (self.delegate && [self.delegate respondsToSelector:@selector(timeCountDownViewDidStartCount:)]) {
        [self.delegate timeCountDownViewDidStartCount:self];
    }
}

- (void)startCount
{
    self.countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateRemaindTime:) userInfo:nil repeats:YES];
}

- (void)stopCounting {
    if (self.countDownTimer && [self.countDownTimer isValid]) {
        [self.countDownTimer invalidate];
        self.countDownTimer = nil;
    }
}


#pragma mark  -----点击事件
- (void)clickTheCountDownButton:(UIButton *)button
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(timeCountDownViewWillStartCount:)]) {
        [self.delegate timeCountDownViewWillStartCount:self];
    }
}

- (void)setCountViewStatus:(CountViewStatus)countViewStatus
{
    _countViewStatus = countViewStatus;
    if (countViewStatus == CountViewStatusCounting) {
        [self count];
    } else if (countViewStatus == CountViewStatusNomal) {
        [self stopCounting];
    }
    [self changeTheButtonStatus];
}

#pragma mark  -----懒加载
- (UIButton *)sendMsgButton
{
    if (_sendMsgButton == nil) {
        _sendMsgButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _sendMsgButton.frame = CGRectMake((self.width - 90) / 2.0, (self.height - 30) / 2.0, 90, 30);
        _sendMsgButton.titleLabel.font = BossRegularFont(14.f);
        _sendMsgButton.layer.cornerRadius = 4.f;
//        _sendMsgButton.layer.masksToBounds = YES;
        [_sendMsgButton addTarget:self action:@selector(clickTheCountDownButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sendMsgButton;
}

- (UILabel *)countDownLabel
{
    if (!_countDownLabel) {
        _countDownLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, (self.height - 49) / 2.0, self.width, 49)];
        _countDownLabel.font = BossRegularFont(35.f);
        _countDownLabel.textColor = kHexRGBA(0x000000, 0.6);
        _countDownLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _countDownLabel;
}

@end

