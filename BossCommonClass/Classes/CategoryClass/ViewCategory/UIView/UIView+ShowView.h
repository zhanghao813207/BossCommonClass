//
//  UIView+ShowView.h
//  Gtyk
//
//  Created by 贾远潮 on 2016/11/18.
//  Copyright © 2016年 GTYK. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NoInternetEmptyView.h"

@interface UIView (ShowView)

#pragma mark -- LoadingView -- 加载的页面

- (void)showLoadingView;

- (void)showClearLoadingView;

- (void)dismissLoadingView;

#pragma mark -- LoadingStatusView -- 带文字的加载

- (void)showLoadingStatus:(NSString *)status;

- (void)showClearLoadingStatus:(NSString *)status;

- (void)dismissLoadingStatusViewWithCompletion:(void (^)(BOOL))completion;


#pragma mark -- NoInternetView -- 没有网的页面
- (void)showNoInterNetWithButtonBlock:(void (^)(BOOL isSelect))buttonBlock;

- (void)showNoInterNetWithEmptyType:(EmptyViewType)emptyType ButtonBlock:(void (^)(BOOL isSelect))buttonBlock;

- (void)dismissNoInterNet;

#pragma mark -- statusView -- 提示的页面

- (void)showStatus:(NSString *)status;

- (void)showSuccessStaus:(NSString *)status;


@end
