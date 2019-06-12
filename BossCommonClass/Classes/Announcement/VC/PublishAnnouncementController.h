//
//  PublishAnnouncementController.h
//  AFNetworking
//
//  Created by admin on 2019/4/17.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol PublishAnnouncementControllerDelegate <NSObject>

- (void)publishSuccess;

@end

@interface PublishAnnouncementController : UIViewController
@property(nonatomic, weak)id<PublishAnnouncementControllerDelegate>delegate;

@property (nonatomic, strong) NSString *wppId;

@property (nonatomic, strong) NSString *proxyId;
@end

NS_ASSUME_NONNULL_END
