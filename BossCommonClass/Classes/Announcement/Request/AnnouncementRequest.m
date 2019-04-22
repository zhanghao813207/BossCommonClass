
//
//  AnnouncementRequest.m
//  AFNetworking
//
//  Created by admin on 2019/4/22.
//

#import "AnnouncementRequest.h"
#import "NNBBasicRequest.h"
#import "BossCache.h"
#import "BossManagerAccount.h"

@implementation AnnouncementRequest
+ (void)publishAnnouncemenWithModel:(PublishModel *)model success:(void(^)(void))successBlock fail:(void(^)(NSString *))failBlock {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"title"] = model.title;
    dic[@"members"] = model.members;
    dic[@"content"] = model.content;
    if (model.media_ids.count > 0) {
        dic[@"media_ids"] = model.media_ids;
    }
    NSLog(@"%@",dic);
    [NNBBasicRequest postJsonWithUrl:kUrl  parameters:dic CMD:@"notice.notice.add" success:^(id responseObject) {
        
    } fail:^(id error) {
        failBlock(@"");
    }];
}
/**
 公告列表
 
 @param last_message_id 最后一条message_id(非必传)
 */
+ (void)announcementListLastId:(NSString *)last_message_id success:(void(^)(void))successBlock fail:(void(^)(NSString *))failBlock {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    if (last_message_id) {
        dic[@"last_message_id"] = last_message_id;
    }
    dic[@"account_id"] = kCurrentBossManagerAccount.tokenModel.account_id;
    [NNBBasicRequest postJsonWithUrl:kUrl  parameters:dic CMD:@"notice.notice.find" success:^(id responseObject) {
        
    } fail:^(id error) {
        failBlock(@"");
    }];
}
/**
 公告详情
 
 @param notice_id 消息id
 notice.notice.get
 */
+ (void)announcementDetail:(NSString *)notice_id success:(void(^)(void))successBlock fail:(void(^)(NSString *))failBlock {
    NSDictionary *dic = @{@"notice_id":notice_id};
    [NNBBasicRequest postJsonWithUrl:kUrl  parameters:dic CMD:@"notice.notice.get" success:^(id responseObject) {
        
    } fail:^(id error) {
        failBlock(@"");
    }];
}
/**
 获取通讯录组
 ums.address_book.find
 */
+ (void)announcementContactsGroupSuccess:(void(^)(void))successBlock fail:(void(^)(NSString *))failBlock {
    NSDictionary *dic = @{@"account_id" : kCurrentBossManagerAccount.tokenModel.account_id};
    [NNBBasicRequest postJsonWithUrl:kUrl  parameters:dic CMD:@"ums.address_book.find" success:^(id responseObject) {
        
    } fail:^(id error) {
        failBlock(@"");
    }];
//    kCurrentBossManagerAccount.tokenModel.account_id
}
/**
 获取某一Team的所有成员列表
 ums.team.members
 */
+ (void)announcementContactsMembersSuccess:(void(^)(void))successBlock fail:(void(^)(NSString *))failBlock {
    NSDictionary *dic = @{@"team_id":@"XXXXX"};
    [NNBBasicRequest postJsonWithUrl:kUrl  parameters:dic CMD:@"ums.address_book.find" success:^(id responseObject) {
        
    } fail:^(id error) {
        failBlock(@"");
    }];
}
@end
