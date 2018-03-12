//
//  NSAttributedString+Extension.m
//  Gtyk
//
//  Created by 武贤业 on 16/10/11.
//  Copyright © 2016年 GTYK. All rights reserved.
//

#import "NSAttributedString+Extension.h"

/** 是否为iOS7 */
#define iOS7 (([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) ? YES : NO)


@implementation NSAttributedString (Extension)

//+ (NSAttributedString *)attributedStringWithPrice:(CGFloat)price
//{
//    NSString *priceStr = [NSString stringWithFormat:@"¥ %.2lf",price];
//    NSString *priceIntegerStr = [NSString stringWithFormat:@"%ld",(NSInteger)price];
//    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:priceStr];
//    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(2, priceIntegerStr.length)];
//    return str;
//}
//
//+ (NSAttributedString *)attributedStringWithNoSpacePrice:(CGFloat)price
//{
//    NSString *priceStr = [NSString stringWithFormat:@"¥%.2lf",price];
//    NSString *priceIntegerStr = [NSString stringWithFormat:@"%ld",(NSInteger)price];
//    CGFloat bigFont = 0;
//    if (priceIntegerStr.length >= 4) {
//        bigFont = 14;
//    } else {
//        bigFont = 15;
//    }
//    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:priceStr];
//    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:bigFont] range:NSMakeRange(1, priceIntegerStr.length)];
//    return str;
//}
//
//
//+ (NSAttributedString *)attributedStringSpecialWithPrice:(CGFloat)price Bigfont:(CGFloat)font SmallFont:(CGFloat)smallFont
//{
//    NSString *priceStr = [NSString stringWithFormat:@"¥%.2lf",price];
//    NSString *priceIntegerStr = [NSString stringWithFormat:@"%ld",(NSInteger)price];
//    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:priceStr];
//    [str addAttribute:NSFontAttributeName value:kFontWithNameSTHeitiSC(smallFont) range:NSMakeRange(0, priceIntegerStr.length)];
//    [str addAttribute:NSFontAttributeName value:kFontWithNameSTHeitiSC(font) range:NSMakeRange(1, priceIntegerStr.length)];
//    return str;
//}

+ (NSAttributedString *)attributedStringWithProductionCurrentViewPicturePage:(NSString *)PageView
{
    NSArray *strarray = [PageView componentsSeparatedByString:@"/"];
    NSString * currentPage = [strarray firstObject];
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:PageView];
    
    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:19] range:NSMakeRange(0, currentPage.length)];
    
    return str;
}

//+ (NSAttributedString *)attributedStringSpecialWithPrice:(CGFloat)price
//{
//    NSString *priceStr = [NSString stringWithFormat:@"¥ %.2lf",price];
//    NSString *priceIntegerStr = [NSString stringWithFormat:@"%ld",(NSInteger)price];
//    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:priceStr];
//    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18] range:NSMakeRange(2, priceIntegerStr.length)];
//    return str;
//}
//
//+ (NSAttributedString *)attributedStringSpecialWithPriceBlod19:(CGFloat)price
//{
//    NSString *priceStr = [NSString stringWithFormat:@"¥ %.2lf",price];
//    NSString *priceIntegerStr = [NSString stringWithFormat:@"%ld",(NSInteger)price];
//    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:priceStr];
//    
//    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:17.f] range:NSMakeRange(0, priceIntegerStr.length)];
//
//    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:22.f] range:NSMakeRange(2, priceIntegerStr.length)];
//    return str;
//}
//


+ (NSAttributedString *)priceAttributedString:(CGFloat)price isHaveSpace:(BOOL)space theLargerText:(UIFont *)moreFont theSmallFont:(UIFont *)smallFont
{

    NSString *priceStr;
    NSInteger loc = 1;
    if (space) {
        priceStr  = [NSString stringWithFormat:@"¥ %.2lf",price];
        loc = 2;
    }else{
        priceStr  = [NSString stringWithFormat:@"¥%.2lf",price];
    }
    NSString *priceIntegerStr = [NSString stringWithFormat:@"%ld",(NSInteger)price];
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:priceStr];
    [str addAttribute:NSFontAttributeName value:smallFont range:NSMakeRange(0, priceIntegerStr.length)];
    [str addAttribute:NSFontAttributeName value:moreFont range:NSMakeRange(loc, priceIntegerStr.length)];
    return str;

}


- (CGSize)sizeOfStringWithMaxSize:(CGSize)maxSize
{
    CGRect rect;
    if (!iOS7) {
        return CGSizeMake(0, 0);
    }
    rect = [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin context:nil];
    return rect.size;
}




+(NSAttributedString *)originalPriceStyleMediumLineByPrice:(CGFloat)price isHaveSpace:(BOOL)space isInForeDescribe:(NSString *)describe theLargerText:(UIFont *)moreFont theSmallFont:(UIFont *)smallFont
{

    NSString *priceStr;
    NSInteger describeLength = describe.length;
    NSInteger loc = 1+describeLength;

    if (space) {
        priceStr  = [NSString stringWithFormat:@"%@¥ %.2lf",describe,price];
        loc = 2+describeLength;
    }else{
        priceStr  = [NSString stringWithFormat:@"%@¥%.2lf",describe,price];
    }
    NSString *priceIntegerStr = [NSString stringWithFormat:@"%ld",(NSInteger)price];
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:priceStr];
    [str addAttribute:NSFontAttributeName value:smallFont range:NSMakeRange(0, priceIntegerStr.length)];
    [str addAttribute:NSFontAttributeName value:moreFont range:NSMakeRange(loc, priceIntegerStr.length)];
    [str setAttributes:@{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleNone]} range:NSMakeRange(0,3)];//**iOS 8需要加上这句**
    [str setAttributes:@{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]} range:NSMakeRange(0,priceStr.length)];
    
    return str;

}

@end
