//
//  RealmModule.h
//  BossCommonClass
//
//  Created by 高炀辉 on 2019/6/22.
//

#import <Foundation/Foundation.h>
#import "realmMessageModel.h"
#import "RealmRecordModel.h"
#import "BossOwnerAccount.h"

NS_ASSUME_NONNULL_BEGIN

@interface RealmModule : NSObject

+ (RealmModule *)sharedInstance;
/// 保存
- (void)saveMessagetoRealm:(RealmRecordModel *)messageModel Sectionid:(NSString *)sectionid;
/// 读取
- (NSArray *)getMessageListSectionID:(NSString *)sectionid;
/// 删除
- (void)deleteMessagetoRealm:(RealmRecordModel *)messageModel;
@end

NS_ASSUME_NONNULL_END
