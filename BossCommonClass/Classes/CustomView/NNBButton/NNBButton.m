//
//  NNBButton.m
//  NNBarKnight
//
//  Created by 贾远潮 on 2017/9/30.
//

#import "NNBButton.h"
#import "BossBasicDefine.h"
@implementation NNBButton

+ (__kindof NNBButton *)buttonWithFrame:(CGRect)frame
{
    NNBButton *nnbButton = [NNBButton buttonWithType:UIButtonTypeSystem];
//    frame.size.height = 44;
    nnbButton.clickEnable = YES;
    nnbButton.frame = frame;
    nnbButton.backgroundColor = [UIColor colorNamed:@"boss_479CFF_1173E4"];
    [nnbButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    nnbButton.titleLabel.font = BossRegularFont(16.f);
    return nnbButton;
}

- (void)setClickEnable:(BOOL)clickEnable
{
    if (_clickEnable != clickEnable) {
        _clickEnable = clickEnable;
        if (clickEnable) {
            self.alpha  = 1;
            self.userInteractionEnabled = YES;
        } else {
            self.alpha = 0.2;
            self.userInteractionEnabled = NO;
        }
    }
}

+ (__kindof NNBButton *)grayButtonWithFrame:(CGRect)frame
{
    NNBButton *nnbButton = [NNBButton buttonWithType:UIButtonTypeSystem];
    frame.size.height = 44;
    nnbButton.frame = frame;
    nnbButton.backgroundColor = [UIColor colorNamed:@"boss_EEEEEE_434343"];
    [nnbButton setTitleColor:[UIColor colorNamed:@"boss_000000-80_FFFFFF"] forState:UIControlStateNormal];
    nnbButton.titleLabel.font = BossRegularFont(16.f);
    return nnbButton;
}


@end
