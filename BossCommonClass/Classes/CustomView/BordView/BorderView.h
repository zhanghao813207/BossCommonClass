//
//  BorderView.h
//  AFNetworking
//
//  Created by 贾远潮 on 2018/8/28.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, BorderDirection) {
    BorderDirectionTop      = 1 << 0, // 上边框
    BorderDirectionLeft     = 1 << 1, // 左边框
    BorderDirectionBottom   = 1 << 2, // 下边框
    BorderDirectionRight    = 1 << 3, // 右边框
    BorderDirectionAll      = ~0UL
};

@interface BorderView : UIView

@property (nonatomic, assign) CGFloat cornerRadius;

@property (nonatomic, assign) BorderDirection rectCorner;

@property (nonatomic, strong) UIColor *borderColor;

@property (nonatomic, assign) CGFloat borderWidth;

@end
