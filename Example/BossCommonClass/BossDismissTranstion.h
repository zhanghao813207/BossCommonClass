//
//  BossDismissTranstion.h
//  BossCommonClass_Example
//
//  Created by 贾远潮 on 2018/9/19.
//  Copyright © 2018年 JiaYuanchao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BossDismissTranstion : UIPercentDrivenInteractiveTransition

@property(nonatomic,assign) BOOL interactionInProgress;

- (instancetype)initWithPressentViewController:(UIViewController *)viewController;

@end
