//
//  AnnouncementRequest.h
//  AFNetworking
//
//  Created by admin on 2019/4/22.
//

#import <Foundation/Foundation.h>
#import "PublishModel.h"
#import "AnnounceListHeader.h"
#import "AnnouncementDetail.h"

NS_ASSUME_NONNULL_BEGIN

/**
 设备类型


 */
typedef NS_ENUM(NSInteger,Device_type)  {
    Device_type_PC = 10,
    Device_type_app_android = 20,
    Device_type_app_ios = 30
};

/**
 设备型号

 */
typedef NS_ENUM(NSInteger, Device_model) {
    Device_model_xiaomi = 10,
    Device_model_huawei = 20,
    Device_model_other = 100
};

/**
 附件来源

 */
typedef NS_ENUM(NSInteger, Domain_type) {
   Domain_typeMessage = 10,//消息
    Domain_typeProfile = 20,//用户头像
    Domain_typeNotice = 30,//公告附件
};

/**
 存储类型
 */
typedef NS_ENUM(NSInteger, Storage_type) {
    Storage_typeQIniu = 1,//七牛
    Storage_typeServerse = 2,//本地服务器
    Storage_typeS3 = 3,
};
@interface AnnouncementRequest : NSObject

/**
 发布公告
 */
+ (void)publishAnnouncemenWithModel:(PublishModel *)model success:(void(^)(void))successBlock fail:(void(^)(NSString *))failBlock;

/**
 公告列表

 @param last_message_id 最后一条message_id(非必传)
 */
+ (void)announcementListLastId:(NSString *)last_message_id page:(NSInteger)currentPage success:(void(^)(NSArray *dataArr,AnnounceListHeader *header))successBlock fail:(void(^)(NSString *))failBlock;

/**
 公告详情

 @param notice_id 消息id
notice.notice.get
 */
+ (void)announcementDetail:(NSString *)notice_id success:(void(^)(AnnouncementDetail *detailModel))successBlock fail:(void(^)(NSString *))failBlock;


/**
 获取通讯录组
 ums.address_book.find
 */
+ (void)announcementContactsPage:(NSInteger)page GroupSuccess:(void(^)(NSArray *dataArr))successBlock fail:(void(^)(NSString *))failBlock;
/**
 获取某一Team的所有成员列表
 ums.team.members
 */
+ (void)announcementContactsMembersId:(NSString *)idStr Success:(void(^)(NSArray *dataArr))successBlock fail:(void(^)(NSString *message))failBlock;

/**
 上传附件
 ums.media.add

 @param dtype 附件来源
 @storage_type
 */
+ (void)uploadDomain_type:(Domain_type)dtype Storage_type:(Storage_type)stype file_type:(NSString *)fileType file_key:(NSString *)key Success:(void(^)(id response))successBlock fail:(void(^)(NSString *message))failBlock;
/**
 获取新token

 */
+ (void)getNewtokenSuccess:(void(^)(id))block;
//ums.session.find 注册session
+ (void)registerSession;
/////公告未读消息
//ums.notice.get_unread_count
+ (void)getNoReadCount:(void(^)(NSInteger count))block;
@end

NS_ASSUME_NONNULL_END
