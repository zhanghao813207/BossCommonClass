//
//  NNBStatusAnimationView.m
//  NNB
//
//  Created by 贾远潮 on 2018/1/5.
//  Copyright © 2018年 贾远潮. All rights reserved.
//

#import "NNBStatusAnimationView.h"
#import "JYCAlertView.h"
#import "BossBasicDefine.h"

#define kRadius 24

#define kPointX (200)

#define kPointY (300)

#define kMinWidth kIphone6Width(120)

typedef NS_ENUM(NSUInteger, AnimationStatus) {
    AnimationStatusNormal     = 1, // 正常（没有成功或失败）
    AnimationStatusSuccess    = 2, // 成功（对勾动画）
    AnimationStatusError      = 3, // 失败（叉号动画）
};

@interface NNBStatusAnimationView()<JYCAlertViewDatasource>

@property (nonatomic, strong) JYCAlertView *alertView;

@property (nonatomic, strong) UIView *contentView;

@property (nonatomic, strong) UILabel *statusLabel;

@property (nonatomic, assign) CGPoint successPoint;

@property (nonatomic, assign) CGFloat successRadius;

@property (nonatomic, strong) CAShapeLayer *animationLayer;


@end

@implementation NNBStatusAnimationView

#pragma mark -- 初始化方法
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
//        self.alertView.BGColor = [UIColor clearColor];
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
    self.statusLabel.font = BossBlodFont(20);
    [self layoutWithTitle:title status:AnimationStatusNormal];
    self.alertView.animationType = JYCAlertViewAnimationTypeScale;
    self.alertView.contentViewAlpha = 0.7;
    self.alertView.showAnimationDuration = 0.5;
    [self.alertView showJYCAlertView];
}

- (void)showSuccessStatus:(NSString *)title
{
    self.statusLabel.text = title;
    self.statusLabel.font = BossRegularFont(14.f);
    [self layoutWithTitle:title status:AnimationStatusSuccess];
    self.alertView.animationType = JYCAlertViewAnimationTypeFadeInAndFadeOut;
    self.alertView.contentViewAlpha = 1;
    [self.alertView showJYCAlertView];
}

- (void)showErrorStatus:(NSString *)title
{
    self.statusLabel.text = title;
    self.statusLabel.font = BossRegularFont(14.f);
    [self layoutWithTitle:title status:AnimationStatusError];
    self.alertView.animationType = JYCAlertViewAnimationTypeFadeInAndFadeOut;
    self.alertView.contentViewAlpha = 1;
    [self.alertView showJYCAlertView];
}

- (void)dismissWithComplettion:(void (^)(BOOL))completion
{
    if (self.animationLayer) {
        [self.animationLayer removeFromSuperlayer];
    }
    [self.alertView dismissJYCAlertViewWithCompletion:^(BOOL finish) {
        [self removeFromSuperview];
        self.alertView = nil;
        if (completion) {
            completion(finish);
        }
    }];
}

- (void)layoutWithTitle:(NSString *)title status:(AnimationStatus)status
{
    CGFloat labelMaxWidth = kScreenWidth * 2 / 3.0 - 40;
    CGSize size = [title sizeOfStringWithFont:self.statusLabel.font maxSize:CGSizeMake(labelMaxWidth, 200)];
    self.contentView.width = size.width + 40 < kMinWidth ? kMinWidth : size.width + 40;
    self.contentView.height = status != AnimationStatusNormal ? size.height + 48 + 20 + 40 : size.height + 40;
    self.contentView.center = self.center;
    
    if (status == AnimationStatusSuccess || status == AnimationStatusError) {
        self.statusLabel.frame = CGRectMake(20, 20 + 48 + (self.contentView.height - size.height - 48 - 20) / 2.0, self.contentView.width - 40, size.height);
        self.statusLabel.textAlignment = NSTextAlignmentCenter;
        self.successPoint = CGPointMake(self.contentView.center.x, self.contentView.y + 24 + 20);
        self.successRadius = 24;
        switch (status) {
            case AnimationStatusSuccess:
                [self performSelector:@selector(drawSuccessWithPoint:Radius:) withObject:nil afterDelay:0.25f];
                break;
             case AnimationStatusError:
                [self performSelector:@selector(drawErrorWithPoint:Radius:) withObject:nil afterDelay:0.25f];
                break;
            default:
                break;
        }
    } else {
        self.statusLabel.frame = CGRectMake(20, (self.contentView.height - size.height) / 2.0, self.contentView.width - 40, size.height);
        self.statusLabel.textAlignment = NSTextAlignmentLeft;
    }
}

