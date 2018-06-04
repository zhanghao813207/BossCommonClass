//
//  JYCDrawPathView.m
//  Pods
//
//  Created by 贾远潮 on 2017/9/18.
//
//

#import "JYCDrawPathView.h"
#import "JYCLinePath.h"

@interface JYCDrawPathView ()

@property (nonatomic, strong) JYCLinePath *path;

@property (nonatomic, strong) NSMutableArray *allPaths;

@end

@implementation JYCDrawPathView

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setUpAll];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpAll];
    }
    return self;
}

- (void)setUpAll
{
    UIPanGestureRecognizer *panGR = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGRAction:)];
    [self addGestureRecognizer:panGR];
}

- (void)panGRAction:(UIPanGestureRecognizer *)sender
{
    CGPoint currentPoint = [sender locationInView:self];
    if (sender.state == UIGestureRecognizerStateBegan) {
        _path = [[JYCLinePath alloc] init];
        
        _path.lineWidth = self.pathWidth;
        
        _path.pathColor = self.pathColor;
        
        [_path moveToPoint:currentPoint];
        
        [self.allPaths addObject:_path];
    }
    
    [_path addLineToPoint:currentPoint];
    
    [self setNeedsDisplay];
}

- (void)clearPath
{
    [self.allPaths removeAllObjects];
    
    [self setNeedsDisplay];
}

- (void)repealComplete:(void (^)(BOOL canContinueRepeal))completeBlock
{
    [self.allPaths removeLastObject];
    
    [self setNeedsDisplay];
    
    if (completeBlock) {
        completeBlock([self canRepeal]);
    }
}

/**
 是否可以撤销
 
 @return 是否可以撤销
 */
- (BOOL)canRepeal
{
    if (self.allPaths.count > 0) {
        return YES;
    } else {
        return NO;
    }
}


#pragma mark -- overWrite

- (void)drawRect:(CGRect)rect
{
    for (JYCLinePath *path in self.allPaths) {
        
        if ([path isKindOfClass:[JYCLinePath class]]) {
            
            [path.pathColor set];
            
            [path stroke];
        }
    }
}

#pragma mark -- 懒加载

- (NSMutableArray *)allPaths
{
    if (!_allPaths) {
        _allPaths = [NSMutableArray array];
    }
    return _allPaths;
}

- (CGFloat)pathWidth
{
    if (!_pathWidth) {
        _pathWidth = 1;
    }
    return _pathWidth;
}

- (UIColor *)pathColor
{
    if (!_pathColor) {
        _pathColor = [UIColor blackColor];
    }
    return _pathColor;
}

@end
