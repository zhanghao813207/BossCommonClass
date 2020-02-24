//
//  NNBButton.h
//  NNBarKnight
//
//  Created by 贾远潮 on 2017/9/30.
//

#import <UIKit/UIKit.h>

@interface NNBButton : UIButton

/**
 快速创建橘色按钮

 @return 暖暖吧专用橘色背景按钮
 */
+ (__kindof NNBButton *)buttonWithFrame:(CGRect)frame;

/**
 是否可以点击  此参数目前只配合橘色按钮使用
 */
@property (nonatomic, assign) BOOL clickEnable;

/**
 快速创建灰色按钮

 @param frame 位置
 @return 暖暖吧专用灰色背景按钮
 */
+ (__kindof NNBButton *)grayButtonWithFrame:(CGRect)frame;

@end
