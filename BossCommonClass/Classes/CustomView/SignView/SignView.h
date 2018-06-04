//
//  SignView.h
//  NNBarKnight
//
//  Created by 贾远潮 on 2017/10/16.
//  Copyright © 2017年 贾远潮. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignView : UIView

@property (nonatomic, copy) void (^confirmSignBlock)();

/**
 展示
 */
- (void)show;

/**
 消失
 
 @param completionBlcok 消失后的回调
 */
- (void)dismissWithCompletion:(void(^)(BOOL complete))completionBlcok;


@end
