//
//  RealmModule.m
//  BossCommonClass
//
//  Created by 高炀辉 on 2019/6/22.
//

#import "RealmModule.h"
#import "MQTTDefine.h"
#import "QLifeAES256.h"
#import "MQTTClientModel.h"
#import "BossCache.h"


//RealmModule.m
@implementation RealmModule
static RealmModule * sharedSingleton = nil;

+ (RealmModule *) sharedInstance {
    if (sharedSingleton == nil) {
        sharedSingleton = [[RealmModule alloc] init];
    }
    return sharedSingleton;
}
// 删除
- (void)deleteMessagetoRealm: (RealmRecordModel *)messageModel{
    RLMRealm *realm = [RLMRealm defaultRealm];
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"userid = %@ AND sectionid = %@ AND idField = %@",
                         kCurrentBossOwnerAccount.accountModel.accountId,messageModel.sectionid,messageModel.idField];
    
    RLMResults<RealmRecordModel *> *puppies = [RealmRecordModel objectsWithPredicate:pred];
    if (puppies.count > 0) {
        RLMObject *object = puppies.firstObject;
        // 删除
        [realm transactionWithBlock:^{
            [realm deleteObject:object];
        }];
    }
    
}
// 修改 更新 错误状态
- (void)updateMessagetoRealmErrorStatus:(RealmRecordModel *)messageModel errorStatus:(BOOL )iserror{
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm transactionWithBlock:^{
        messageModel.sendstate = 0;
        messageModel.iserror = iserror;
    }];
}
// 修改消息发送状态
- (void)updateMessagetoRealmSendStatus:(RealmRecordModel *)messageModel errorStatus:(BOOL )iserror Success:(resetSendmessageBlock_success)success{
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    messageModel.sendstate = 100;
    messageModel.iserror = iserror;
    [realm commitWriteTransaction];
    if (success){
        success();
    }
}
- (RealmRecordModel *)getLastRealmRecordModelFormRealm:(NSString *)sectionid{
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"userid = %@ AND sectionid = %@",
                         kCurrentBossOwnerAccount.accountModel.accountId,sectionid];
    
    RLMResults<RealmRecordModel *> *puppies = [RealmRecordModel objectsWithPredicate:pred];
    RLMResults<RealmRecordModel *> *puppies2 = [puppies sortedResultsUsingKeyPath:@"idField" ascending:true];
    if (puppies2.count > 0) {
        RLMObject *object = puppies2.lastObject;
        RealmRecordModel *model = [[RealmRecordModel alloc] initWithValue:object];
        return model;
    }
    return nil;
}
- (void)saveMessagetoRealm:(RealmRecordModel *)messageModel Sectionid:(NSString *)sectionid{
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"sectionid = %@ AND idField = %@",
                         sectionid, messageModel.idField];
    RLMResults<RealmRecordModel *> *puppies = [RealmRecordModel objectsWithPredicate:pred];
    if (puppies.count <= 0) {
        RLMRealm *realm = [RLMRealm defaultRealm];
        // 保存
        [realm transactionWithBlock:^{
            [realm addObject:messageModel];
        }];
    }
    // 标记
    NSDictionary *dic = @{@"event_name":@"msg_ack",@"payload":@{@"account_id":[BossCache defaultCache].umsAccessTokenModel.accountId, @"message_ids": @[messageModel.idField]}};
    NSData *data = [QLifeAES256 dataWithEncodeObj:dic password:mqttSecretKey];
    [[MQTTClientModel sharedInstance] sendDataToTopic:@"ums/" data:data];

}
// 获取数据
- (NSArray *)getMessageListSectionID:(NSString *)sectionid{
    NSMutableArray *messageList = [[NSMutableArray alloc] init];
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"userid = %@ AND sectionid = %@",
                         kCurrentBossOwnerAccount.accountModel.accountId,sectionid];
    RLMResults<RealmRecordModel *> *puppies = [RealmRecordModel objectsWithPredicate:pred];
    RLMResults<RealmRecordModel *> *puppies2 = [puppies sortedResultsUsingKeyPath:@"idField" ascending:true];
    if (puppies2.count > 0) {
        for (RLMObject *object in puppies2) {
            RealmRecordModel *model = [[RealmRecordModel alloc] initWithValue:object];
            [messageList addObject:model];
        }
    }
    return messageList;
}
@end
