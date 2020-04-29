//
//  MaskView.m
//  BossCommonClass
//
//  Created by 高炀辉 on 2020/4/13.
//

#import "MaskView.h"

@implementation MaskView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    if (!self.userInteractionEnabled){
        return nil;
    }
    if (self.hidden){
        return nil;
    }
    UIView *view = [super hitTest:point withEvent:event];
    NSLog(@"fittest->%@",view);
    return view;
}
@end
