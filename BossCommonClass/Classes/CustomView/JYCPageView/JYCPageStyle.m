//
//  JYCPageStyle.m
//  NNBarKnight
//
//  Created by 贾远潮 on 2017/9/20.
//  Copyright © 2017年 贾远潮. All rights reserved.
//

#import "JYCPageStyle.h"
#import "NNBBasicDefine.h"

@implementation JYCPageStyle

- (UIColor *)selectColor
{
    if (!_selectColor) {
        _selectColor = kMainColor;
    }
    return _selectColor;
}

- (UIColor *)normalColor
{
    if (!_normalColor) {
        _normalColor = kHexRGB(0x00000);
    }
    return _normalColor;
}

- (UIFont *)titleFont
{
    if (!_titleFont) {
        _titleFont = NNBRegularFont(14.f);
    }
    return _titleFont;
}

- (CGFloat)titleSpace
{
    if (_titleSpace <= 0) {
        _titleSpace = 0;
    }
    return _titleSpace;
}

@end
