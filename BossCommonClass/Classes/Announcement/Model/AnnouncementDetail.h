
//
//  AnnouncementDetail.h
//  AFNetworking
//
//  Created by admin on 2019/4/22.
//

#import <Foundation/Foundation.h>
#import "Sender_info.h"
#import "Message_counter_info.h"
NS_ASSUME_NONNULL_BEGIN

@interface AnnouncementDetail : NSObject
@property(nonatomic, copy)NSString *_id;

/**
 公告内容
 */
@property(nonatomic, copy)NSString *content;

/**
 发布时间
 */
@property(nonatomic, copy)NSString *created_at;
@property(nonatomic, copy)NSString *time;

/**
 附件列表id
 */
@property(nonatomic, strong)NSArray *media_ids;

/**
 附件列表信息
 */
@property(nonatomic, strong)NSArray *media_info_list;
@property(nonatomic, strong)NSArray *member_info_list;
@property(nonatomic, assign)NSInteger message_mime_kind;

/**
 发布人信息
 */
@property(nonatomic, strong)Sender_info *sender_info;
@property(nonatomic, strong)Message_counter_info *message_counter_info;
@end

NS_ASSUME_NONNULL_END
