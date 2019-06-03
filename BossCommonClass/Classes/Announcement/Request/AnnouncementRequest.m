
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
#import "TokenModel.h"
#import "BossMethodDefine.h"
#import "MQTTClientModel.h"
#import "ContactsGroup.h"
#import "MJExtension.h"
#import "ContactsPerson.h"
#import "AnnoucementList.h"
#import "AnnouncementDetail.h"
#import "ContactsGroup.h"
#import "JYCSimpleToolClass.h"
#import "ContactsChild.h"


@interface AnnouncementRequest ()
@property (nonatomic,strong) MQTTCFSocketTransport *myTransport;
@property (nonatomic, strong)MQTTSessionManager *sessionManager;
@end

@implementation AnnouncementRequest
+ (void)publishAnnouncemenWithModel:(PublishModel *)model success:(void(^)(void))successBlock fail:(void(^)(NSString *))failBlock {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"title"] = model.title;
    NSMutableArray *tempArr = [NSMutableArray array];
    for (ContactsGroup *tempModel in model.members) {
        [tempArr addObject:tempModel.target_id];
    }
    dic[@"members"] = tempArr;
    dic[@"content"] = model.content;
    NSLog(@"%@",model.media_ids);
    if (model.media_ids.count > 0) {
        dic[@"media_ids"] = model.media_ids;
    }
    NSLog(@"%@",dic);
    [NNBBasicRequest postJsonWithUrl:MessageBasicURL  parameters:dic CMD:@"ums.notice.add" success:^(id responseObject) {
        NSLog(@"%@",responseObject);
        successBlock();
    } fail:^(id error) {
        NSLog(@"%@",error);
        failBlock(@"");
    }];
}
/**
 公告列表
 
 @param last_message_id 最后一条message_id(非必传)
 */
+ (void)announcementListLastId:(NSString *)last_message_id page:(NSInteger)currentPage success:(void(^)(NSArray *dataArr,AnnounceListHeader *header))successBlock fail:(void(^)(NSString *))failBlock{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:@(currentPage) forKey:@"page"];
    [dic setValue:@{@"limit":@(20)} forKey:@"_meta"];
    
//    if (last_message_id) {
//        dic[@"last_message_id"] = last_message_id;
//    }
//    dic[@"account_id"] = kCurrentBossManagerAccount.tokenModel.account_id;
    [NNBBasicRequest postJsonWithUrl:MessageBasicURLV2  parameters:dic CMD:@"ums.notice.find" success:^(id responseObject) {
        DLog(@"%@",responseObject);
        NSArray *dataArr = [AnnoucementList mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        NSArray *tempArr;
        if (currentPage > 1) {
            tempArr = dataArr;
        }else {
            tempArr = [[dataArr reverseObjectEnumerator] allObjects];
        }
        
        AnnounceListHeader *header = [AnnounceListHeader mj_objectWithKeyValues:responseObject[@"_meta"]];
        successBlock(tempArr,header);
    } fail:^(id error) {
        NSLog(@"%@",error);
        failBlock(@"");
    }];
}
/**
 公告详情
 
 @param notice_id 消息id
 ums.notice.get
 */
+ (void)announcementDetail:(NSString *)notice_id success:(void(^)(AnnouncementDetail *detailModel))successBlock fail:(void(^)(NSString *))failBlock {
    NSDictionary *dic = @{@"notice_id":notice_id};
    [NNBBasicRequest postJsonWithUrl:MessageBasicURL  parameters:dic CMD:@"ums.notice.get" success:^(id responseObject) {
//        NSLog(@"%@",responseObject);
       AnnouncementDetail *model = [AnnouncementDetail mj_objectWithKeyValues:responseObject];
        successBlock(model);
    } fail:^(id error) {
        failBlock(@"");
    }];
}
/**
 获取通讯录组
 ums.address_book.find
 */
