//
//  UIView+ShowView.m
//  Gtyk
//
//  Created by 贾远潮 on 2016/11/18.
//  Copyright © 2016年 GTYK. All rights reserved.
//

#import "UIView+ShowView.h"
#import "NNBLoadingView.h"
#import "NNBStatusView.h"
#import "NNBLoadStatusView.h"
#import <objc/runtime.h>
//#import "ShowSupportTagView.h"
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

- (void)showLoadingView
{
    if (!self.loadingView) {
        self.loadingView = [[NNBLoadingView alloc] initWithFrame:self.bounds];
    }
    [self addSubview:self.loadingView];
    [self.loadingView showNNBLoadingView];
}

- (void)showClearLoadingView
{
    [self showLoadingView];
    self.loadingView.BGColor = [UIColor clearColor];
}

- (void)dismissLoadingView
{
    if (self.loadingView) {
        [self.loadingView dismissNNBLoadingViewWithComplettion:^(BOOL finish) {
            self.loadingView = nil;
        }];
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
    [self addSubview:self.loadingStatusView];
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

- (void)dismissLoadingStatusViewWithCompletion:(void (^)(BOOL))completion
{
    
    if (self.loadingStatusView) {
        [self.loadingStatusView dismissNNBLoadingStatusViewWithCompletion:^(BOOL finish) {
            if (completion) {
                completion(finish);
            }
            self.loadingStatusView = nil;
        }];
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

@end
