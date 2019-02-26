//
//  SaasRequest.h
//  AFNetworking
//
//  Created by 张浩 on 2019/2/18.
//

#import <Foundation/Foundation.h>
#import "BossBasicDefine.h"
#import "SaasModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SaasRequest : NSObject

/**
 获取Saas平台信息

 @param successBlock 成功回调
 @param failBlock 失败回调
 */
+ (void)getSaasResult:(NSString *)merchantCode success:(void(^)(SaasModel *saasModel))successBlock fail:(void(^)(void))failBlock;

@end

NS_ASSUME_NONNULL_END
