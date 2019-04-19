//
//  AnnouncementDetailCell.h
//  AFNetworking
//
//  Created by admin on 2019/4/14.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol AnnouncementDetailCellDelegate <NSObject>

- (void)imgClick:(NSString *)model;

@end
@interface AnnouncementDetailCell : UITableViewCell
@property(nonatomic, copy)NSArray *testImgStr;
@property(nonatomic, strong)UIImageView *imgView;
@property(nonatomic, weak)id<AnnouncementDetailCellDelegate>delegate;
@end

NS_ASSUME_NONNULL_END
