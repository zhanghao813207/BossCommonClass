//
//  SendImageCell.h
//  BossOwner
//
//  Created by 高炀辉 on 2019/6/21.
//  Copyright © 2019 高炀辉. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
/// 图片点击回调
typedef void(^imageclick)(void);
/// 消息重发回调
typedef void(^resetSendmessageBlock)(NSInteger index);

@interface SendImageCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *messageContentView;
@property (weak, nonatomic) IBOutlet UIImageView *sendImageView;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (weak, nonatomic) IBOutlet UILabel *sendInfoNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *sendInfoHeaderImageView;
@property (weak, nonatomic) IBOutlet UIView *sendInfoView;

@property (nonatomic, copy) imageclick imageclick;

@property (nonatomic, copy) resetSendmessageBlock resetSendmessageBlock;

@property (weak, nonatomic) IBOutlet UIButton *resetSendMessageButton;
/// 加载动画
@property (weak, nonatomic) IBOutlet UIImageView *sendmessageLoadingImageView;

//@property (weak,)
@end

NS_ASSUME_NONNULL_END
