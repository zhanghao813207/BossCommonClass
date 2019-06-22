//
//  RealmModule.m
//  BossCommonClass
//
//  Created by 高炀辉 on 2019/6/22.
//

#import "RealmModule.h"

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
            [AllMessageModel.realmRecordModel addObject:messageModel];
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
}
// 获取数据
- (NSArray *)getMessageListSectionID:(NSString *)sectionid{
    NSMutableArray *messageList = [[NSMutableArray alloc] init];
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"userid = %@ AND sectionid = %@",
                         kCurrentBossOwnerAccount.accountModel.accountId,sectionid];
    RLMResults<realmMessageModel *> *puppies = [realmMessageModel objectsWithPredicate:pred];
    if (puppies.count > 0) {
        realmMessageModel *puppies2 = [puppies firstObject];
        for (RLMObject *object in puppies2.realmRecordModel) {
            RealmRecordModel *model = [[RealmRecordModel alloc] initWithValue:object];
            [messageList addObject:model];
        }
    }
    return messageList;
}
@end
