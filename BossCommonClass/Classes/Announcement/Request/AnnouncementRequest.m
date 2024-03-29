
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
@import boss_basic_common_ios;

@interface AnnouncementRequest ()
@property (nonatomic,strong) MQTTCFSocketTransport *myTransport;
@property (nonatomic, strong)MQTTSessionManager *sessionManager;
@end

#ifdef DEBUG

#define SLog(format, ...) printf("class: <%p %s:(%d) > method: %s \n%s\n", self, [[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, __PRETTY_FUNCTION__, [[NSString stringWithFormat:(format), ##__VA_ARGS__] UTF8String] )

#else

#define SLog(format, ...)

#endif

@implementation AnnouncementRequest

+ (void)getBossAdminUmsAccessTokenInfo:(void(^)(void))successBlock failBlock:(void(^)(void))failBlock {

    NSDictionary *paramDic = @{
        @"app_code":APPCODE
    };
    
    [NNBBasicRequest postJsonWithUrl:kUrl  parameters:paramDic CMD:@"auth.token.get_ums_access_token" success:^(id responseObject) {
        NSLog(@"AnnouncementRequest->getUmsAccesstokenInfo->response:\n%@",responseObject);
        
        // 缓存UMS Token
        UmsAccessTokenModel *umsAccessTokenModel = [[UmsAccessTokenModel alloc] initWithDictionary:responseObject];
        umsAccessTokenModel.bossAccountId = kCurrentBossManagerAccount.accountModel._id;
        
        kCache.umsAccessTokenModel = umsAccessTokenModel;
        
        [[NSUserDefaults standardUserDefaults] setObject:[umsAccessTokenModel toDictionary] forKey:@"umsAccessTokenModel"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        kCache.checkStartUMS = YES;
        
        successBlock();
    } fail:^(id error) {
        NSLog(@"%@",error);
    }];
}

+ (void)findMessageList:(void(^)(MessageListDicModel *messageListDicModel))successBlock failBlock:(void(^)(void))failBlock {
    NSDictionary *paramDic = @{};
    
    [NNBBasicRequest postJsonWithUrl:kUrl  parameters:paramDic CMD:@"message.address_book.find_message_wpp_list" success:^(id responseObject) {
        NSLog(@"AnnouncementRequest->findMessageList->response:\n%@",responseObject);
        
        MessageListDicModel *model = [[MessageListDicModel alloc] initWithDictionary:responseObject];
        
        successBlock(model);
    } fail:^(id error) {
        NSLog(@"%@",error);
    }];
}

+ (void)findAccountNotices:(NSMutableArray *)proxyIdList successBlock:(void(^)(AccountNoticeListDicModel *accountNoticeListDicModel))successBlock failBlock:(void(^)(void))failBlock {
    NSDictionary *paramDic = @{
        @"proxy_ids":proxyIdList
    };
    
    [NNBBasicRequest postJsonWithUrl:MessageBasicURLV2  parameters:paramDic CMD:@"ums.notice.find_account_notices" success:^(id responseObject) {
        NSLog(@"AnnouncementRequest->findAccountNotices->response:\n%@",responseObject);
        
        AccountNoticeListDicModel *model = [[AccountNoticeListDicModel alloc] initWithDictionary:responseObject];
        
        successBlock(model);
    } fail:^(id error) {
        NSLog(@"错误AnnouncementRequest->findAccountNotices->error:\n%@",error);
    }];
}

+ (void)findMeetingNoticeList:(NSString *)sessionId lastMessageId:(NSString *)lastMessageId page:(NSInteger)currentPage success:(void(^)(NSArray *dataArr,AnnounceListHeader *header))successBlock fail:(void(^)(NSString *))failBlock{
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:sessionId  forKey:@"session_id"];
    
    //    if(lastMessageId){
    //        [dic setValue:lastMessageId forKey:@"message_id"];
    //    }
    
    [dic setValue:@(currentPage) forKey:@"page"];
    [dic setValue:@{@"limit":@(20)} forKey:@"_meta"];
    
    [NNBBasicRequest postJsonWithUrl:MessageBasicURLV2  parameters:dic CMD:@"ums.message.find_session_messages" success:^(id responseObject) {
        SLog(@"会议AnnouncementRequest->findNoticeList->response:\n%@",responseObject);
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

+ (void)findNoticeList:(NSString *)proxyId lastMessageId:(NSString *)lastMessageId page:(NSInteger)currentPage success:(void(^)(NSArray *dataArr,AnnounceListHeader *header))successBlock fail:(void(^)(NSString *))failBlock{
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:proxyId forKey:@"proxy_id"];
    if(lastMessageId){
        [dic setValue:lastMessageId forKey:@"message_id"];
    }
    [dic setValue:@(currentPage) forKey:@"page"];
    [dic setValue:@{@"limit":@(20)} forKey:@"_meta"];
    
    [NNBBasicRequest postJsonWithUrl:MessageBasicURLV2  parameters:dic CMD:@"ums.notice.find" success:^(id responseObject) {
        NSLog(@"AnnouncementRequest->findNoticeList->response:\n%@",responseObject);
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

+ (void)publishAnnouncemenWithModel:(PublishModel *)model success:(void(^)(void))successBlock fail:(void(^)(NSString *))failBlock {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"proxy_id"] = model.proxyId;
    dic[@"title"] = model.title;
    NSMutableArray *tempArr = [NSMutableArray array];
    for (id tempModel in model.members) {
        if ([NSStringFromClass([tempModel class]) isEqualToString:@"ContactsGroup"]){
            ContactsGroup *GrouptempModel = tempModel;
            [tempArr addObject:GrouptempModel.vendor_target_id];
        } else {
            [tempArr addObject:[NSString stringWithFormat:@"%@", tempModel]];
            // 新建公告
        }
    }
    dic[@"members"] = tempArr;
    dic[@"content"] = model.content;
    NSLog(@"%@",model.media_ids);
    if (model.media_ids.count > 0) {
        dic[@"media_ids"] = model.media_ids;
    }
    NSLog(@"%@",dic);
    [NNBBasicRequest postJsonWithUrl:kUrl  parameters:dic CMD:@"message.notice.add" success:^(id responseObject) {
        NSLog(@"%@",responseObject);
        successBlock();
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
    [NNBBasicRequest postJsonWithUrl:MessageBasicURLV2  parameters:dic CMD:@"ums.notice.get" success:^(id responseObject) {
        NSLog(@"%@",responseObject);
        AnnouncementDetail *model = [AnnouncementDetail mj_objectWithKeyValues:responseObject];
        successBlock(model);
    } fail:^(id error) {
        failBlock(@"");
    }];
}

+ (void)findAddressBook:(void(^)(NSArray *dataArr))successBlock fail:(void(^)(NSString *))failBlock {
    
    NSDictionary *dic = @{};
    
    [NNBBasicRequest postJsonWithUrl:kUrl  parameters:dic CMD:@"message.address_book.find" success:^(id responseObject) {
        
        NSLog(@"%@",responseObject);
        
        NSMutableArray *dataArr = [NSMutableArray array];
        dataArr = [ContactsGroup mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        NSMutableArray *tempArr = [NSMutableArray array];
        for (ContactsGroup *group in dataArr) {
            if (group.children.count > 0) {
                for (ContactsChild *child in group.children) {
                    ContactsGroup *group = [[ContactsGroup alloc] init];
                    group.vendor_target_id = child.target_id;
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
}

+ (void)findWPPAdressBook:(NSString *)wppId successBlock:(void(^)(NSArray *dataArr))successBlock fail:(void(^)(NSString *))failBlock {
    
    NSDictionary *dic = @{
        @"wpp_id":wppId,
        @"_meta":@{
                @"limit":@(0)
        },
        @"type": @(10)
    };
    
    [NNBBasicRequest postJsonWithUrl:kUrl  parameters:dic CMD:@"message.address_book.find_wpp_address_book" success:^(id responseObject) {
        
        NSLog(@"%@",responseObject);
        
        NSMutableArray *dataArr = [NSMutableArray array];
        dataArr = [ContactsGroup mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        NSMutableArray *tempArr = [NSMutableArray array];
        for (ContactsGroup *group in dataArr) {
            if (group.children.count > 0) {
                for (ContactsChild *child in group.children) {
                    ContactsGroup *group = [[ContactsGroup alloc] init];
                    group.vendor_target_id = child.target_id;
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
    NSDictionary *dic = @{@"domain_type": @(dtype),@"file_key":key,@"storage_type":@(stype),@"file_type":fileType};
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


/**
 ums.session.find
 */
+ (void)registerSession:(void(^)(void))successBlock fail:(void(^)(void))failBlock {
    NSDictionary *dic = @{@"device_type":@(Device_type_app_ios),@"device_no":[JYCSimpleToolClass getUUID],@"device_model":@(Device_model_other), @"aliyun_device_token": kCache.deviceToken};
    NSLog(@"registerSession xinge_device_token%@",dic);
    [NNBBasicRequest postJsonWithUrl:MessageBasicURLV2  parameters:dic CMD:@"ums.session.add" success:^(id responseObject) {
        NSLog(@"AnnouncementRequest->registerSession->response \n %@",responseObject);
        successBlock();
    } fail:^(id error) {
        NSLog(@"%@",error);
        failBlock();
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
