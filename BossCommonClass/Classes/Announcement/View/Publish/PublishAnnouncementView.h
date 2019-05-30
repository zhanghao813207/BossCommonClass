//
//  PublishAnnouncementView.h
//  AFNetworking
//
//  Created by admin on 2019/4/15.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class PublishAnnouncementView;
@protocol PublishAnnouncementViewDelegate <NSObject>

/**
 发布成功
 */
- (void)publishSuccess;

@end
typedef void(^DismissBlock)(PublishAnnouncementView *view);
@interface PublishAnnouncementView : UIView
@property (nonatomic, strong) NSString *wppId;
@property (nonatomic, copy) DismissBlock dismissBlock;
@property(nonatomic, weak)id<PublishAnnouncementViewDelegate>delegate;
@end

NS_ASSUME_NONNULL_END
