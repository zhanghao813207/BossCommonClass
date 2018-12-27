//
//  JYCPanView.h
//  panGR
//
//  Created by 贾远潮 on 2017/9/28.
//  Copyright © 2017年 贾远潮. All rights reserved.
//

#import <UIKit/UIKit.h>


/**
 滑动方向

 - JYCPanDerectionHorizontal: 水平
 - JYCPanDerectionVertical:竖直
 */
typedef NS_ENUM(NSUInteger, JYCPanDerection) {
    JYCPanDerectionHorizontal = 1 << 0, // 水平
    JYCPanDerectionVertical   = 1 << 1, // 竖直
};

@interface JYCPanView : UIView


/**
 滑动View X方向的最大值
 */
@property (nonatomic, assign) CGFloat maxX;

/**
 滑动View Y方向的最大值
 */
@property (nonatomic, assign) CGFloat maxY;


/**
 滑动View X方向的最小值
 */
@property (nonatomic, assign) CGFloat minX;

/**
 滑动View Y方向的最小值
 */
@property (nonatomic, assign) CGFloat minY;


/**
 滑动方向
 */
@property (nonatomic, assign) JYCPanDerection panDerection;


/**
 滑动动画结束回调
 */
@property (nonatomic, copy) void (^customAnimationBlock)(CGRect endRect);


/**
 滑动水平方向最大值回调
 */
@property (nonatomic, copy) void (^viewHasSlidHorizontalMax)(BOOL isMax);

/**
 滑动竖直方向最大值回调
 */
@property (nonatomic, copy) void (^viewHasSlideVerticalMax)(BOOL isMax);

@end
