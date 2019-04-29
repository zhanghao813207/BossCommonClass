//
//  AnnouncementDetailVC.h
//  AFNetworking
//
//  Created by admin on 2019/4/14.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^CountBlock)(NSInteger count);
@interface AnnouncementDetailVC : UIViewController

/**
 只需要一个id 不传listmodel了
 */
@property(nonatomic, copy)NSString *idStr;
@property(nonatomic, assign)BOOL isMe;
@property(nonatomic, copy)CountBlock block;
@end

NS_ASSUME_NONNULL_END
