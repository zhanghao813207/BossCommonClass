//
//  ReceiveImageCell.h
//  BossOwner
//
//  Created by 高炀辉 on 2019/6/21.
//  Copyright © 2019 高炀辉. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ReceiveImageCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *receiveImageView;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIView *messageContentView;
//@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@end

NS_ASSUME_NONNULL_END
