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
- (void)saveMessagetoRealm:(RealmRecordModel *)messageModel Sectionid:(NSString *)sectionid{
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"userid = %@ AND idField = %@",
                         kCurrentBossOwnerAccount.accountModel.accountId,messageModel.idField];
    RLMResults<RealmRecordModel *> *puppies = [RealmRecordModel objectsWithPredicate:pred];
    
    RLMRealm *realm = [RLMRealm defaultRealm];
    
    if (puppies.count > 0) {
        return;
    }
    [realm transactionWithBlock:^{
        [realm addObject:messageModel];
    }];
    
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