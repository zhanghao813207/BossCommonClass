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
@property (nonatomic, assign) BOOL localConfig;

@property (nonatomic, readonly) NSString *url;

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

/**
 登录页的输入商户号是否显示左侧按钮
 - YES:显示
 - NO:不显示
 */
@property (nonatomic, assign) BOOL showBackMerchantCode;

/**
 最后一次登录手机号
 */
@property (nonatomic, strong) NSString *lastLoginPhone;

- (void)addAccount:(NSDictionary *)accountDic;

- (void)removeAccount:(NSUInteger)saasIndex accountIndex:(NSUInteger)accountIndex;

- (NSMutableArray<NSString *> *)getlogoutPhoneList;

- (void)addPhone:(NSString *)phone;

- (void)removePhone:(NSString *)phone;

@end

NS_ASSUME_NONNULL_END