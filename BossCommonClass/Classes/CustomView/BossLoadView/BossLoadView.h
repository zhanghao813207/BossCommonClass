//
//  BossLoadView.h
//  BossCommonClass
//
//  Created by 贾远潮 on 2018/9/4.
//

#import <UIKit/UIKit.h>

@interface BossLoadView : UIView

@property (nonatomic, strong) UIColor *BGColor;

- (void)showBossLoadViews:(NSString *)status;

- (void)dismissBossLoadViewWithComplettion:(void (^)(BOOL))completion;

@end
