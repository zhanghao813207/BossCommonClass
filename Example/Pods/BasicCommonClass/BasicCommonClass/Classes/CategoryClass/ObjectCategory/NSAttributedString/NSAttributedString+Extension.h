//
//  NSAttributedString+Extension.h
//  Gtyk
//
//  Created by 武贤业 on 16/10/11.
//  Copyright © 2016年 GTYK. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSAttributedString (Extension)


/** 产品详情*/
+ (NSAttributedString *)attributedStringWithProductionCurrentViewPicturePage:(NSString *)PageView;


/**  价格赋值专用
 *space  ￥跟前之间是否有间距
 * 整数位大字体和小数位小字体
 */
+ (NSAttributedString *)priceAttributedString:(CGFloat)price isHaveSpace:(BOOL)space theLargerText:(UIFont *)moreFont theSmallFont:(UIFont *)smallFont;

/**
 计算富文本大小
 @param maxSize 允许的最大大小
 @return 富文本的大小
 */
- (CGSize)sizeOfStringWithMaxSize:(CGSize)maxSize;


/**
 原价显示，中间划线样式的
 *space  ￥跟前之间是否有间距
 * 整数位大字体和小数位小字体
 */
+(NSAttributedString *)originalPriceStyleMediumLineByPrice:(CGFloat)price isHaveSpace:(BOOL)space isInForeDescribe:(NSString *)describe theLargerText:(UIFont *)moreFont theSmallFont:(UIFont *)smallFont;
@end
