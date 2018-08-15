//
//  BossOaExamineRequest.m
//  BossCommonClass
//
//  Created by 贾远潮 on 2018/8/8.
//

#import "BossOaExamineRequest.h"
#import "NNBBasicRequest.h"
@implementation BossOaExamineRequest

/**
 获取审批列表
 
 @param type 移动端费用状态
 @param successBlock 返回审批列表
 @param failBlock 服务器响应失败
 */
+ (void)OaExamineRequestGetExamineListWithType:(MOBILE_EXAMINE_TYPES)type page:(NSInteger)page successBlock:(void(^)(NSArray <ExamineFlowModel *>*examineFlowList))successBlock fail:(void(^)(id error))failBlock
{
    NSString *url = [NSString stringWithFormat:@"%@oa_examine/mobile_examine_list",BossBasicURL];
    NSDictionary *paramDic = @{
                               @"m_type":@(type),
                               @"page":@(page),
                               @"limit":@"30",
                               };
    [NNBBasicRequest getJsonWithUrl:url parameters:paramDic CMD:nil success:^(id responseObject) {
        DLog(@"%@", responseObject);
        if (!successBlock) {
            return;
        }
        NSMutableArray *array = [NSMutableArray array];
        for (NSDictionary* dataDic in responseObject[@"data"]) {
            ExamineFlowModel *model = [[ExamineFlowModel alloc] init];
            [model setValuesForKeysWithDictionary:dataDic];
            [array addObject:model];
        }
        successBlock([array copy]);
    } fail:^(id error) {
        if(failBlock){
            failBlock(error);
        }
    }];
}

/**
 费用汇总单详情
 
 @param examineId 汇总单ID
 @param successBlock 返回审批单详情
 @param failBlock 服务器响应失败
 */
+ (void)OaExamineRequestGetExamineDetailWithExamineId:(NSString *)examineId successBlock:(void(^)(ExamineFlowModel *examineFlowModel))successBlock fail:(void(^)(id error))failBlock
{
    NSString *url = [NSString stringWithFormat:@"%@oa_examine/mobile_examine_detail",BossBasicURL];
    NSDictionary *paramDic = @{
                               @"examine_id":examineId,
                               };
    [NNBBasicRequest getJsonWithUrl:url parameters:paramDic CMD:nil success:^(id responseObject) {
        DLog(@"%@", responseObject);
        if (!successBlock) {
            return;
        }
        ExamineFlowModel *model = [[ExamineFlowModel alloc] init];
        [model setValuesForKeysWithDictionary:responseObject];
        successBlock(model);
        
    } fail:^(id error) {
        if(failBlock){
            failBlock(error);
        }
    }];
}

/**
 查看费用申请单详情
 
 @param orderId 申请单id
 @param successBlock 成功的回调
 @param failBlock 服务器响应失败
 */
+ (void)OaApplyOrderDetailWithOrderId:(NSString *)orderId successBlock:(void(^)(ApplyOrderModel *applyOrder))successBlock fail:(void(^)(id error))failBlock
{
    NSString *url = [NSString stringWithFormat:@"%@oa_apply_order/find_apply_order",BossBasicURL];
    NSDictionary *paramDic = @{
                               @"order_id":orderId,
                               };
    [NNBBasicRequest postJsonWithUrl:url parameters:paramDic CMD:nil success:^(id responseObject) {
        DLog(@"%@", responseObject);
        if (!successBlock) {
            return;
        }
        ApplyOrderModel *model = [[ApplyOrderModel alloc] init];
        if ([responseObject[@"result"] count] > 0) {
            for (NSDictionary *dic in responseObject[@"result"]) {
                if ([orderId isEqualToString:dic[@"_id"]]) {
                    [model setValuesForKeysWithDictionary:dic];
                    break;
                }
            }
        }
        successBlock(model);
    } fail:^(id error) {
        if(failBlock){
            failBlock(error);
        }
    }];
}

/**
 审批操作
 
 @param examineId 审批单id
 @param state 审批动作
 @param des 审批意见
 @param successBlock 操作是否成功
 @param failBlock 服务器响应失败
 */
+ (void)OaExamineRequestWithExamineId:(NSString *)examineId examineState:(OA_EXAMINE_NODE_STATE)state des:(NSString *)des success:(void(^)(BOOL ok))successBlock fail:(void(^)(id error))failBlock;
{
    NSString *url = [NSString stringWithFormat:@"%@oa_examine/examine",BossBasicURL];
    NSDictionary *paramDic = @{
                               @"examine_id":examineId,
                               @"examine_state":@(state),
                               @"desc":des,

                               };
    [NNBBasicRequest postJsonWithUrl:url parameters:paramDic CMD:nil success:^(id responseObject) {
        DLog(@"%@", responseObject);
        if (!successBlock) {
            return;
        }
        successBlock([responseObject[@"ok"] boolValue]);
    } fail:^(id error) {
        if(failBlock){
            failBlock(error);
        }
    }];
}

/**
 催办操作
 
 @param examineId 汇总单ID
 @param successBlock 成功的回调
 @param failBlock 服务器响应失败
 */
+ (void)OaExamineRequestUrgedWithExamineId:(NSString *)examineId success:(void(^)(BOOL ok))successBlock fail:(void(^)(id error))failBlock
{
    NSString *url = [NSString stringWithFormat:@"%@oa_examine/mobile_examine_alert",BossBasicURL];
    NSDictionary *paramDic = @{
                               @"examine_id":examineId,
                               };
    [NNBBasicRequest postJsonWithUrl:url parameters:paramDic CMD:nil success:^(id responseObject) {
        DLog(@"%@", responseObject);
        if (!successBlock) {
            return;
        }
        successBlock([responseObject[@"ok"] boolValue]);
    } fail:^(id error) {
        if(failBlock){
            failBlock(error);
        }
    }];
}
@end
