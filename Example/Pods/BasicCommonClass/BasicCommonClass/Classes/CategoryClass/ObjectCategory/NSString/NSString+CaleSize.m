//
//  NSString+CaleSize.m
//  NNBarKnight
//
//  Created by 贾远潮 on 2017/9/20.
//  Copyright © 2017年 贾远潮. All rights reserved.
//

#import "NSString+CaleSize.h"

/** 是否为iOS7 */
#define iOS7 (([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) ? YES : NO)

@implementation NSString (CaleSize)

- (CGSize)sizeOfStringWithFont:(UIFont *)font maxSize:(CGSize)maxSize
{
    NSDictionary *fontDict = @{NSFontAttributeName : font};
    
    if (iOS7) {
        CGRect rect = [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:fontDict context:nil];
        return rect.size;
    } else {
        return [self sizeWithFont:font constrainedToSize:maxSize];
    }
}

- (CGFloat)heightOfStringWithFont:(UIFont *)font width:(CGFloat)width
{
    return [self sizeOfStringWithFont:font maxSize:CGSizeMake(width, CGFLOAT_MAX)].height;
}

- (NSString *)trimString
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (BOOL)isEmptyString
{
    return (self == nil || self.length == 0);
}

@end
