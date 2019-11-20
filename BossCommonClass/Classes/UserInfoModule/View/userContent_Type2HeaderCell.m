//
//  userContent_Type2HeaderCell.m
//  BossKnight
//
//  Created by 高炀辉 on 2019/7/17.
//  Copyright © 2019 贾远潮. All rights reserved.
//

#import "userContent_Type2HeaderCell.h"
#import "BossOwnerAccount.h"

@implementation userContent_Type2HeaderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.nameLabel.text = kCurrentBossOwnerAccount.accountModel.name;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
