//
//  BossCache.h
//  AFNetworking
//
//  Created by 张浩 on 2019/2/21.
//

#import <Foundation/Foundation.h>
#import "UmsAccessTokenModel.h"
@class SaasModel;
@class BossManagerAccount;
@class BossKnightAccount;
@class BossOwnerAccount;
// @class UmsAccessTokenModel;

NS_ASSUME_NONNULL_BEGIN

@interface BossCache : NSObject
+ (__kindof BossCache *)defaultCache;

/**
 校验是否启用本地配置
 - URL
 - ACCESS_KEY
 - SECRET_KEY
 */
@property (nonatomic, assign) BOOL localConfig;

@property (nonatomic, strong, nullable) NSDictionary *netConfig;

@property (nonatomic, readonly) NSString *url;

@property (nonatomic, readonly) NSString *accessKey;

@property (nonatomic, readonly) NSString *secretKey;

@property (nonatomic, readonly) NSString *accessToken;

@property (nonatomic, strong, nullable) SaasModel *currentSaasModel;

@property (nonatomic, strong, nullable) BossManagerAccount *currentManagerAccount;

@property (nonatomic, strong, nullable) BossKnightAccount *currentKnightAccount;

@property (nonatomic, strong, nullable) BossOwnerAccount *currentBossOwnerAccount;

@property (nonatomic, strong) NSMutableArray<NSDictionary *> *saasAccountList;

/**
 检查是否已登录 
 - YES:已登录
 - NO:未登录
 */
@property (nonatomic, assign, readonly) BOOL checkLogin;

/**
 登录页的输入商户号是否显示左侧按钮
 - YES:显示
 - NO:不显示
 */
@property (nonatomic, assign) BOOL showBackMerchantCode;

/**
 标记app启动后，是否第一次显示健康证到期提醒框
 */
@property (nonatomic, assign) BOOL isFirstHealCertificate;

/**
 最后一次登录手机号
 */
@property (nonatomic, strong) NSString *lastLoginPhone;

/**
 是否开启消息系统
 */
@property (nonatomic, assign) BOOL checkStartUMS;

@property (nonatomic, strong, nullable) UmsAccessTokenModel *umsAccessTokenModel;

@property (nonatomic, strong) NSString *umsAccessToken;

@property (nonatomic, strong) NSString *deviceToken;

@property (nonatomic, strong) NSString *umsAccessKey;

@property (nonatomic, strong) NSString *umsSecretKey;

- (void)initNetConfig:(nullable SaasModel *)saasModel;

- (NSString *)getUrlByApiVersion:(NSString *)apiVersion;

- (void)addAccount:(NSDictionary *)accountDic;

/// 获取登录失效列表
- (NSMutableArray<NSString *> *)getlogoutAccountList;

/// 添加登录失效的用户
- (void)addLoginOutAccount:(NSString *)accountId;
/// 移除登录失效的用户
- (void)removeLoginOutAccount:(NSString *)accountId;
/// 根据下标删除账号
- (void)removeAccount:(NSUInteger)saasIndex accountIndex:(NSUInteger)accountIndex;
/// 根据账号id删除账号
- (void)removeAccountWithAccountId:(NSString *)accountId;

- (void)loginout;

@end

NS_ASSUME_NONNULL_END
