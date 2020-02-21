//
//  NNBStatusAnimationView.h
//  NNB
//
//  Created by 贾远潮 on 2018/1/5.
//

#import <UIKit/UIKit.h>

@interface NNBStatusAnimationView : UIView

- (void)showStatus:(NSString *)title;

- (void)showSuccessStatus:(NSString *)title;

- (void)showErrorStatus:(NSString *)title;

- (void)dismissWithComplettion:(void (^)(BOOL))completion;

@end
