//
//  UIView+ShowView.m
//  Gtyk
//
//  Created by 贾远潮 on 2016/11/18.
//  Copyright © 2016年 欧客云. All rights reserved.
//

#import "UIView+ShowView.h"
#import "NNBLoadingView.h"
#import "NNBStatusView.h"
#import "NNBLoadStatusView.h"
#import <objc/runtime.h>
#import "NNBStatusAnimationView.h"
#import "BossLoadView.h"
@implementation UIView (ShowView)

#pragma mark -- LoadingView -- 加载的页面

static char loadingViewKey;

- (void)setLoadingView:(NNBLoadingView *)loadingView
{
    objc_setAssociatedObject(self, &loadingViewKey, loadingView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NNBLoadingView *)loadingView
{
    return objc_getAssociatedObject(self, &loadingViewKey);
}

- (void)showLoadingView:(NSString *)status
{
    if (!self.loadingView) {
        self.loadingView = [[NNBLoadingView alloc] initWithFrame:self.bounds];
    }
    [self addSubview:self.loadingView];
    self.loadingView.BGColor = [UIColor clearColor];
    [self.loadingView showNNBLoadingViews:status];
}

- (void)showClearLoadingView:(NSString *)status;
{
    if (!self.loadingView) {
        self.loadingView = [[NNBLoadingView alloc] initWithFrame:self.bounds];
    }
    self.loadingView.BGColor = [UIColor clearColor];
    [self addSubview:self.loadingView];
    [self.loadingView showNNBClearLoadingViews:status];
}

- (void)dismissLoadingViewWithCompletion:(void (^)(BOOL finish))completion
{
    if (self.loadingView) {
        [self.loadingView dismissNNBLoadingViewWithComplettion:^(BOOL finish) {
            if (completion) {
                completion(finish);
            }
            self.loadingView = nil;
        }];
    } else {
        if (completion) {
            completion(YES);
        }
    }
}

#pragma mark -- LoadingStatusView -- 带文字的加载

static char loadingStatusViewKey;

- (void)setLoadingStatusView:(NNBLoadStatusView *)loadingStatusView
{
    objc_setAssociatedObject(self, &loadingStatusViewKey, loadingStatusView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NNBLoadStatusView *)loadingStatusView
{
    return objc_getAssociatedObject(self, &loadingStatusViewKey);
}

- (void)showLoadingStatus:(NSString *)status
{
    if (!self.loadingStatusView) {
        self.loadingStatusView = [[NNBLoadStatusView alloc] initWithFrame:self.bounds];
    }
    if (!self.loadingStatusView.superview) {
        [self addSubview:self.loadingStatusView];
    }
    [self.loadingStatusView showLoadingStatus:status];
}

- (void)showClearLoadingStatus:(NSString *)status
{
    if (!self.loadingStatusView) {
        self.loadingStatusView = [[NNBLoadStatusView alloc] initWithFrame:self.bounds];
    }
    [self addSubview:self.loadingStatusView];
    [self.loadingStatusView showClearLoadingStatus:status];
}

- (void)showGrayLoadingStatus:(NSString *)status
{
    if (!self.loadingStatusView) {
        self.loadingStatusView = [[NNBLoadStatusView alloc] initWithFrame:self.bounds];
    }
    [self addSubview:self.loadingStatusView];
    [self.loadingStatusView showGrayLoadingStatus:status];
}

- (void)dismissLoadingStatusViewWithCompletion:(void (^)(BOOL))completion
{
    
    if (self.loadingStatusView) {
        [self.loadingStatusView dismissNNBLoadingStatusViewWithCompletion:^(BOOL finish) {
            if (completion) {
                completion(finish);
            }
            self.loadingStatusView = nil;
        }];
    } else {
        if (completion) {
            completion(YES);
        }
    }
}

#pragma mark -- NoInternetView -- 没有网的页面
static char noInternetEmptyViewKey;

- (NoInternetEmptyView *)noInternetEmptyView
{
    return objc_getAssociatedObject(self, &noInternetEmptyViewKey);
}

- (void)setNoInternetEmptyView:(NoInternetEmptyView *)noInternetEmptyView
{
    objc_setAssociatedObject(self, &noInternetEmptyViewKey, noInternetEmptyView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)showNoInterNetWithEmptyType:(EmptyViewType)emptyType ButtonBlock:(void (^)(BOOL))buttonBlock
{
    if (!self.noInternetEmptyView) {
        self.noInternetEmptyView = [[NoInternetEmptyView alloc] initWithFrame:self.bounds];
        self.noInternetEmptyView.noInternetEmptyViewType = emptyType;
        self.noInternetEmptyView.emptyButtonIsSelect = buttonBlock;
        [self addSubview:self.noInternetEmptyView];
    } else {
        [self dismissNoInterNet];
        [self showNoInterNetWithEmptyType:emptyType ButtonBlock:buttonBlock];
    }
}

- (void)showNoInterNetWithButtonBlock:(void (^)(BOOL isSelect))buttonBlock
{
    [self showNoInterNetWithEmptyType:EmptyViewTypeHasButton ButtonBlock:buttonBlock];
}

- (void)dismissNoInterNet
{
    if (self.noInternetEmptyView) {
        [self.noInternetEmptyView removeFromSuperview];
        self.noInternetEmptyView = nil;
    }
}

#pragma mark -- statusView -- 提示的页面

static char statusViewKey;

- (void)setStatusView:(NNBStatusView *)statusView
{
    objc_setAssociatedObject(self, &statusViewKey, statusView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NNBStatusView *)statusView
{
    return objc_getAssociatedObject(self, &statusViewKey);
}

- (void)showStatus:(NSString *)status
{
    if (!self.statusView) {
        self.statusView = [[NNBStatusView alloc] initWithFrame:self.bounds];
    }
    [self addSubview:self.statusView];
    [self.statusView showStatus:status];
    [self performSelector:@selector(dismissStatusView) withObject:nil afterDelay:2.f];
}

- (void)showSuccessStaus:(NSString *)status
{
    if (!self.statusView) {
        self.statusView = [[NNBStatusView alloc] initWithFrame:self.bounds];
    }
    [self addSubview:self.statusView];
    [self.statusView showSuccessStatus:status];
    [self performSelector:@selector(dismissStatusView) withObject:nil afterDelay:2.f];
}

- (void)dismissStatusView
{
    if (self.statusView) {
        [self.statusView removeFromSuperview];
        self.statusView = nil;
    }
}

#pragma mark -- statusAnimationView -- 带动画的提示页面

static char statusAnimationViewKey;

- (void)setStatusAnimationView:(NNBStatusAnimationView *)statusView
{
    objc_setAssociatedObject(self, &statusAnimationViewKey, statusView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NNBStatusAnimationView *)statusAnimationView
{
    return objc_getAssociatedObject(self, &statusAnimationViewKey);
}


- (void)showAnimationStatus:(NSString *)status completion:(void (^)(BOOL finish))completion
{
    if (!self.statusAnimationView) {
        self.statusAnimationView = [[NNBStatusAnimationView alloc] initWithFrame:self.bounds];
    }
    [self addSubview:self.statusAnimationView];
    [self.statusAnimationView showStatus:status];
    [self performSelector:@selector(dismissStatusAnimationViewWithCompletion:) withObject:completion afterDelay:8.f];
}

- (void)showAnimationSuccessStaus:(NSString *)status completion:(void (^)(BOOL finish))completion
{
    if (!self.statusAnimationView) {
        self.statusAnimationView = [[NNBStatusAnimationView alloc] initWithFrame:self.bounds];
    }
    [self addSubview:self.statusAnimationView];
    [self.statusAnimationView showSuccessStatus:status];
    [self performSelector:@selector(dismissStatusAnimationViewWithCompletion:) withObject:completion afterDelay:1.5f];
}

- (void)showAnimationErrorStaus:(NSString *)status completion:(void (^)(BOOL finish))completion
{
    if (!self.statusAnimationView) {
        self.statusAnimationView = [[NNBStatusAnimationView alloc] initWithFrame:self.bounds];
    }
    [self addSubview:self.statusAnimationView];
    [self.statusAnimationView showErrorStatus:status];
    [self performSelector:@selector(dismissStatusAnimationViewWithCompletion:) withObject:completion afterDelay:1.5f];
}

- (void)dismissStatusAnimationViewWithCompletion:(void (^)(BOOL finish))completion
{
    if (self.statusAnimationView) {
        [self.statusAnimationView dismissWithComplettion:^(BOOL complete) {
            [self.statusAnimationView removeFromSuperview];
            if (completion) {
                completion(complete);
            }
            self.statusAnimationView = nil;
            
        }];
    } else {
        if (completion) {
            completion(YES);
        }
    }
}

#pragma mark -- LoadingView -- 点点点的加载

static char bossLoadingViewKey;

- (void)setBossLoadingView:(BossLoadView *)bossLoadingView
{
    objc_setAssociatedObject(self, &bossLoadingViewKey, bossLoadingView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BossLoadView *)bossLoadingView
{
    return objc_getAssociatedObject(self, &bossLoadingViewKey);
}


- (void)showBossLoadingView:(NSString *)status
{
    if (!self.bossLoadingView) {
        self.bossLoadingView = [[BossLoadView alloc] initWithFrame:self.bounds];
    }
    [self addSubview:self.bossLoadingView];
    [self.bossLoadingView showBossLoadViews:status];
}

- (void)dismissBossLoadingViewWithCompletion:(void (^)(BOOL finish))completion
{
    if (self.bossLoadingView) {
        [self.bossLoadingView dismissBossLoadViewWithComplettion:^(BOOL finish) {
            if (completion) {
                completion(finish);
            }
            self.bossLoadingView = nil;
        }];
    } else {
        if (completion) {
            completion(YES);
        }
    }
}



@end
