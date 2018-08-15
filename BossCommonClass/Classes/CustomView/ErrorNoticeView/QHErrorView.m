//
//  QHErrorView.m
//  QHReceipt
//
//  Created by white on 2016/8/24.
//  Copyright © 2016年 QuHuo. All rights reserved.
//

#import "QHErrorView.h"
#import "BossBasicDefine.h"

@interface QHErrorView ()
@property (nonatomic, strong) UILabel *msgLabel;
@property (nonatomic, strong) UITapGestureRecognizer *tap;
@property (nonatomic, assign) QHErrorViewType errorType;
@end
@implementation QHErrorView

- (instancetype)initWithFrame:(CGRect)frame
                     errorMsg:(NSString *)errorMsg
                    errorType:(QHErrorViewType)type
{

    self = [super initWithFrame:frame];
    if (self) {
        _msgLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, frame.size.height - 44, frame.size.width, 44)];
        _msgLabel.numberOfLines = 0;
        if (type==QHErrorViewType_error) {
            _msgLabel.backgroundColor = kHexRGB(0xC5000D);
            _msgLabel.textColor = [UIColor whiteColor];
        }else if(type==QHErrorViewType_alert){
            _msgLabel.backgroundColor = [UIColor whiteColor];
            _msgLabel.textColor = kHexRGB(0x262626);
        }
        
        _msgLabel.font = BossFont(16);
        _msgLabel.textAlignment = NSTextAlignmentCenter;
        _msgLabel.text = errorMsg;
        [self addSubview:_msgLabel];
//        self.backgroundColor = QHColor(0, 0, 0, .5);
        [self addGestureRecognizer:self.tap];
        self.errorType = type;
    }
    
    return self;
}

- (void)showInView:(UIView *)view {
    [self showInView:view atUp:NO];
}

- (void)showInView:(UIView *)view atUp:(BOOL)up {
    __block BOOL isUp = up;
    self.alpha = 0.0;
    if (isUp) {
        self.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width-_msgLabel.bounds.size.width)/2.0, 35+kStatusBarHeight + 44, _msgLabel.bounds.size.width, _msgLabel.bounds.size.height);
    }else {
        self.msgLabel.frame = CGRectMake(0, self.bounds.size.height, self.bounds.size.width, 44);
    }
    if (self.errorType == 0) {
        
        self.msgLabel.alpha = 0.0;
        [view addSubview:self];
        [UIView animateWithDuration:0.25 animations:^{
            self.alpha = 1.0;
        } completion:^(BOOL finished) {
            if (finished) {
                [UIView animateWithDuration:0.25 animations:^{
                    self.msgLabel.alpha = 1.0;
                }];
                [self performSelector:@selector(dismiss) withObject:nil afterDelay:2.0];
            }
        }];
    }else{
        
        [view addSubview:self];
        self.backgroundColor = kHexRGBA(0x000000, 0.3);
        [UIView animateWithDuration:0.25 animations:^{
            self.alpha = 1.0;
        } completion:^(BOOL finished) {
            if (finished) {
                if (!isUp) {
                    [UIView animateWithDuration:0.25 animations:^{
                        self.msgLabel.frame = CGRectMake(0, self.bounds.size.height-44, self.bounds.size.width, 44);
                    }];
                }
                [self performSelector:@selector(dismiss) withObject:nil afterDelay:2.0];
            }
        }];
    }
    
}

- (void)dismiss{
    if (self.errorType == 0){
        [UIView animateWithDuration:0.25 animations:^{
            self.msgLabel.alpha = 0.0;
        } completion:^(BOOL finished) {
            if (finished) {
                [self removeFromSuperview];
            }
        }];
    }else{
        [UIView animateWithDuration:0.25 animations:^{
            self.alpha = 0.0;
            self.msgLabel.frame = CGRectMake(0, self.bounds.size.height, self.bounds.size.width, 44);
        } completion:^(BOOL finished) {
            if (finished) {
                [self removeFromSuperview];
            }
        }];
    }
}

- (instancetype)initWithTitle:(NSString *)string{
    UIViewController *currentVC = [JYCSimpleToolClass getCurrentVC];
    CGFloat y = [UIScreen mainScreen].bounds.size.height-35-kStatusBarHeight - 44;
    if (!currentVC.tabBarController.tabBar.isHidden) {
        y -= 49;
    }
    self = [super initWithFrame:CGRectMake(0, y, [UIScreen mainScreen].bounds.size.width, 35)];
    if (self) {
        _msgLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, y, [UIScreen mainScreen].bounds.size.width, 35)];
        _msgLabel.backgroundColor = kHexRGB(0x1C2227);
        _msgLabel.textColor = [UIColor whiteColor];
        _msgLabel.font = BossFont(16);
        _msgLabel.textAlignment = NSTextAlignmentCenter;
        _msgLabel.text = string;
        _msgLabel.numberOfLines = 0;
        [_msgLabel sizeToFit];
        _msgLabel.frame = CGRectMake(0, 0, _msgLabel.bounds.size.width+40, 35);
        self.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width-_msgLabel.bounds.size.width)/2.0, y, _msgLabel.bounds.size.width, 35);
        [self addSubview:_msgLabel];
        [self addGestureRecognizer:self.tap];
    }
    
    return self;
}

- (UITapGestureRecognizer *)tap {
    if (_tap==nil) {
        _tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
    }
    return _tap;
}

@end
