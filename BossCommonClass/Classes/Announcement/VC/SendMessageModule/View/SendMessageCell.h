//
//  SendMessageCell.h
//  BossOwner
//
//  Created by 高炀辉 on 2019/6/21.
//  Copyright © 2019 欧客云. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
/// 消息重发回调
typedef void(^resetSendmessageBlock)(NSInteger index);

@interface SendMessageCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *messageContentView;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
//@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UILabel *sendInfoNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *sendInfoHeaderImageView;
@property (weak, nonatomic) IBOutlet UIView *sendInfoView;
@property (weak, nonatomic) IBOutlet UIButton *resetSendMessageButton;

@property (nonatomic, copy) resetSendmessageBlock resetSendmessageBlock;

@property (weak, nonatomic) IBOutlet UIImageView *sendmessageLoadingImageView;
@property (nonatomic, strong)CABasicAnimation *animation;
 
@end

NS_ASSUME_NONNULL_END
