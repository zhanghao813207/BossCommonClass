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
typedef void(^selectContentStatus)(NSString *status);
typedef void(^DismissBlock)(PublishAnnouncementView *view);
@interface PublishAnnouncementView : UIView
@property (nonatomic, strong) NSString *wppId;
@property (nonatomic, strong) NSMutableArray *contentArr;

@property (nonatomic, strong) NSString *proxyId;
@property (nonatomic, copy) DismissBlock dismissBlock;
@property (nonatomic, copy) selectContentStatus selectContentStatus;

@property(nonatomic, weak)id<PublishAnnouncementViewDelegate>delegate;
@end

NS_ASSUME_NONNULL_END
