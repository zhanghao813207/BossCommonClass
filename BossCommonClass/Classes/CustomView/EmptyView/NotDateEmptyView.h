//
//  NotDateEmptyView.h
//  Gtyk
//
//  Created by 史华涛 on 2017/9/13.
//  Copyright © 2017年 GTYK. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger, NotDateEmptyViewType){
    NotDateEmptyViewTypeIsPureColor,
    NotDateEmptyViewTypeIsUpImageDownTitle,
};


@interface NotDateEmptyView : UIView

/**
 初始化方法
 
 @param frame 位置
 @param originY 内容的起始位置
 @param space 图片文字间隙
 @param iName 图片名称
 @param size 图片大小
 @param title 文字标题
 @param type 类型
 @return 实例对象
 */
- (instancetype)initWithFrame:(CGRect)frame theImageViewOrigin:(NSInteger)originY theImageAddTitleSpace:(NSInteger)space imageName:(NSString *)iName imageSize:(CGSize)size title:(NSString *)title isType:(NotDateEmptyViewType)type;


/**
 初始化方法
 
 @param frame 位置
 @param imageName 图片文字间隙
 @param size 图片大小
 @param title 文字标题
 @param space 图片文字间隙
 @return 实例对象
 */
- (instancetype)initWithFrame:(CGRect)frame imageName:(NSString *)imageName imageSize:(CGSize)size titile:(NSString *)title space:(CGFloat)space;

/**
 背景页面
 */
@property (nonatomic, strong) UIView *backgroundView;


@end
