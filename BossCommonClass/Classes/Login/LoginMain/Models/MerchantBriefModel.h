//
//  MerchantBriefModel.h
//  AFNetworking
//
//  Created by 张浩 on 2019/2/18.
//

#import <Foundation/Foundation.h>
#import "BossBasicDefine.h"

NS_ASSUME_NONNULL_BEGIN

/**
 商户信息摘要
 */
@interface MerchantBriefModel : NSObject

/**
 商户ID
 */
@property (nonatomic, strong) NSString *_id;

/**
 商户号
 */
@property (nonatomic, strong) NSString *merchant_code;

/**
 商户名称
 */
@property (nonatomic, strong) NSString *name;

/**
 api网关url
 */
@property (nonatomic, strong) NSString *api_gateway;

/**
 商户状态
 */
@property (nonatomic, assign) MerchantState state;

/**
 创建时间
 */
@property (nonatomic, strong) NSString *created_at;

/**
 模型转字典
 
 @return 字典
 */
- (NSDictionary *)decodeToDic;

@end

NS_ASSUME_NONNULL_END
