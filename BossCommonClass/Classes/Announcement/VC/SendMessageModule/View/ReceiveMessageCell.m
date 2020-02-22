//
//  ReceiveMessageCell.m
//  BossOwner
//
//  Created by 高炀辉 on 2019/6/21.
//  Copyright © 2019 欧客云. All rights reserved.
//

#import "ReceiveMessageCell.h"

@implementation ReceiveMessageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.messageContentView.layer.cornerRadius = 17;
    
    self.receiveInfoView.layer.cornerRadius = 20;
    self.receiveInfoView.layer.masksToBounds = true;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
