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
/// 更新
//- (void)updateMessagetoRealm:(RealmRecordModel *)messageModel;
/// 获取最后一个消息对象
- (RealmRecordModel *)getLastRealmRecordModelFormRealm:(NSString *)sectionid;
/// 更新错误状态
- (void)updateMessagetoRealmErrorStatus:(RealmRecordModel *)messageModel errorStatus:(BOOL )iserror;
@end

NS_ASSUME_NONNULL_END
