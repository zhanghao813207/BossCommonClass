//
//  NNBLoadingView.h
//  NNBar_knight
//
//  Created by 贾远潮 on 2017/9/19.
//

#import <UIKit/UIKit.h>

@interface NNBLoadingView : UIView

@property (nonatomic, strong) UIColor *BGColor;

- (void)showNNBLoadingViews:(NSString *)status;

- (void)showNNBClearLoadingViews:(NSString *)status;

- (void)dismissNNBLoadingViewWithComplettion:(void (^)(BOOL))completion;

@end
