//
//  BossKnightMaterialRequest.h
//  Pods-BossKnight
//
//  Created by 贾远潮 on 2018/5/23.
//

#import <Foundation/Foundation.h>
#import "OrderModel.h"

@interface BossKnightMaterialRequest : NSObject

/**
 查看骑士分发单(物资管理列表)

 @param page 分页页码
 @param successBlock 物资管理单列表
 @param failBlock 服务器响应失败
 */
+ (void)knightMaterialRequestGetOrderListWithPage:(NSInteger)page success:(void(^)(NSArray <OrderModel *>*orderArray))successBlock fail:(void(^)(void))failBlock;


/**
 查看骑士分发单详情(物资管理详情)

 @param orderId 订单id
 @param successBlock 成功返回物资管理详情
 @param failBlock 服务器响应失败
 */
+ (void)knightMaterialRequestGetOrderDetailWithOrderId:(NSString *)orderId success:(void(^)(OrderModel *orderModel))successBlock fail:(void(^)(void))failBlock;

@end
