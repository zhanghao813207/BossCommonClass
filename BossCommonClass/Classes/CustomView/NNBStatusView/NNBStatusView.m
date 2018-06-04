//
//  NNBStatusView.m
//  NNB
//
//  Created by 贾远潮 on 2017/12/20.
//  Copyright © 2017年 贾远潮. All rights reserved.
//

#import "NNBStatusView.h"
#import "JYCAlertView.h"
#import "BossBasicDefine.h"

@interface NNBStatusView()<JYCAlertViewDatasource>

@property (nonatomic, strong) JYCAlertView *alertView;

@property (nonatomic, strong) UIView *contentView;

@property (nonatomic, strong) UILabel *statusLabel;

@property (nonatomic, strong) UIImageView *successImageView;

@end

@implementation NNBStatusView

#pragma mark -- 初始化方法
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.alertView.BGColor = [UIColor clearColor];
        [self addSubview:self.alertView];
    }
    return self;
}

#pragma mark -- alertViewDatasource
- (UIView *)JYCAlertView:(JYCAlertView *)alertView
{
    return self.contentView;
}

#pragma mark -- view的展示取消
- (void)showStatus:(NSString *)title
{
    self.statusLabel.text = title;
    [self layoutWithTitle:title success:NO];
    [self.alertView showJYCAlertView];
}

- (void)showSuccessStatus:(NSString *)title
{
    self.statusLabel.text = title;
    [self layoutWithTitle:title success:YES];
    [self.alertView showJYCAlertView];
}

- (void)dismissWithComplettion:(void (^)(BOOL))completion
{
    [self.alertView dismissJYCAlertViewWithCompletion:^(BOOL finish) {
        [self removeFromSuperview];
        self.alertView = nil;
        if (completion) {
            completion(finish);
        }
    }];
}

- (void)layoutWithTitle:(NSString *)title success:(BOOL)success
{
    CGFloat labelMaxWidth = success ? kScreenWidth * 2 / 3.0 - 14 - 30 : kScreenWidth * 2 / 3.0 - 20;
    CGSize size = [title sizeOfStringWithFont:BossRegularFont(14.f) maxSize:CGSizeMake(labelMaxWidth, 200)];
    self.contentView.width = success ? size.width + 14 + 30 : size.width + 20;
    self.contentView.height = size.height + 10;
    self.contentView.center = self.center;
    
    if (success) {
        self.successImageView.hidden = NO;
        self.successImageView.x = 10;
        self.successImageView.y = (self.contentView.height - 14) / 2.0;
        
        self.statusLabel.frame = CGRectMake(CGRectGetMaxX(self.successImageView.frame) + 10, (self.contentView.height - size.height) / 2.0, size.width, size.height);
    } else {
        self.successImageView.hidden = YES;
        self.statusLabel.frame = CGRectMake(10, (self.contentView.height - size.height) / 2.0, size.width, size.height);
    }
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
        _contentView = [[UIView alloc] initWithFrame:CGRectMake(kScreenWidth / 6.0, (self.height - 35) / 2.0, kScreenWidth * 2 / 3.0, 35)];
        _contentView.backgroundColor = kHexRGB(0x9D9D9D);
        [_contentView addSubview:self.successImageView];
        [_contentView addSubview:self.statusLabel];
    }
    return _contentView;
}

- (UIImageView *)successImageView
{
    if (!_successImageView) {
        _successImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 14, 14)];
        _successImageView.image = [[UIImage imageNamed:@"successStatusIcon"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        _successImageView.hidden = YES;
    }
    return _successImageView;
}

- (UILabel *)statusLabel
{
    if (!_statusLabel) {
        _statusLabel = [[UILabel alloc] init];
        _statusLabel.font = BossRegularFont(14.f);
        _statusLabel.textColor = [UIColor whiteColor];
        _statusLabel.numberOfLines = 0;
    }
    return _statusLabel;
}

@end
