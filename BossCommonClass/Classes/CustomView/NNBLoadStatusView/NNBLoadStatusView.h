//
//  NNBLoadStatusView.h
//  NNB
//
//  Created by 贾远潮 on 2017/12/21.
//

#import <UIKit/UIKit.h>

@interface NNBLoadStatusView : UIView

- (void)showLoadingStatus:(NSString *)status;

- (void)showClearLoadingStatus:(NSString *)status;

- (void)showGrayLoadingStatus:(NSString *)status;

- (void)dismissNNBLoadingStatusViewWithCompletion:(void (^)(BOOL))completion;

@end
