//
//  BorderView.m
//  AFNetworking
//
//  Created by 贾远潮 on 2018/8/28.
//

#import "BorderView.h"
#import "BossBasicDefine.h"

@implementation BorderView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        //        self.layer.masksToBounds = YES;
        self.backgroundColor = [UIColor clearColor];
        self.cornerRadius = 0.f;
        self.borderColor = kLineColor;
        self.borderWidth = 0.5f;
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    self.layer.cornerRadius = self.cornerRadius;
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    CGPoint leftTopPoint = CGPointMake(0, 0);
    
    CGPoint rightTopPoint = CGPointMake(self.bounds.size.width, 0);
    
    CGPoint leftBottomPoint = CGPointMake(0, self.bounds.size.height);
    
    CGPoint rightBottomPoint = CGPointMake(self.bounds.size.width, self.bounds.size.height);
    
    CGRect cornerRect = CGRectInset(self.bounds, self.cornerRadius, self.cornerRadius);
    
    CGPoint cornerLeftTopPoint = cornerRect.origin;
    
    CGPoint cornerRightTopPoint = CGPointMake(CGRectGetMaxX(cornerRect), cornerRect.origin.y);
    
    CGPoint cornerLeftBottomPoint = CGPointMake(cornerRect.origin.x, CGRectGetMaxY(cornerRect));
    
    CGPoint cornerRightBottomPoint = CGPointMake(CGRectGetMaxX(cornerRect), CGRectGetMaxY(cornerRect));
    
    if (self.cornerRadius > 0) {
        [path moveToPoint:leftTopPoint];
        if (self.rectCorner & BorderDirectionLeft) {
            if (self.rectCorner & BorderDirectionTop) {
                [path addArcWithCenter:cornerLeftTopPoint radius:self.cornerRadius startAngle:-M_PI_2 endAngle:-M_PI clockwise:NO];
            }
            [path addLineToPoint:leftBottomPoint];
        } else {
            [path moveToPoint:leftBottomPoint];
        }
        
        if (self.rectCorner & BorderDirectionBottom) {
            if (self.rectCorner & BorderDirectionLeft) {
                [path addArcWithCenter:cornerLeftBottomPoint radius:self.cornerRadius startAngle:-M_PI endAngle:-M_PI_2 * 3 clockwise:NO];
            }
            [path addLineToPoint:rightBottomPoint];
        } else {
            [path moveToPoint:rightBottomPoint];
        }
        
        if (self.rectCorner & BorderDirectionRight) {
            if (self.rectCorner & BorderDirectionBottom) {
                [path addArcWithCenter:cornerRightBottomPoint radius:self.cornerRadius startAngle:M_PI_2 endAngle:0 clockwise:NO];
            }
            [path addLineToPoint:rightTopPoint];
        } else {
            [path moveToPoint:rightTopPoint];
        }
        if (self.rectCorner & BorderDirectionTop) {
            if (self.rectCorner & BorderDirectionRight) {
                [path addArcWithCenter:cornerRightTopPoint radius:self.cornerRadius startAngle:0 endAngle:-M_PI_2 clockwise:NO];
            }
            [path addLineToPoint:leftTopPoint];
        } else {
            [path moveToPoint:leftTopPoint];
        }
    } else {
        [path moveToPoint:leftTopPoint];
        if (self.rectCorner & BorderDirectionLeft) {
            [path addLineToPoint:leftBottomPoint];
        } else {
            [path moveToPoint:leftBottomPoint];
        }
        
        if (self.rectCorner & BorderDirectionBottom) {
            [path addLineToPoint:rightBottomPoint];
        } else {
            [path moveToPoint:rightBottomPoint];
        }
        
        if (self.rectCorner & BorderDirectionRight) {
            [path addLineToPoint:rightTopPoint];
        } else {
            [path moveToPoint:rightTopPoint];
        }
        if (self.rectCorner & BorderDirectionTop) {
            [path addLineToPoint:leftTopPoint];
        } else {
            [path moveToPoint:leftTopPoint];
        }
    }
    
    [path setLineCapStyle:kCGLineCapSquare];
    
    path.lineWidth = self.borderWidth;
    
    [self.borderColor setStroke];
    
    [path stroke];
}

@end
