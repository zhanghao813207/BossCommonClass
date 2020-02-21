//
//  NNBTextField.m
//  NnbSeller
//
//  Created by 贾远潮 on 2017/11/24.
//

#import "NNBTextField.h"
#import "BossBasicDefine.h"

@implementation NNBTextField

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.font = BossBlodFont(14.f);
        self.leftView = ({
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 35)];
            view;
        });
        self.textColor = kHexRGBA(0x000000, 0.8);
        self.leftViewMode = UITextFieldViewModeAlways;
        self.layer.borderWidth = 0.5f;
        self.layer.borderColor = kHexRGBA(0x000000, 0.2).CGColor;
        self.layer.cornerRadius = 2.f;
        self.layer.masksToBounds = YES;
    }
    return self;
}

@end
