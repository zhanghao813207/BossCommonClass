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
    
    RLMRealm *realm = [RLMRealm defaultRealm];
    // 查询 sectionid 和 userid
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"userid = %@ AND sectionid = %@",
                         kCurrentBossOwnerAccount.accountModel.accountId,sectionid];
    // 查询本地数据库
    RLMResults<realmMessageModel *> *puppies = [realmMessageModel objectsWithPredicate:pred];
    // 有过回话
    if (puppies.count > 0) {
        // 根据用户ID 查找
        realmMessageModel *AllMessageModel = [puppies firstObject];
        // 存到本地
        [realm transactionWithBlock:^{
            [AllMessageModel.realmRecordModels addObject:messageModel];
        }];
    } else {
        // 第一次缓存 没有会话
        if (sectionid && kCurrentBossOwnerAccount.accountModel.accountId) {
            NSDictionary *basedic = @{
                                      @"userid": kCurrentBossOwnerAccount.accountModel.accountId,
                                      @"realmRecordModel" : @[messageModel.toDictionary],
                                      @"sectionid": sectionid
                                      };
            
            realmMessageModel *baseModel = [[realmMessageModel alloc] initWithDictionary:basedic];
            
            [realm transactionWithBlock:^{
                [realm addObject:baseModel];
            }];
        }
    }
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
