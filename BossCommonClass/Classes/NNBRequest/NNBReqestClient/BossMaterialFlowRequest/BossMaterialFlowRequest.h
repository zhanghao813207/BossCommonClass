//
//  BossMaterialFlowRequest.h
//  Pods-BossKnight
//
//  Created by 贾远潮 on 2018/5/23.
//

#import <Foundation/Foundation.h>
#import "BossBasicDefine.h"
@interface BossMaterialFlowRequest : NSObject

/**
 物资退货

 @param orderId 分发单号
 @param materialId 物资品目ID
 @param successBlock 申请退货是否成功
 @param failBlock 服务器响应失败
 */
+ (void)materialFlowRequestRefundWithOrderId:(NSString *)orderId materialItemId:(NSString *)materialId success:(void (^)(BOOL ok))successBlock fail:(void(^)(void))failBlock;

/**
 确认收货(物资管理列表／详情)

 @param orderId 采购、报废单号
 @param flowState 物资流状态
 @param successBlock 成功回调
 @param failBlock 失败回调
 */
+ (void)materialFlowRequestConfirmdWithOrderId:(NSString *)orderId flowState:(FlowStates)flowState success:(void (^)(BOOL ok))successBlock fail:(void(^)(void))failBlock;



@end
