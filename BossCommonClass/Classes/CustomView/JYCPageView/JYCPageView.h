//
//  JYCPageView.h
//  NNBarKnight
//
//  Created by 贾远潮 on 2017/9/20.
//

#import <UIKit/UIKit.h>

#import "JYCPageStyle.h"

@interface JYCPageView : UIView

@property (nonatomic, copy) void (^selectIndexBlock)(NSInteger index);

/**
 创建分页的view

 @param frame view的frame
 @param titles 标题
 @param childVCs 子控制器
 @param parentVC 父控制器
 @return 实例对象
 */
- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray <NSString *>*)titles childVCs:(NSArray <UIViewController *> *)childVCs parentVC:(UIViewController *)parentVC pageStyle:(JYCPageStyle *)pageStyle;


- (void)updateTitle:(NSString *)string index:(NSInteger)index;

@end
