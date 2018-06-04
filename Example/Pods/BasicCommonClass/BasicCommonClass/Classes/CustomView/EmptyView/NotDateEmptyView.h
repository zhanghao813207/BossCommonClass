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
 * originY 默认居中偏上   间距默认20
 */
- (instancetype)initWithFrame:(CGRect)frame theImageViewOrigin:(NSInteger)originY theImageAddTitleSpace:(NSInteger)space ImageNamed:(NSString *)iName Title:(NSString *)title isType:(NotDateEmptyViewType)type;


/**
 初始化方法
 默认设置 大小为屏幕大小 
 @param imageName 图片名字
 @param title 文字描述
 @param space 文字图片间距
 @return 空页面的实例对象
 
 */
- (instancetype)initWithImageName:(NSString *)imageName titile:(NSString *)title space:(CGFloat)space;

@end
