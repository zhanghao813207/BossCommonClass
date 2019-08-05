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
//        [self setView];
    }
    return self;
}

@end
