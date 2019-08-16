//
//  BossMessageRequest.m
//  BossCommonClass
//
//  Created by 贾远潮 on 2018/9/2.
//

#import "BossMessageRequest.h"
#import "NNBBasicRequest.h"
#import "BossManagerAccount.h"
#import "SaasModel.h"
#import "NNBRequestManager.h"

@implementation BossMessageRequest

/**
 Boss通知消息列表
 
 @param page 页码
 @param limmit 限制
 @param successBlock 成功的返回列表
 @param failBlock 服务器响应失败
 */
+ (void)msgRequestGetSysChannelMessageWithPage:(NSInteger)page limit:(NSInteger)limmit success:(void(^)(NSArray <BossNoticeMessageModel *>*msgList))successBlock fail:(void(^)(id error))failBlock
{
    if (!kCurrentBossManagerAccount.accountModel._id) {
        return;
    }
    NSDictionary *paramDic = @{
                               @"_meta":@{
                                       @"page":@(page),
                                       @"limit":@(limmit),
                                       },
                               @"broad_type":@(BROAD_TYPE_ORIERN),
                               @"state":@[@(MESSAGE_TYPE_NEW),@(MESSAGE_TYPE_SEND),@(MESSAGE_TYPE_READ)],
                               @"account_ids":@[kCurrentBossManagerAccount.accountModel._id]
                               };
    
    [NNBBasicRequest postJsonWithUrl:kUrl parameters:paramDic CMD:@"notify.message_bus.sys_channel" success:^(id responseObject) {
        DLog(@"%@", responseObject);
        if (!successBlock) {
            return;
        }
        NSMutableArray *array = [NSMutableArray array];
        for (NSDictionary* dataDic in responseObject[@"data"]) {
            BossNoticeMessageModel *model = [[BossNoticeMessageModel alloc] init];
            [model setValuesForKeysWithDictionary:dataDic];
            [array addObject:model];
        }
        successBlock([array copy]);
    } fail:^(id error) {
        if(failBlock){
            failBlock(error);
        }
    }];
}

/**
 Boss助理消息列表
 
 @param page 页码
 @param limmit 限制
 @param successBlock 成功的返回列表
 @param failBlock 服务器响应失败
 */
+ (void)msgRequestGetBaChannelMessageWithPage:(NSInteger)page limit:(NSInteger)limmit success:(void(^)(NSArray <BossAssistantMessageModel *>*msgList))successBlock fail:(void(^)(id error))failBlock
{
    if (!kCurrentBossManagerAccount.accountModel._id) {
        return;
    }
    NSDictionary *paramDic = @{
                               @"_meta":@{
                                       @"page":@(page),
                                       @"limit":@(limmit),
                                       },
                               @"broad_type":@(BROAD_TYPE_ORIERN),
                               @"state":@[@(MESSAGE_TYPE_NEW),@(MESSAGE_TYPE_SEND),@(MESSAGE_TYPE_READ)],
                               @"account_ids":@[kCurrentBossManagerAccount.accountModel._id],
                               };
    [NNBBasicRequest postJsonWithUrl:kUrl parameters:paramDic CMD:@"notify.message_bus.ba_channel" success:^(id responseObject) {
        NSLog(@"%@", responseObject);
        if (!successBlock) {
            return;
        }
        NSMutableArray *array = [NSMutableArray array];
        for (NSDictionary* dataDic in responseObject[@"data"]) {
            BossAssistantMessageModel *model = [[BossAssistantMessageModel alloc] init];
            [model setValuesForKeysWithDictionary:dataDic];
            [array addObject:model];
        }
        successBlock([array copy]);
    } fail:^(id error) {
        if(failBlock){
            failBlock(error);
        }
    }];
}

/**
 标记消息状态
 
 @param msgIds 被标记的消息ids
 @param channelId 渠道ID 总线 SYS\BA
 @param type 消息类型
 @param successBlock 标记是否成功
 @param failBlock 服务器响应失败
 */
+ (void)msgRequestMarkMsgStateWithMsgIds:(NSArray *)msgIds channelId:(NSString *)channelId state:(MESSAGE_TYPE)type success:(void(^)(BOOL ok))successBlock fail:(void(^)(id error))failBlock
{
    NSDictionary *paramDic = @{
                               @"ids":msgIds,
                               @"channel_id":channelId,
                               @"state":@(type),
                               };
    
    [NNBBasicRequest postJsonWithUrl:kUrl parameters:paramDic CMD:@"notify.message_bus.mark_state" success:^(id responseObject) {
//        DLog(@"%@", responseObject);
        DLog(@"消息已读请求完毕结果:%@ 参数:%@",responseObject,paramDic);

        if (!successBlock) {
            return;
        }
        successBlock([responseObject[@"ok"] boolValue]);
    } fail:^(id error) {
        if(failBlock){
            failBlock(error);
        }
    }];
}

/**
 消息计数器
 
 @param channelId 总线 SYS\BA
 @param states 需要计数的消息类型 数组
 @param successBlock 计数结果
 @param failBlock 服务器响应失败
 */
+ (void)msgRequestCountMsgWithChannleId:(NSString *)channelId state:(NSArray *)states success:(void(^)(NSInteger cnt))successBlock fail:(void(^)(id error))failBlock
{
    NSDictionary *paramDic = @{
                               @"channel_id":channelId,
                               @"state":states,
                               };
    [NNBBasicRequest postJsonWithUrl:kUrl parameters:paramDic CMD:@"notify.message_bus.channel_counter" success:^(id responseObject) {
        DLog(@"助理消息条数%@", responseObject);
        if (!successBlock) {
            return;
        }
        successBlock([responseObject[@"cnt"] integerValue]);
    } fail:^(id error) {
        if(failBlock){
            failBlock(error);
        }
    }];
}

@end
