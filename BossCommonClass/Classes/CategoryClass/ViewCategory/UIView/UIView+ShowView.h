//
//  UIView+ShowView.h
//  Gtyk
//
//  Created by 贾远潮 on 2016/11/18.
//  Copyright © 2016年 欧客云. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NoInternetEmptyView.h"

@interface UIView (ShowView)

#pragma mark -- LoadingView -- 加载的页面

- (void)showLoadingView:(NSString *)status;

- (void)showClearLoadingView:(NSString *)status;

- (void)dismissLoadingViewWithCompletion:(void (^)(BOOL finish))completion;

#pragma mark -- LoadingStatusView -- 带文字的加载

- (void)showLoadingStatus:(NSString *)status;

- (void)showClearLoadingStatus:(NSString *)status;

- (void)showGrayLoadingStatus:(NSString *)status;

- (void)dismissLoadingStatusViewWithCompletion:(void (^)(BOOL))completion;


#pragma mark -- NoInternetView -- 没有网的页面
- (void)showNoInterNetWithButtonBlock:(void (^)(BOOL isSelect))buttonBlock;

- (void)showNoInterNetWithEmptyType:(EmptyViewType)emptyType ButtonBlock:(void (^)(BOOL isSelect))buttonBlock;

- (void)dismissNoInterNet;

#pragma mark -- statusView -- 提示的页面

- (void)showStatus:(NSString *)status;

- (void)showSuccessStaus:(NSString *)status;

#pragma mark -- statusAnimationView -- 带动画的提示页面

- (void)showAnimationStatus:(NSString *)status completion:(void (^)(BOOL finish))completion;

- (void)showAnimationSuccessStaus:(NSString *)status completion:(void (^)(BOOL finish))completion;

- (void)showAnimationErrorStaus:(NSString *)status completion:(void (^)(BOOL finish))completion;

#pragma mark -- LoadingView -- 点点点的加载

- (void)showBossLoadingView:(NSString *)status;

- (void)dismissBossLoadingViewWithCompletion:(void (^)(BOOL finish))completion;



@end
