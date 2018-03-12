//
//  NSString+CaleSize.h
//  NNBarKnight
//
//  Created by 贾远潮 on 2017/9/20.
//  Copyright © 2017年 贾远潮. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (CaleSize)

/**
 *  计算字符串的尺寸
 *
 *  @param font    字符串字体的大小
 *  @param maxSize 定义字符串显示的范围
 *
 *  @return 返回字符串的size
 */
- (CGSize)sizeOfStringWithFont:(UIFont *)font maxSize:(CGSize)maxSize;

/**
 *  计算字符串的高度
 *
 *  @param font  字符串的字体
 *  @param width 字符串显示的宽度,高度默认为MAXFLOAT
 *
 *  @return 字符串的高度
 */
- (CGFloat)heightOfStringWithFont:(UIFont *)font width:(CGFloat)width;

/**
 *  清空字符串中的空白字符
 *
 *  @return 清空空白字符串之后的字符串
 */
- (NSString *)trimString;

/**
 *  是否为空字符串
 *
 *  @return 如果字符串为nil或者长度为0返回YES
 */
- (BOOL)isEmptyString;


@end
