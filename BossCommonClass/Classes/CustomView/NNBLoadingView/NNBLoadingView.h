//
//  NNBLoadingView.h
//  NNBar_knight
//
//  Created by 贾远潮 on 2017/9/19.
//  Copyright © 2017年 贾远潮. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NNBLoadingView : UIView

@property (nonatomic, strong) UIColor *BGColor;

- (void)showNNBLoadingView;

- (void)dismissNNBLoadingViewWithComplettion:(void (^)(BOOL))completion;

@end
