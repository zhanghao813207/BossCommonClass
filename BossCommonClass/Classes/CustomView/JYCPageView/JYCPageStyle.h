//
//  JYCPageStyle.h
//  NNBarKnight
//
//  Created by 贾远潮 on 2017/9/20.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface JYCPageStyle : NSObject

/**
 选中的颜色
 */
@property (nonatomic, strong) UIColor *selectColor;

/**
 未选中的颜色
 */
@property (nonatomic, strong) UIColor *normalColor;

/**
 标题的字体
 */
@property (nonatomic, strong) UIFont *titleFont;

/**
 标题间隙
 */
@property (nonatomic, assign) CGFloat titleSpace;

/**
 标题是否可以滚动
 */
@property (nonatomic, assign) BOOL titleIsRoll;


@end
