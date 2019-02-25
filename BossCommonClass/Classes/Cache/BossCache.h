//
//  BossCache.h
//  AFNetworking
//
//  Created by 张浩 on 2019/2/21.
//

#import <Foundation/Foundation.h>
@class SaasModel;
@class BossManagerAccount;
@class BossKnightAccount;

NS_ASSUME_NONNULL_BEGIN

@interface BossCache : NSObject
+ (__kindof BossCache *)defaultCache;

/**
 校验是否启用本地配置
 - URL
 - ACCESS_KEY
 - SECRET_KEY
 */
@property (nonatomic, readonly) BOOL localConfig;

@property (nonatomic, readonly) NSString *url;

@property (nonatomic, readonly) NSString *accessKey;

@property (nonatomic, readonly) NSString *secretKey;

@property (nonatomic, strong, nullable) SaasModel *currentSaasModel;

@property (nonatomic, strong, nullable) BossManagerAccount *currentManagerAccount;

@property (nonatomic, strong, nullable) BossKnightAccount *currentKnightAccount;

@property (nonatomic, strong) NSMutableArray<NSDictionary *> *saasAccountList;

/**
 检查是否已登录
 - YES:已登录
 - NO:未登录
 */
@property (nonatomic, assign, readonly) BOOL checkLogin;

- (void)addAccount:(NSDictionary *)accountDic;

- (void)removeAccount:(NSUInteger)saasIndex accountIndex:(NSUInteger)accountIndex;

@end

NS_ASSUME_NONNULL_END
