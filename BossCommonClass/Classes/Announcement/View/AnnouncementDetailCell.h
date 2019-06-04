//
//  AnnouncementDetailCell.h
//  AFNetworking
//
//  Created by admin on 2019/4/14.
//

#import <UIKit/UIKit.h>
#import "Media_info.h"

NS_ASSUME_NONNULL_BEGIN
@protocol AnnouncementDetailCellDelegate <NSObject>
////图片点击代理
- (void)imgClick:(Media_info *)model;

@end
@interface AnnouncementDetailCell : UITableViewCell

/**
 图片数据
 */
@property(nonatomic, strong)Media_info *model;
@property(nonatomic, strong)UIImageView *imgView;
@property(nonatomic, weak)id<AnnouncementDetailCellDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
