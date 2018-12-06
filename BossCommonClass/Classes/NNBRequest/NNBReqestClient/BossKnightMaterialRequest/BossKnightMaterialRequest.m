//
//  BossKnightMaterialRequest.m
//  Pods-BossKnight
//
//  Created by 贾远潮 on 2018/5/23.
//

#import "BossKnightMaterialRequest.h"
#import "NNBBasicRequest.h"

@implementation BossKnightMaterialRequest

/**
 查看骑士分发单(物资管理列表)
 
 @param page 分页页码
 @param successBlock 物资管理单列表
 @param failBlock 服务器响应失败
 */
+ (void)knightMaterialRequestGetOrderListWithPage:(NSInteger)page success:(void(^)(NSArray <OrderModel *>*orderArray))successBlock fail:(void(^)(void))failBlock
{
    NSString *url = [NSString stringWithFormat:@"%@knight_material/gain_knight_material_flow",BossBasicURL];
    
    NSDictionary *paramDic = @{
                               @"account_id":kCurrentAccount.staff_id,
//                               @"page":@(page)
                               };
    [NNBBasicRequest postJsonWithUrl:url parameters:paramDic CMD:nil success:^(id responseObject) {
        if (!successBlock) {
            return;
        }
        NSMutableArray *arrayM = [NSMutableArray array];
        for (NSDictionary *dic in responseObject[@"order_list"]) {
            OrderModel *model = [[OrderModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [arrayM addObject:model];
        }
        successBlock([arrayM copy]);
    } fail:^(id error) {
        if (!failBlock) {
            return;
        }
        failBlock();
    }];
}

/**
 查看骑士分发单详情(物资管理详情)
 
 @param orderId 订单id
 @param successBlock 成功返回物资管理详情
 @param failBlock 服务器响应失败
 */
+ (void)knightMaterialRequestGetOrderDetailWithOrderId:(NSString *)orderId success:(void(^)(OrderModel *orderModel))successBlock fail:(void(^)(void))failBlock;
{
    NSString *url = [NSString stringWithFormat:@"%@knight_material/gain_knight_material_flow_order",BossBasicURL];
    
    NSDictionary *paramDic = @{
                               @"account_id":kCurrentAccount.staff_id,
                               @"order_id":orderId
                               };
    [NNBBasicRequest postJsonWithUrl:url parameters:paramDic CMD:nil success:^(id responseObject) {
        if (!successBlock) {
            return;
        }
        OrderModel *model = [[OrderModel alloc] init];
        [model setValuesForKeysWithDictionary:responseObject];
        successBlock(model);
    } fail:^(id error) {
        if (!failBlock) {
            return;
        }
        failBlock();
    }];
}
@end