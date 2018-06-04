//
//  JYCDrawPathView.h
//  Pods
//
//  Created by 贾远潮 on 2017/9/18.
//
//

#import <UIKit/UIKit.h>

@interface JYCDrawPathView : UIView
/**
 线的宽度
 */
@property (nonatomic, assign) CGFloat pathWidth;

/**
 线的颜色
 */
@property (nonatomic, strong) UIColor *pathColor;

/**
 清除所有画线
 */
- (void)clearPath;

/**
 是否可以撤销

 @return 是否可以撤销
 */
- (BOOL)canRepeal;

/**
 撤销操作
 
 @param completeBlock 撤销完成的回调 回调中存在是否能继续撤销
 */
- (void)repealComplete:(void(^)(BOOL canContinueRepeal))completeBlock;

@end
