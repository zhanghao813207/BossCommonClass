//
//  BossMaterialFlowRequest.m
//  Pods-BossKnight
//
//  Created by 贾远潮 on 2018/5/23.
//

#import "BossMaterialFlowRequest.h"
#import "BossKnightAccount.h"
#import "SaasModel.h"
#import "NNBBasicRequest.h"
@implementation BossMaterialFlowRequest

/**
 物资退货
 
 @param orderId 分发单号
 @param materialId 物资品目ID
 @param successBlock 申请退货是否成功
 @param failBlock 服务器响应失败
 */
+ (void)materialFlowRequestRefundWithOrderId:(NSString *)orderId materialItemId:(NSString *)materialId success:(void (^)(BOOL ok))successBlock fail:(void(^)(void))failBlock
{
    NSString *url = [NSString stringWithFormat:@"%@material_flow/material_refund",BossBasicURL];
    
    NSDictionary *paramDic = @{
                               @"account_id":kCurrentBossKnightAccount.accountModel._id,
                               @"order_id":orderId,
                               @"material_item_id":materialId,
                               };
    [NNBBasicRequest postJsonWithUrl:url parameters:paramDic CMD:nil success:^(id responseObject) {
        if (!successBlock) {
            return;
        }
        successBlock([responseObject[@"ok"] boolValue]);
    } fail:^(id error) {
        if (!failBlock) {
            return;
        }
        failBlock();
    }];
}

/**
 确认收货(物资管理列表／详情)
 
 @param orderId 采购、报废单号
 @param flowState 物资流状态
 @param successBlock 成功回调
 @param failBlock 失败回调
 */
+ (void)materialFlowRequestConfirmdWithOrderId:(NSString *)orderId flowState:(FlowStates)flowState success:(void (^)(BOOL ok))successBlock fail:(void(^)(void))failBlock
{
    NSString *url = [NSString stringWithFormat:@"%@material_flow/material_flow_audit",BossBasicURL];
    
    NSDictionary *paramDic = @{
                               @"account_id":kCurrentBossKnightAccount.accountModel._id,
                               @"order_id":orderId,
                               @"flow_state":@(flowState)
                               };
    [NNBBasicRequest postJsonWithUrl:url parameters:paramDic CMD:nil success:^(id responseObject) {
        if (!successBlock) {
            return;
        }
        successBlock([responseObject[@"ok"] boolValue]);
    } fail:^(id error) {
        if (!failBlock) {
            return;
        }
        failBlock();
    }];
}
@end
