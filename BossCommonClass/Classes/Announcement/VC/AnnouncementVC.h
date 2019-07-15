//
//  AnnouncementVC.h
//  AFNetworking
//
//  Created by admin on 2019/4/14.
//

#import <UIKit/UIKit.h>
#import "Message.h"
#import "BossViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface AnnouncementVC : BossViewController

@property (nonatomic, strong) Message *messageModel;

@end

NS_ASSUME_NONNULL_END