- (JYCAlertView *)alertView
{
    if (!_alertView) {
        _alertView = [[JYCAlertView alloc] initWithFrame:self.bounds];
        _alertView.datasource = self;
        _alertView.BGColor = [UIColor clearColor];
    }
    return _alertView;
}

- (UIView *)contentView
{
    if (!_contentView) {
        _contentView = [[UIView alloc] initWithFrame:CGRectMake(kScreenWidth / 6.0, (self.height - 35) / 2.0, kScreenWidth * 2 / 3.0, 35)];
        _contentView.backgroundColor = kHexRGBA(0x000000, 0.6);
        _contentView.layer.cornerRadius = 4.f;
        [_contentView addSubview:self.statusLabel];
    }
    return _contentView;
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

- (void)drawErrorWithPoint:(CGPoint)point Radius:(CGFloat)radius
{
    point = self.successPoint;
    radius = self.successRadius;
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:point radius:radius startAngle:M_PI / 9 * 2 endAngle:2 * M_PI + M_PI / 9 * 3 clockwise:NO];
    //对号第一部分直线的起始
    [path moveToPoint:CGPointMake(point.x + radius * 12 / 24.f, point.y - radius * 12 / 24.f)];
    CGPoint p1 = CGPointMake(point.x - radius * 12 / 24.f, point.y + radius * 12 / 24.f);
    [path addLineToPoint:p1];
    //对号第二部分起始
    [path moveToPoint:CGPointMake(point.x - radius * 12 / 24.f, point.y - radius * 12 / 24.f)];
    CGPoint p2 = CGPointMake(point.x + radius * 12 / 24.f, point.y + radius * 12 / 24.f);
    [path addLineToPoint:p2];
    
    [self addAnimationWithPath:path color:[UIColor colorWithRed:255 / 255.0 green:2 / 255.f blue:33 / 255.f alpha:1]];
}


- (void)drawSuccessWithPoint:(CGPoint)point Radius:(CGFloat)radius{
    
    //    曲线建立开始点和结束点
    //    1. 曲线的中心
    //    2. 曲线半径
    //    3. 开始角度
    //    4. 结束角度
    //    5. 顺/逆时针方向
    point = self.successPoint;
    radius = self.successRadius;
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:point radius:radius startAngle:- M_PI / 9 * 4 endAngle:2 * M_PI - M_PI / 9 clockwise:NO];
    //对号第一部分直线的起始
    [path moveToPoint:CGPointMake(point.x - radius * 14 / 24.f, point.y - radius * 3 / 24.f)];
    CGPoint p1 = CGPointMake(point.x, point.y + radius * 8 / 24.f);
    [path addLineToPoint:p1];
    //对号第二部分起始
    CGPoint p2 = CGPointMake(point.x + radius * 16 / 24.f, point.y - radius * 16 / 24.f);
    [path addLineToPoint:p2];
    
    [self addAnimationWithPath:path color:[UIColor colorWithRed:45 / 255.0 green:207 / 255.f blue:144 / 255.f alpha:1]];
}

- (void)addAnimationWithPath:(UIBezierPath *)path color:(UIColor *)lineColor
{
    CAShapeLayer *layer = [[CAShapeLayer alloc] init];
    self.animationLayer = layer;
    //内部填充颜色
    layer.fillColor = [UIColor clearColor].CGColor;
    //线条颜色
    layer.strokeColor = lineColor.CGColor;
    //对拐角和中点处理
    layer.lineCap  = @"round";
    layer.lineJoin = @"round";
    //线条宽度
    layer.lineWidth = 3;
    layer.path = path.CGPath;
    //动画设置
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:NSStringFromSelector(@selector(strokeEnd))];
    animation.fromValue = @0;
    animation.toValue = @1;
    animation.duration = 0.75;
    [layer addAnimation:animation forKey:NSStringFromSelector(@selector(strokeEnd))];
    //
    [self.layer addSublayer:layer];
}

@end
