//
//  ReceiveImageCell.h
//  BossOwner
//
//  Created by 高炀辉 on 2019/6/21.
//  Copyright © 2019 高炀辉. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^imageclick)(void);

@interface ReceiveImageCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *receiveImageView;
@property (weak, nonatomic) IBOutlet UILabel *receiveInfoNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *receiveInfoHeaderImageView;
@property (weak, nonatomic) IBOutlet UIView *receiveInfoView;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIView *messageContentView;

@property (nonatomic, copy) imageclick imageclick;
//@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@end

NS_ASSUME_NONNULL_END
