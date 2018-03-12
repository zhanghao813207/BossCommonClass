//
//  SignView.m
//  NNBarKnight
//
//  Created by 贾远潮 on 2017/10/16.
//  Copyright © 2017年 贾远潮. All rights reserved.
//

#import "SignView.h"
#import "JYCDrawPathView.h"
#import "JYCAlertView.h"
#import "JYCSimpleToolClass.h"
#import "QHErrorView.h"
#import "BossBasicDefine.h"

@interface SignView()<JYCAlertViewDatasource>

@property (nonatomic, strong) JYCAlertView *alertView;

@property (nonatomic, strong) JYCDrawPathView *signView;

@property (nonatomic, strong) UIButton *confirmButton;

@property (nonatomic, strong) UIButton *resetButton;


@end

@implementation SignView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.alertView];
    }
    return self;
}

#pragma mark --clickMethod

- (void)resetButtonAction:(UIButton *)sender
{
    [self.signView clearPath];
}

- (void)confirmButtonAction:(UIButton *)sender
{
    if (self.confirmSignBlock) {
        if ([self.signView canRepeal]) {
            self.confirmSignBlock();
        } else {
            [[[QHErrorView alloc] initWithTitle:@"请先签名再确认"] showInView:self];
        }
    }
}

#pragma mark -- view的展示取消
- (void)show
{
    [self.alertView showJYCAlertView];
}

- (void)dismissWithCompletion:(void(^)(BOOL complete))completionBlcok
{
    [self.alertView dismissJYCAlertViewWithCompletion:^(BOOL finish) {
        [self removeFromSuperview];
        self.alertView = nil;
        if (completionBlcok) {
            completionBlcok(finish);
        }
    }];
}

#pragma mark --datasource
- (UIView *)JYCAlertView:(JYCAlertView *)alertView
{
    UIView *BGView = [[UIView alloc] initWithFrame:self.bounds];
    [BGView addSubview:self.signView];
    
    [BGView addSubview:self.resetButton];
    [BGView addSubview:self.confirmButton];
    
    return BGView;
}

#pragma makr -- lazy property
- (JYCAlertView *)alertView
{
    if (!_alertView) {
        _alertView = [[JYCAlertView alloc] initWithFrame:self.bounds];
        _alertView.datasource = self;
        _alertView.animationType = JYCAlertViewAnimationTypeFadeInAndFadeOut;
    }
    return _alertView;
}

- (JYCDrawPathView *)signView
{
    if (!_signView) {
        _signView = [[JYCDrawPathView alloc] initWithFrame:self.bounds];
        _signView.backgroundColor = kHexRGBA(0x000000, 0.3);
        _signView.pathColor = [UIColor whiteColor];
        _signView.pathWidth = 2.f;
    }
    return _signView;
}

- (UIButton *)resetButton
{
    if (!_resetButton) {
        _resetButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _resetButton.frame = CGRectMake(kScreenWidth / 2.0 - 60 - 30, kScreenHeight - 60 - 20, 60, 60);
        [_resetButton setBackgroundImage:[UIImage imageNamed:@"sign_reset"] forState:UIControlStateNormal];
        [_resetButton addTarget:self action:@selector(resetButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _resetButton;
}

- (UIButton *)confirmButton
{
    if (!_confirmButton) {
        _confirmButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _confirmButton.frame = CGRectMake(kScreenWidth / 2.0 + 30, kScreenHeight - 60 - 20, 60, 60);
        [_confirmButton setBackgroundImage:[UIImage imageNamed:@"sign_confirm"] forState:UIControlStateNormal];
        [_confirmButton addTarget:self action:@selector(confirmButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _confirmButton;
}


@end