+ (void)announcementContactsPage:(NSInteger)page GroupSuccess:(void(^)(NSArray *dataArr))successBlock fail:(void(^)(NSString *))failBlock {
//    NSDictionary *dic = @{@"account_id" : kCurrentBossManagerAccount.tokenModel.account_id};
    NSDictionary *dic = @{@"account_id" : kCurrentBossManagerAccount.tokenModel.account_id,@"target_type" : @(30),@"_meta":@{@"limit":@(0)}};

    [NNBBasicRequest postJsonWithUrl:MessageBasicURLV2  parameters:dic CMD:@"ums.address_book.find" success:^(id responseObject) {
        NSLog(@"%@",responseObject);
        NSMutableArray *dataArr = [NSMutableArray array];
        dataArr = [ContactsGroup mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        NSMutableArray *tempArr = [NSMutableArray array];
        for (ContactsGroup *group in dataArr) {
            if (group.children.count > 0) {
                for (ContactsChild *child in group.children) {
                    ContactsGroup *group = [[ContactsGroup alloc] init];
                    group.target_id = child.target_id;
                    group.name = child.name;
                    group.head_img_url = child.head_img_url;
                    [tempArr addObject:group];
                }
            }
        }
        for (ContactsGroup *group in tempArr.reverseObjectEnumerator) {
            [dataArr insertObject:group atIndex:1];
        }
        successBlock(dataArr);
    } fail:^(id error) {
        NSLog(@"%@",error);
        failBlock(@"");
    }];
//    kCurrentBossManagerAccount.tokenModel.account_id
}
/**
 获取某一Team的所有成员列表
 ums.team.members
 */
+ (void)announcementContactsMembersId:(NSString *)idStr Success:(void(^)(NSArray *dataArr))successBlock fail:(void(^)(NSString *message))failBlock{
    NSDictionary *dic = @{@"team_id":idStr,@"_meta":@{@"limit":@(0)}};
    [NNBBasicRequest postJsonWithUrl:MessageBasicURLV2  parameters:dic CMD:@"ums.team.members" success:^(id responseObject) {
        NSLog(@"%@",responseObject);
        NSArray *dataArr = [ContactsPerson mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        successBlock(dataArr);
    } fail:^(id error) {
        failBlock(@"");
    }];
}

/**
 上传附件
 ums.media.add
 
 @param dtype 附件来源
 @storage_type
 */
+ (void)uploadDomain_type:(Domain_type)dtype Storage_type:(Storage_type)stype file_type:(NSString *)fileType file_key:(NSString *)key Success:(void(^)(id response))successBlock fail:(void(^)(NSString *message))failBlock {
    NSDictionary *dic = @{@"domain_type": @(Domain_typeNotice),@"file_key":key,@"storage_type":@(Storage_typeQIniu),@"file_type":fileType};
    [NNBBasicRequest postJsonWithUrl:MessageBasicURLV2  parameters:dic CMD:@"ums.media.add" success:^(id responseObject) {
        NSLog(@"%@",responseObject);
        successBlock(responseObject);
    } fail:^(id error) {
        failBlock(@"");
    }];
}



// 监听当前连接状态
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    switch (self.sessionManager.state) {
            case MQTTSessionManagerStateClosed:
            NSLog(@"连接已经关闭");
            break;
            case MQTTSessionManagerStateClosing:
            NSLog(@"连接正在关闭");
            
            break;
            case MQTTSessionManagerStateConnected:
            NSLog(@"已经连接");
            
            break;
            case MQTTSessionManagerStateConnecting:
            NSLog(@"正在连接中");
            
            break;
            case MQTTSessionManagerStateError: {
                NSString *errorCode = self.sessionManager.lastErrorCode.localizedDescription;
                NSLog(@"连接异常 ----- %@",errorCode);
            }
            break;
            case MQTTSessionManagerStateStarting:
            NSLog(@"开始连接");
            break;
        default:
            break;
    }
}
- (MQTTSSLSecurityPolicy *)customSecurityPolicy
{
    
    MQTTSSLSecurityPolicy *securityPolicy = [MQTTSSLSecurityPolicy policyWithPinningMode:MQTTSSLPinningModeNone];
    
    securityPolicy.allowInvalidCertificates = YES;
    securityPolicy.validatesCertificateChain = YES;
    securityPolicy.validatesDomainName = NO;
    return securityPolicy;
}
+ (void)getNewtokenSuccess:(void(^)(id))block {
    
    NSDictionary *dic = @{@"app_code":APPCODE};
    [NNBBasicRequest postJsonWithUrl:kUrl  parameters:dic CMD:@"auth.token.get_ums_access_token" success:^(id responseObject) {
        NSLog(@"%@",responseObject[@"access_token"]);
#warning newToken需调整 ums_access_token
        [kUserDefault setValue:responseObject[@"access_token"] forKey:@"newToken"];
        [kUserDefault setValue:responseObject[@"account_id"] forKey:@"account_id"];
        NSLog(@"%@",responseObject);
        
        kCache.checkStartUMS = YES;
        
        [[MQTTClientModel sharedInstance] bindWithUserName:@"im_server" password:@"im_server-123" cliendId:[NSString stringWithFormat:@"im_server%@%@",[JYCSimpleToolClass getUUID],responseObject[@"account_id"]] isSSL:false];
        [AnnouncementRequest registerSession];
//        [MQTTClientModel sharedInstance].delegate = self;
        [[MQTTClientModel sharedInstance] subscribeTopic:responseObject[@"account_id"]];
        block(responseObject);
    } fail:^(id error) {
        NSLog(@"%@",error);
    }];
}

/**
 ums.session.find
 */
+ (void)registerSession {
    NSString * deviceToken = [kUserDefault objectForKey:@"deviceToken"];
    if (!deviceToken) {
        return;
    }
    NSDictionary *dic = @{@"device_type":@(Device_type_app_ios),@"device_no":[JYCSimpleToolClass getUUID],@"device_model":@(Device_model_other),@"device_token":deviceToken};
    NSLog(@"%@",dic);
    [NNBBasicRequest postJsonWithUrl:MessageBasicURL  parameters:dic CMD:@"ums.session.add" success:^(id responseObject) {
        NSLog(@"fdfdfdfd%@",responseObject);
    } fail:^(id error) {
        NSLog(@"%@",error);
    }];
}
//ums.notice.get_unread_count
+ (void)getNoReadCount:(void(^)(NSInteger count))block {
    [NNBBasicRequest postJsonWithUrl:MessageBasicURL  parameters:@{} CMD:@"ums.notice.get_unread_count" success:^(id responseObject) {
        if (responseObject[@"count"]) {
           block([responseObject[@"count"] integerValue]);
        }
    } fail:^(id error) {
        NSLog(@"%@",error);
    }];
}
@end
