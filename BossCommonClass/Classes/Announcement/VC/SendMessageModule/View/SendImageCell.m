//
//  SendImageCell.m
//  BossOwner
//
//  Created by 高炀辉 on 2019/6/21.
//  Copyright © 2019 高炀辉. All rights reserved.
//

#import "SendImageCell.h"

@implementation SendImageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.messageContentView.layer.masksToBounds = true;
    self.messageContentView.layer.cornerRadius = 17;
    
    self.sendInfoView.layer.cornerRadius = 20;
    self.sendInfoView.layer.masksToBounds = true;
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
