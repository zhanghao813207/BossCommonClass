
//
//  UIView+Corner.m
//  AFNetworking
//
//  Created by admin on 2019/3/27.
//

#import "UIView+Corner.h"
#import "UIImage+Corner.h"
#import "BossMethodDefine.h"

@implementation UIView (Corner)
- (void)QH_AddCorner:(CGFloat)radius borwidth:(CGFloat)width backgroundColor:(UIColor *)color borderColor:(UIColor *)color {
    
}
- (void)QH_addRounderCornerWithRadius:(CGFloat)radius size:(CGSize)size
{
    NSLog(@"%f",self.frame.size.width);
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    CGContextRef cxt = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(cxt, [UIColor whiteColor].CGColor);
    CGContextSetStrokeColorWithColor(cxt, [UIColor whiteColor].CGColor);
    
    CGContextMoveToPoint(cxt, size.width, size.height-radius);
    CGContextAddArcToPoint(cxt, size.width, size.height, size.width-radius, size.height, radius);//右下角
    CGContextAddArcToPoint(cxt, 0, size.height, 0, size.height-radius, radius);//左下角
    CGContextAddArcToPoint(cxt, 0, 0, radius, 0, radius);//左上角
    CGContextAddArcToPoint(cxt, size.width, 0, size.width, radius, radius);//右上角
    CGContextClosePath(cxt);
    CGContextDrawPath(cxt, kCGPathFillStroke);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    imageView.layer.shadowOpacity = 1;
    
    imageView.layer.shadowColor = [UIColor colorWithRed:235 / 255.0 green:237 / 255.0 blue:239 / 255.0 alpha:1].CGColor;
    imageView.layer.shadowOffset = CGSizeMake(5, 5);
    [imageView setImage:image];
    [self insertSubview:imageView atIndex:0];
}
@end
