//
//  BossMessageRequest.h
//  BossCommonClass
//
//  Created by 贾远潮 on 2018/9/2.
//

#import <Foundation/Foundation.h>
#import "BossNoticeMessageModel.h"
#import "BossAssistantMessageModel.h"
#import "BossBasicDefine.h"


@interface BossMessageRequest : NSObject

/**
 Boss通知消息列表

 @param page 页码
 @param limmit 限制
 @param successBlock 成功的返回列表
 @param failBlock 服务器响应失败
 */
+ (void)msgRequestGetSysChannelMessageWithPage:(NSInteger)page limit:(NSInteger)limmit success:(void(^)(NSArray <BossNoticeMessageModel *>*msgList))successBlock fail:(void(^)(id error))failBlock;

/**
 Boss助理消息列表
 
 @param page 页码
 @param limmit 限制
 @param successBlock 成功的返回列表
 @param failBlock 服务器响应失败
 */
+ (void)msgRequestGetBaChannelMessageWithPage:(NSInteger)page limit:(NSInteger)limmit success:(void(^)(NSArray <BossAssistantMessageModel *>*msgList))successBlock fail:(void(^)(id error))failBlock;

/**
 标记消息状态

 @param msgIds 被标记的消息ids
 @param channelId 渠道ID 总线 SYS\BA
 @param type 消息类型
 @param successBlock 标记是否成功
 @param failBlock 服务器响应失败
 */
+ (void)msgRequestMarkMsgStateWithMsgIds:(NSArray *)msgIds channelId:(NSString *)channelId state:(MESSAGE_TYPE)type success:(void(^)(BOOL ok))successBlock fail:(void(^)(id error))failBlock;

/**
 消息计数器

 @param channelId 总线 SYS\BA
 @param states 需要计数的消息类型 数组
 @param successBlock 计数结果
 @param failBlock 服务器响应失败
 */
+ (void)msgRequestCountMsgWithChannleId:(NSString *)channelId state:(NSArray *)states success:(void(^)(NSInteger cnt))successBlock fail:(void(^)(id error))failBlock;

@end
