//
//  ReceiveMessageCell.h
//  BossOwner
//
//  Created by 高炀辉 on 2019/6/21.
//  Copyright © 2019 欧客云. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ReceiveMessageCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *messageContentView;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *receiveInfoNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *receiveInfoHeaderImageView;
@property (weak, nonatomic) IBOutlet UIView *receiveInfoView;
@end

NS_ASSUME_NONNULL_END
