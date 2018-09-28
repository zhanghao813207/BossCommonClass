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
                self.layer.masksToBounds = YES;
        self.backgroundColor = [UIColor clearColor];
        self.cornerRadius = 0.f;
        self.borderColor = kLineColor;
        self.borderWidth = 0.5f;
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{

//    self.layer.cornerRadius = self.cornerRadius;
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    CGPoint leftTopPoint = CGPointMake(self.borderWidth, self.borderWidth);
    
    CGPoint rightTopPoint = CGPointMake(self.bounds.size.width - self.borderWidth, self.borderWidth);
    
    CGPoint leftBottomPoint = CGPointMake(self.borderWidth, self.bounds.size.height - self.borderWidth);
    
    CGPoint rightBottomPoint = CGPointMake(self.bounds.size.width - self.borderWidth, self.bounds.size.height - self.borderWidth);
    
    CGRect cornerRect = CGRectInset(self.bounds, self.cornerRadius, self.cornerRadius);
    
    CGPoint cornerLeftTopPoint = cornerRect.origin;
    
    CGPoint cornerRightTopPoint = CGPointMake(CGRectGetMaxX(cornerRect), cornerRect.origin.y);
    
    CGPoint cornerLeftBottomPoint = CGPointMake(cornerRect.origin.x, CGRectGetMaxY(cornerRect));
    
    CGPoint cornerRightBottomPoint = CGPointMake(CGRectGetMaxX(cornerRect), CGRectGetMaxY(cornerRect));
    
    if (self.cornerRadius > 0) {
        if (self.rectCorner & BorderDirectionLeft) {
            if (self.rectCorner & BorderDirectionTop) {
                [path moveToPoint:CGPointMake(cornerLeftTopPoint.x, leftTopPoint.y)];
                [path addArcWithCenter:cornerLeftTopPoint radius:self.cornerRadius - self.borderWidth startAngle:-M_PI_2 endAngle:-M_PI clockwise:NO];
            } else {
                [path moveToPoint:leftTopPoint];
                [path addLineToPoint:CGPointMake(leftTopPoint.x, cornerLeftTopPoint.y)];
            }
            [path addLineToPoint:CGPointMake(leftBottomPoint.x, cornerLeftBottomPoint.y)];
            if (self.rectCorner & BorderDirectionBottom) {
            } else {
                [path addLineToPoint:leftBottomPoint];
            }
        } else {
            [path moveToPoint:leftBottomPoint];
        }

        if (self.rectCorner & BorderDirectionBottom) {
            if (self.rectCorner & BorderDirectionLeft) {
                [path moveToPoint:CGPointMake(leftBottomPoint.x, cornerLeftBottomPoint.y)];
                [path addArcWithCenter:cornerLeftBottomPoint radius:self.cornerRadius - self.borderWidth startAngle:-M_PI endAngle:-M_PI_2 * 3 clockwise:NO];
            } else {
                [path addLineToPoint:leftBottomPoint];
                [path addLineToPoint:CGPointMake(cornerRightBottomPoint.x, leftBottomPoint.y)];
            }
            [path addLineToPoint:CGPointMake(cornerRightBottomPoint.x, rightBottomPoint.y)];
            if (self.rectCorner & BorderDirectionRight) {
            } else {
                [path addLineToPoint:rightBottomPoint];
            }
        } else {
            [path moveToPoint:rightBottomPoint];
        }

        if (self.rectCorner & BorderDirectionRight) {
            if (self.rectCorner & BorderDirectionBottom) {
                [path moveToPoint:CGPointMake(cornerRightBottomPoint.x, rightBottomPoint.y)];
                [path addArcWithCenter:cornerRightBottomPoint radius:self.cornerRadius - self.borderWidth startAngle:M_PI_2 endAngle:0 clockwise:NO];
            } else {
                [path addLineToPoint:rightBottomPoint];
                [path addLineToPoint:CGPointMake(rightBottomPoint.x, cornerRightBottomPoint.y)];
            }
            [path addLineToPoint:CGPointMake(rightTopPoint.x, cornerRightTopPoint.y)];
            if (self.rectCorner & BorderDirectionTop) {
            } else {
                [path addLineToPoint:rightTopPoint];
            }
        } else {
            [path moveToPoint:rightTopPoint];
        }
        if (self.rectCorner & BorderDirectionTop) {
            if (self.rectCorner & BorderDirectionRight) {
                [path moveToPoint:CGPointMake(rightTopPoint.x, cornerRightTopPoint.y)];
                [path addArcWithCenter:cornerRightTopPoint radius:self.cornerRadius - self.borderWidth startAngle:0 endAngle:-M_PI_2 clockwise:NO];
            } else {
                [path addLineToPoint:rightTopPoint];
                [path addLineToPoint:CGPointMake(cornerRightTopPoint.x, rightTopPoint.y)];
            }
            [path addLineToPoint:CGPointMake(cornerLeftTopPoint.x, leftTopPoint.y)];
            if (self.rectCorner & BorderDirectionLeft) {
            } else {
                [path addLineToPoint:leftTopPoint];
            }
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

    [path setLineCapStyle:kCGLineCapRound];
    
    path.lineWidth = self.borderWidth;
    
    [self.borderColor setStroke];
    
    [path stroke];
}

@end
