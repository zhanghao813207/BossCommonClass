//
//  BossLoadingView.m
//  Bossar_knight
//
//  Created by 贾远潮 on 2017/9/19.
//  Copyright © 2017年 贾远潮. All rights reserved.
//

#import "BossLoadView.h"
#import "JYCAlertView.h"
#import "BossBasicDefine.h"
#define kCurrentViewWidth (self.bounds.size.width)

#define kCurrentViewHeight (self.bounds.size.height)

#define kCurrentWidth(w) (((w) * kCurrentViewWidth) / 375.0f)

@interface BossLoadView ()<JYCAlertViewDatasource>

@property (nonatomic, strong) JYCAlertView *alertView;

@property (nonatomic, strong) UIImageView *loadingImageView;

@property (nonatomic, strong) UILabel *statusLabel;

@property (nonatomic, strong) UIView *backGroundView;

@property (nonatomic, strong) UIView *contentView;

@property (nonatomic, strong) NSArray *loadingImageArray;

@property (nonatomic, strong) NSTimer *imageTimer;

@property (nonatomic, assign) NSInteger index;

@end

@implementation BossLoadView

@synthesize BGColor = _BGColor;

#pragma mark -- 初始化方法
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self addSubview:self.alertView];
    }
    return self;
}


#pragma mark -- alertViewDatasource
- (UIView *)JYCAlertView:(JYCAlertView *)alertView
{
    alertView.backgroundColor = [UIColor clearColor];
    alertView.BGColor = self.BGColor;
    alertView.maskAlpha = 0.f;
    return self.contentView;
}

#pragma mark -- view的展示取消
- (void)showBossLoadViews:(NSString *)status;
{
    if (status) {
        self.statusLabel.text = status;
    }
    self.backGroundView.backgroundColor = [UIColor clearColor];
    [self.alertView showJYCAlertView];
}

- (void)showBossClearLoadingViews:(NSString *)status
{
    if (status) {
        self.statusLabel.text = status;
    }
    self.backGroundView.backgroundColor = [UIColor clearColor];
    [self.alertView showJYCAlertView];
}

- (void)dismissBossLoadViewWithComplettion:(void (^)(BOOL))completion
{
    [self.alertView dismissJYCAlertViewWithCompletion:^(BOOL finish) {
        [self removeFromSuperview];
        self.alertView = nil;
        if (completion) {
            completion(finish);
        }
    }];
}

#pragma mark -- 重新setter和getter
- (UIColor *)BGColor
{
    if (!_BGColor) {
        _BGColor = kHexRGB(0xf4f4f4);
    }
    return _BGColor;
}

- (void)setBGColor:(UIColor *)BGColor
{
    if (_BGColor != BGColor) {
        _BGColor = BGColor;
        self.alertView.BGColor = BGColor;
    }
}


#pragma mark -- 懒加载
- (NSArray *)loadingImageArray
{
    if (!_loadingImageArray) {
        _loadingImageArray = @[[UIImage imageNamed:@"loading01"],[UIImage imageNamed:@"loading02"],[UIImage imageNamed:@"loading03"]                               ];
    }
    return _loadingImageArray;
}

- (JYCAlertView *)alertView
{
    if (!_alertView) {
        _alertView = [[JYCAlertView alloc] initWithFrame:self.bounds];
        _alertView.datasource = self;
    }
    return _alertView;
}

- (UIView *)contentView
{
    if (!_contentView) {
        _contentView = [[UIView alloc] initWithFrame:CGRectMake((kCurrentViewWidth - kCurrentWidth(110)) / 2.0, (kCurrentViewHeight - kCurrentWidth(110)) / 2.0, kCurrentWidth(110), kCurrentWidth(110))];
        _contentView.backgroundColor = [UIColor clearColor];
        
        [_contentView addSubview:self.backGroundView];
        
        [_contentView addSubview:self.loadingImageView];
        
        [_contentView addSubview:self.statusLabel];
        
    }
    return _contentView;
}

-(UIView *)backGroundView
{
    if (!_backGroundView) {
        _backGroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kCurrentWidth(110), kCurrentWidth(110))];
        _backGroundView.backgroundColor = [UIColor whiteColor];
        _backGroundView.alpha = 0.9;
        _backGroundView.layer.cornerRadius = 2.f;
    }
    return _backGroundView;
    
}

- (UIImageView *)loadingImageView
{
    if (!_loadingImageView) {
        _loadingImageView = [[UIImageView alloc] initWithFrame:CGRectMake((self.contentView.width - kCurrentWidth(43)) / 2.0, 60, kCurrentWidth(43), kCurrentWidth(10))];
        _loadingImageView.backgroundColor = [UIColor clearColor];
        _loadingImageView.image = [UIImage imageNamed:@"loading01"];
//        _loadingImageView.animationImages = self.loadingImageArray;
//        _loadingImageView.animationRepeatCount = 0;
//        _loadingImageView.animationDuration = 0.75f;
//        [_loadingImageView startAnimating];
        [self.imageTimer fire];
    }
    return _loadingImageView;
}


- (UILabel *)statusLabel
{
    if (!_statusLabel) {
        _statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.loadingImageView.frame), self.contentView.width, 20)];
        _statusLabel.text = @"加载中";
        _statusLabel.textAlignment = NSTextAlignmentCenter;
        _statusLabel.font = BossRegularFont(14.f);
        _statusLabel.textColor = kHexRGBA(0x000000, 0.4);
    }
    return _statusLabel;
}

- (NSTimer *)imageTimer
{
    if (!_imageTimer) {
        _imageTimer = [NSTimer scheduledTimerWithTimeInterval:0.25 target:self selector:@selector(nextImage) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:_imageTimer forMode:NSRunLoopCommonModes];
    }
    return _imageTimer;
}

- (void)nextImage
{
    self.loadingImageView.image = self.loadingImageArray[self.index];
    self.index++;
    if (self.index > self.loadingImageArray.count - 1) {
        self.index = 0;
    }
}

@end
