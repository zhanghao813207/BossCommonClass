//
//  NNBLoadStatusView.m
//  NNB
//
//  Created by 贾远潮 on 2017/12/21.
//

#import "NNBLoadStatusView.h"
#import "JYCAlertView.h"
#import "BossBasicDefine.h"
@interface NNBLoadStatusView()<JYCAlertViewDatasource>

@property (nonatomic, strong) JYCAlertView *alertView;

@property (nonatomic, strong) UIView *contentView;

@property (nonatomic, strong) UILabel *statusLabel;

@property (nonatomic, strong) UIImageView *loadingImageView;

@end

@implementation NNBLoadStatusView

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
    return self.contentView;
}

- (void)showLoadingStatus:(NSString *)status
{
    self.contentView.backgroundColor = [UIColor whiteColor];
    self.statusLabel.text = status;
    self.statusLabel.textColor = kHexRGB(0x000000);
    self.loadingImageView.image = [[UIImage imageNamed:@"loadingStatusIcon"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [self layoutWithTitle:status success:YES];
    self.alertView.isBlur = YES;
    [self.alertView showJYCAlertView];
}

- (void)showClearLoadingStatus:(NSString *)status
{
    self.contentView.backgroundColor = [UIColor whiteColor];
    self.statusLabel.text = status;
    self.statusLabel.textColor = kHexRGB(0x000000);
    self.loadingImageView.image = [[UIImage imageNamed:@"loadingStatusIcon"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [self layoutWithTitle:status success:YES];
    self.alertView.isBlur = NO;
    [self.alertView showJYCAlertView];
}

- (void)showGrayLoadingStatus:(NSString *)status
{
    self.contentView.backgroundColor = kHexRGBA(0x000000, 0.5);
    self.statusLabel.text = status;
    self.statusLabel.textColor = kHexRGB(0xffffff);
    self.loadingImageView.image = [[UIImage imageNamed:@"loadingStatusWhiteIcon"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [self layoutWithTitle:status success:YES];
    self.alertView.isBlur = NO;
    [self.alertView showJYCAlertView];
}

- (void)dismissNNBLoadingStatusViewWithCompletion:(void (^)(BOOL))completion
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
    CGSize size = CGSizeMake(0, 0);
    if (title && ![title isEqualToString:@""]) {
        CGFloat labelMaxWidth = success ? kScreenWidth * 2 / 3.0 - 16 - 50 - 5 : kScreenWidth * 2 / 3.0 - 50;
        size = [title sizeOfStringWithFont:BossRegularFont(16.f) maxSize:CGSizeMake(labelMaxWidth, 200)];
    }
    self.contentView.width = success ? size.width + 16 + 50 + 5 : size.width + 50;
    self.contentView.height = size.height > 0 ? size.height + 13 : 35;
    self.contentView.center = self.center;
    
    if (success) {
        self.loadingImageView.hidden = NO;
        self.loadingImageView.x = 25;
        self.loadingImageView.y = (self.contentView.height - 16) / 2.0;
        
        self.statusLabel.frame = CGRectMake(CGRectGetMaxX(self.loadingImageView.frame) + 5, (self.contentView.height - size.height) / 2.0, size.width, size.height);
    } else {
        self.loadingImageView.hidden = YES;
        self.statusLabel.frame = CGRectMake(25, (self.contentView.height - size.height) / 2.0, size.width, size.height);
    }
}

- (JYCAlertView *)alertView
{
    if (!_alertView) {
        _alertView = [[JYCAlertView alloc] initWithFrame:self.bounds];
        _alertView.datasource = self;
        self.alertView.BGColor = [UIColor clearColor];
    }
    return _alertView;
}

- (UIView *)contentView
{
    if (!_contentView) {
        _contentView = [[UIView alloc] initWithFrame:CGRectMake(kScreenWidth / 6.0, (self.height - 35) / 2.0, kScreenWidth * 2 / 3.0, 35)];
        [_contentView addSubview:self.loadingImageView];
        [_contentView addSubview:self.statusLabel];
    }
    return _contentView;
}

- (UIImageView *)loadingImageView
{
    if (!_loadingImageView) {
        _loadingImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 16, 16)];
        
        CABasicAnimation *animation =  [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        //默认是顺时针效果，若将fromValue和toValue的值互换，则为逆时针效果
        animation.fromValue = @(0.f);
        animation.toValue = @(M_PI *2);
        animation.duration  = 1.f;
        animation.autoreverses = NO;
        animation.fillMode = kCAFillModeForwards;
        animation.repeatCount = MAXFLOAT; //如果这里想设置成一直自旋转，可以设置为MAXFLOAT，否则设置具体的数值则代表执行多少次
        [_loadingImageView.layer addAnimation:animation forKey:nil];
    }
    return _loadingImageView;
}

- (UILabel *)statusLabel
{
    if (!_statusLabel) {
        _statusLabel = [[UILabel alloc] init];
        _statusLabel.font = BossRegularFont(16.f);
        _statusLabel.numberOfLines = 0;
    }
    return _statusLabel;
}


@end
