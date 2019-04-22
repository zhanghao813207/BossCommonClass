//
//  AnnouncementRequest.h
//  AFNetworking
//
//  Created by admin on 2019/4/22.
//

#import <Foundation/Foundation.h>
#import "PublishModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface AnnouncementRequest : NSObject

/**
 发布公告
 */
+ (void)publishAnnouncemenWithModel:(PublishModel *)model success:(void(^)(void))successBlock fail:(void(^)(NSString *))failBlock;

/**
 公告列表

 @param last_message_id 最后一条message_id(非必传)
 */
+ (void)announcementListLastId:(NSString *)last_message_id success:(void(^)(void))successBlock fail:(void(^)(NSString *))failBlock;

/**
 公告详情

 @param notice_id 消息id
notice.notice.get
 */
+ (void)announcementDetail:(NSString *)notice_id success:(void(^)(void))successBlock fail:(void(^)(NSString *))failBlock;


/**
 获取通讯录组
 ums.address_book.find
 */
+ (void)announcementContactsGroupSuccess:(void(^)(void))successBlock fail:(void(^)(NSString *))failBlock;
/**
 获取某一Team的所有成员列表
 ums.team.members
 */
+ (void)announcementContactsMembersSuccess:(void(^)(void))successBlock fail:(void(^)(NSString *))failBlock;
@end

NS_ASSUME_NONNULL_END
