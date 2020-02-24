//
//  NNBStatusView.h
//  NNB
//
//  Created by 贾远潮 on 2017/12/20.
//

#import <UIKit/UIKit.h>

@interface NNBStatusView : UIView


- (void)showStatus:(NSString *)title;

- (void)showSuccessStatus:(NSString *)title;

- (void)dismissWithComplettion:(void (^)(BOOL))completion;

@end
