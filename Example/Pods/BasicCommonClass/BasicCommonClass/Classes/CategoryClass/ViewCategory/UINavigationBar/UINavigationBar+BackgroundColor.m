//
//  UINavigationBar+BackgroundColor.m
//  NNBarKnight
//
//  Created by 贾远潮 on 2017/9/21.
//  Copyright © 2017年 贾远潮. All rights reserved.
//

#import "UINavigationBar+BackgroundColor.h"
#import <objc/runtime.h>
#import "JYCSimpleToolClass.h"

@implementation UINavigationBar (BackgroundColor)

//static char overlayKey;

//- (void)update{
//    while ([self.subviews indexOfObject:self.overlay] > 0) {
//        [self sendSubviewToBack:self.overlay];
//    }
//}
//
//- (UIView *)overlay
//{
//    return objc_getAssociatedObject(self, &overlayKey);
//}
//
//- (void)setOverlay:(UIView *)overlay
//{
//    objc_setAssociatedObject(self, &overlayKey, overlay, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//}

- (void)lt_setBackgroundColor:(UIColor *)backgroundColor
{
    [self setBackgroundImage:[JYCSimpleToolClass imageWithColor:backgroundColor] forBarMetrics:UIBarMetricsDefault];
    [self setShadowImage:[JYCSimpleToolClass imageWithColor:backgroundColor]];
//    if (!self.overlay) {
//        self.overlay = [[UIView alloc] initWithFrame:CGRectMake(0, - 20, [UIScreen mainScreen].bounds.size.width, CGRectGetHeight(self.bounds) + 20)];
//        self.overlay.userInteractionEnabled = NO;
//        self.overlay.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
//    }
//
//    self.overlay.backgroundColor = backgroundColor;
//    dispatch_async(dispatch_get_main_queue(), ^{
//        [self insertSubview:self.overlay atIndex:0];
//    });
}

@end
