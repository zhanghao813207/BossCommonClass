
//
//  PopTool.m
//  AFNetworking
//
//  Created by admin on 2019/4/15.
//

#import "PopTool.h"

@interface PopTool ()

/**
 *
 *  当前弹出的view
 */
@property (nonatomic, strong) UIView *currentView;

@end

@implementation PopTool
//+ (instancetype)sharedInstance {
//    static PopTool *_popTool = nil;
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        _popTool = [[PopTool alloc] init];
//    });
//    return _popTool;
//}
- (void)popView:(UIView *)view animated:(BOOL)animated {
    self.currentView = view;
    CGFloat halfScreenWidth = [[UIScreen mainScreen] bounds].size.width * 0.5;
    CGFloat halfScreenHeight = [[UIScreen mainScreen] bounds].size.height * 0.5;
    // 屏幕中心
    CGPoint screenCenter = CGPointMake(halfScreenWidth, halfScreenHeight);
    view.center = screenCenter;
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [keyWindow addSubview:view];
    if (animated) {
        // 将view宽高缩至无限小（点）
        view.transform = CGAffineTransformScale(CGAffineTransformIdentity, CGFLOAT_MIN, CGFLOAT_MIN);
        [UIView animateWithDuration:0.3 animations:^{
            // 以动画的形式将view慢慢放大至原始大小的1.2倍
            view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1, 1);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.2 animations:^{
                // 以动画的形式将view恢复至原始大小
                view.transform = CGAffineTransformIdentity;
            }];
        }];
    }
}

- (void)closeAnimated:(BOOL)animated {
    __weak typeof(self)weakself = self;
    if (animated) {
        [UIView animateWithDuration:0.2 animations:^{
            weakself.currentView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1, 1);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.3 animations:^{
                weakself.currentView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.001, 0.001);
            } completion:^(BOOL finished) {
                [weakself.currentView removeFromSuperview];
            }];
        }];
    } else {
        [weakself.currentView removeFromSuperview];
    }
}
- (void)dealloc {
    NSLog(@"aa");
}
@end
