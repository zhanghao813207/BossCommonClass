//
//  ProtocollAlertView.m
//  AFNetworking
//
//  Created by yjs on 2019/8/5.
//

#import "ProtocollAlertView.h"

@implementation ProtocollAlertView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        NSBundle *baseBundle = [NSBundle bundleForClass:[self class]];
        NSURL *bundleUrl = [baseBundle URLForResource:@"BossCommonClass" withExtension:@"bundle"];
        NSBundle *currentBundle = [NSBundle bundleWithURL:bundleUrl];
        self = [[currentBundle loadNibNamed:@"ProtocollAlertView" owner:self options:nil] firstObject];
        self.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        [self setView];
    }
    return self;
}

#pragma mark - 给view添加点击手势
- (void)setView{
    
    UITapGestureRecognizer *backGroundViewClicked = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backGroundViewClicked)];
    backGroundViewClicked.numberOfTapsRequired = 1;
    
    [self.backGroundView addGestureRecognizer:backGroundViewClicked];
    
    // 左上和右上为圆角
    UIBezierPath *cornerRadiusPath = [UIBezierPath bezierPathWithRoundedRect:self.protocolBgView.bounds byRoundingCorners:UIRectCornerTopRight | UIRectCornerTopLeft cornerRadii:CGSizeMake(8, 8)];
    CAShapeLayer *cornerRadiusLayer = [[CAShapeLayer alloc] init];
    cornerRadiusLayer.frame = self.protocolBgView.bounds;
    cornerRadiusLayer.path = cornerRadiusPath.CGPath;
    self.protocolBgView.layer.mask = cornerRadiusLayer;
    self.protocolBgView.clipsToBounds = true;
    
    
}

- (void)backGroundViewClicked{
    
//    [self removeFromSuperview];
    
}
- (IBAction)agreeAction:(id)sender {
    if(self.agreeBlock){
        self.agreeBlock();
    }
    [self removeFromSuperview];
}

- (IBAction)softProtocolAction:(id)sender {
    if(self.softBlock){
        self.softBlock();
    }
}

- (IBAction)privacyProtocolAction:(id)sender {
    if(self.privacyBlock){
        self.privacyBlock();
    }
    
}


- (IBAction)exitAppAction:(id)sender {
    //    exit(1)是异常退出;
    //正常退出;
    exit(0);
    
}


@end
