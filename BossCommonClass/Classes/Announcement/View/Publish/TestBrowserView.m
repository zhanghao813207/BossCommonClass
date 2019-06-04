//
//  TestBrowserView.m
//  AFNetworking
//
//  Created by admin on 2019/4/15.
//

#import "TestBrowserView.h"

@interface TestBrowserView ()

@property(nonatomic, assign)CGRect originRect;
@property(nonatomic, strong)UIImageView *imgView;
@end

@implementation TestBrowserView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor blackColor];
        self.frame = [UIScreen mainScreen].bounds;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(close)];
        [self addGestureRecognizer:tap];
    }
    return self;
}
- (void)close {
    [UIView animateWithDuration:1 animations:^{
        self.imgView.frame = self.originRect;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
}
- (void)show:(CGRect)originFrame {
    self.originRect = originFrame;
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    [window addSubview:self];
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:originFrame];
    [self addSubview:imgView];
    imgView.backgroundColor = [UIColor redColor];
    self.imgView = imgView;
    [UIView animateWithDuration:1 animations:^{
        imgView.frame = CGRectMake(100, 100, self.frame.size.width, 300);
        imgView.center = self.center;
    }];
}
@end
