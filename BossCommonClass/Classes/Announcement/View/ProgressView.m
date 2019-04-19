

//
//  ProgressView.m
//  AFNetworking
//
//  Created by admin on 2019/4/14.
//

#import "ProgressView.h"
#import "JYCMethodDefine.h"

@implementation ProgressView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}
- (void)setProgress:(CGFloat)progress {
    _progress = progress;
    [self setNeedsDisplay];
}
- (void)drawRect:(CGRect)rect {
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    UIBezierPath *paht1 = [UIBezierPath bezierPathWithRect:self.bounds];
    [kHexRGB(0xD9D9D9) setStroke];
    CGContextSetLineWidth(ctx, 10);
    CGContextAddPath(ctx, paht1.CGPath);
    CGContextStrokePath(ctx);
    
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, self.frame.size.width * self.progress, self.frame.size.height)];
    [kHexRGB(0x00BD9A) set];
    CGContextSetLineWidth(ctx, 10);
    CGContextAddPath(ctx, path.CGPath);
    CGContextStrokePath(ctx);
    
    
    
}
@end
