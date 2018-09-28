//
//  BossDismissTranstion.m
//  BossCommonClass_Example
//
//  Created by 贾远潮 on 2018/9/19.
//  Copyright © 2018年 JiaYuanchao. All rights reserved.
//

#import "BossDismissTranstion.h"

@interface BossDismissTranstion()

/**  */
@property(nonatomic,assign) BOOL shouldCompleteTransition;
/**  */
@property(nonatomic,weak) UIViewController *viewController;

@end

@implementation BossDismissTranstion

- (instancetype)initWithPressentViewController:(UIViewController *)viewController
{
    if (self = [super init]) {
        self.viewController = viewController;
        
        UIScreenEdgePanGestureRecognizer *edgePanGesture = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
        edgePanGesture.edges = UIRectEdgeLeft;
        [viewController.view addGestureRecognizer:edgePanGesture];
    }
    return self;
}

- (void)handleGesture:(UIScreenEdgePanGestureRecognizer *)gestureRecognizer {
    // 1
    CGPoint translation = [gestureRecognizer translationInView:gestureRecognizer.view.superview];
    CGFloat progress = translation.x/100;
    progress = fminf(fmaxf(progress, 0), 1.0);
    // 2
    switch (gestureRecognizer.state) {
        case UIGestureRecognizerStateBegan:
            self.interactionInProgress = YES;
            [self.viewController dismissViewControllerAnimated:YES completion:nil];
            break;
        case UIGestureRecognizerStateChanged:
            self.shouldCompleteTransition = progress > 0.5;
            [self updateInteractiveTransition:progress];
            break;
        case UIGestureRecognizerStateCancelled:
            self.interactionInProgress = NO;
            [self cancelInteractiveTransition];
            break;
        case UIGestureRecognizerStateEnded:
        {
            self.interactionInProgress = NO;
            if (!self.shouldCompleteTransition) {
                [self cancelInteractiveTransition];
            } else {
                [self finishInteractiveTransition];
            }
            break;
        }
        default:
            break;
    }
}
@end
