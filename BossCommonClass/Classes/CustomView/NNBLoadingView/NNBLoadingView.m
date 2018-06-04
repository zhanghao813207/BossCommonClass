//
//  NNBLoadingView.m
//  NNBar_knight
//
//  Created by 贾远潮 on 2017/9/19.
//  Copyright © 2017年 贾远潮. All rights reserved.
//

#import "NNBLoadingView.h"
#import "JYCAlertView.h"
#import "BossBasicDefine.h"

#define kCurrentViewWidth (self.bounds.size.width)

#define kCurrentViewHeight (self.bounds.size.height)

#define kCurrentWidth(w) (((w) * kCurrentViewWidth) / 375.0f)

@interface NNBLoadingView ()<JYCAlertViewDatasource>

@property (nonatomic, strong) JYCAlertView *alertView;

@property (nonatomic, strong) UIImageView *loadingImageView;


@property (nonatomic, strong) UILabel *statusLabel;

@property (nonatomic, strong) UIView *backGroundView;



//@property (nonatomic, strong) NSArray *loadingImageArray;

@end

@implementation NNBLoadingView

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
    return self.backGroundView;

}

#pragma mark -- view的展示取消
- (void)showNNBLoadingViews:(NSString *)status;
{
    if (status) {
        self.statusLabel.text = status;
    }
    [self.alertView showJYCAlertView];
}

- (void)showNNBClearLoadingViews:(NSString *)status
{
    if (status) {
        self.statusLabel.text = status;
    }
    self.backGroundView.backgroundColor = [UIColor clearColor];
    self.statusLabel.textColor = kHexRGBA(0x000000, 0.6);
    self.loadingImageView.image = [UIImage imageNamed:@"grayLoadingIcon"];
    [self.alertView showJYCAlertView];
}

- (void)dismissNNBLoadingViewWithComplettion:(void (^)(BOOL))completion
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
//- (NSArray *)loadingImageArray
//{
//    if (!_loadingImageArray) {
//        _loadingImageArray = @[[UIImage imageNamed:@"loading1"],[UIImage imageNamed:@"loading2"],[UIImage imageNamed:@"loading3"],[UIImage imageNamed:@"loading4"],[UIImage imageNamed:@"loading5"],[UIImage imageNamed:@"loading6"],[UIImage imageNamed:@"loading7"],[UIImage imageNamed:@"loading8"],[UIImage imageNamed:@"loading8"],[UIImage imageNamed:@"loading9"],[UIImage imageNamed:@"loading10"],[UIImage imageNamed:@"loading11"],[UIImage imageNamed:@"loading12"]];
//    }
//    return _loadingImageArray;
//}

- (JYCAlertView *)alertView
{
    if (!_alertView) {
        _alertView = [[JYCAlertView alloc] initWithFrame:self.bounds];
        _alertView.datasource = self;
    }
    return _alertView;
}

-(UIView *)backGroundView
{
    if (!_backGroundView) {
        UIView *backGroundView = [[UIView alloc] initWithFrame:CGRectMake((kCurrentViewWidth - kCurrentWidth(120)) / 2.0, (kCurrentViewHeight - kCurrentWidth(120)) / 2.0, kCurrentWidth(120), kCurrentWidth(120))];
        backGroundView.backgroundColor = kHexRGBA(0x000000, 0.6);
        backGroundView.layer.cornerRadius = 2.f;
        
        [backGroundView addSubview:self.loadingImageView];
        
        [backGroundView addSubview:self.statusLabel];

        _backGroundView = backGroundView;
    }
    return _backGroundView;

}

- (UILabel *)statusLabel
{
    if (!_statusLabel) {
        UILabel *loadingLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.loadingImageView.frame) + kCurrentWidth(10), kCurrentWidth(120), 20)];
        loadingLabel.text = @"加载中";
        loadingLabel.textAlignment = NSTextAlignmentCenter;
        loadingLabel.font = BossRegularFont(14.f);
        loadingLabel.textColor = [UIColor whiteColor];
        _statusLabel = loadingLabel;
    }
    return _statusLabel;
}

- (UIImageView *)loadingImageView
{
    if (!_loadingImageView) {
        // 34 34
        UIImageView *loadingImageView = [[UIImageView alloc] initWithFrame:CGRectMake((kCurrentWidth(120) - kCurrentWidth(34)) / 2.0, kCurrentWidth(30), kCurrentWidth(34), kCurrentWidth(34))];
        loadingImageView.image = [UIImage imageNamed:@"loading"];
        
        CABasicAnimation *animation =  [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        //默认是顺时针效果，若将fromValue和toValue的值互换，则为逆时针效果
        animation.fromValue = @(0.f);
        animation.toValue = @(M_PI *2);
        animation.duration  = 1.f;
        animation.autoreverses = NO;
        animation.fillMode =kCAFillModeForwards;
        animation.repeatCount = MAXFLOAT; //如果这里想设置成一直自旋转，可以设置为MAXFLOAT，否则设置具体的数值则代表执行多少次
        [loadingImageView.layer addAnimation:animation forKey:nil];
        _loadingImageView = loadingImageView;
    }
    return _loadingImageView;

}

@end
