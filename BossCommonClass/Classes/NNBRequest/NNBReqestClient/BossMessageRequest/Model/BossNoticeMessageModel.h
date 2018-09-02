//
//  BossNoticeMessageModel.h
//  AFNetworking
//
//  Created by 贾远潮 on 2018/9/2.
//

#import "CommonMassageModel.h"
#import "EventExtraModel.h"

@interface BossNoticeMessageModel : CommonMassageModel

/**
 消息总线名称
 */
@property (nonatomic, strong) NSString *channel_name;

/**
 广播类型名称
 */
@property (nonatomic, strong) NSString *broad_type_title;

/**
 事件ID
 */
@property (nonatomic, assign) OA_EVENT event_id;

/**
 事件名称
 */
@property (nonatomic, strong) NSString *event_title;

/**
 事件参数
 */
@property (nonatomic, strong) EventExtraModel *event_extra;

/**
 是否已送达
 */
@property (nonatomic, assign) BOOL is_sent;

/**
 是否已读取
 */
@property (nonatomic, assign) BOOL is_read;

/**
 是否已完成
 */
@property (nonatomic, assign) BOOL is_done;

/**
 是否已删除
 */
@property (nonatomic, assign) BOOL is_deleted;

@end
