//
//  SaasModel.h
//  AFNetworking
//
//  Created by 张浩 on 2019/2/18.
//

#import <Foundation/Foundation.h>
#import "MerchantBriefModel.h"
#import "BossManagerAccount.h"
#import "BossKnightAccount.h"

NS_ASSUME_NONNULL_BEGIN

/**
 SaaS平台Model
 */
@interface SaasModel : NSObject

/**
 ID
 */
@property (nonatomic, strong) NSString *_id;

/**
 access key
 */
@property (nonatomic, strong) NSString *access_key;

/**
 secret key
 */
@property (nonatomic, strong) NSString *secret_key;

/**
 商户Id
 */
@property (nonatomic, strong) NSString *merchant_id;

/**
 商户信息
 */
@property (nonatomic, strong) MerchantBriefModel *merchant_info;

#pragma mark --附加属性

@property (nonatomic, readonly) NSString *url;

/**
 该商户已登录帐号
 */
@property (nonatomic, strong) NSMutableArray<NSDictionary *> *accountList;

/**
 模型转字典
 
 @return 字典
 */
- (NSDictionary *)decodeToDic;

@end

NS_ASSUME_NONNULL_END
