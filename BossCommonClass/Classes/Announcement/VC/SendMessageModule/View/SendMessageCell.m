//
//  SendMessageCell.m
//  BossOwner
//
//  Created by 高炀辉 on 2019/6/21.
//  Copyright © 2019 高炀辉. All rights reserved.
//

#import "SendMessageCell.h"

@implementation SendMessageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.messageContentView.layer.cornerRadius = 17;
//    self.headerImageView.layer.cornerRadius = 20;
    self.sendInfoView.layer.cornerRadius = 20;
    self.sendInfoView.layer.masksToBounds = true;
}
- (void)cellWillDisplaySignalling{
    
}
- (void)prepareForReuse {
    [super prepareForReuse];
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    //默认是顺时针效果，若将fromValue和toValue的值互换，则为逆时针效果
    animation.fromValue = @(0.f);
    animation.removedOnCompletion = false;
    animation.toValue = @(M_PI *2);
    animation.duration  = 1.f;
    animation.autoreverses = NO;
    animation.fillMode =kCAFillModeForwards;
    animation.repeatCount = MAXFLOAT; //如果这里想设置成一直自旋转，可以设置为MAXFLOAT，否则设置具体的数值则代表执行多少次
    [self.sendmessageLoadingImageView.layer addAnimation:animation forKey:nil];
}
- (IBAction)resetSendMessage:(UIButton *)sender {
    if (self.resetSendmessageBlock) {
        self.resetSendmessageBlock(sender.tag);
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
