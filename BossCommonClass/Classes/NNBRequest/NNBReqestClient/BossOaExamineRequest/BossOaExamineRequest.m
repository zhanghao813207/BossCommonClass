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
+ (void)OaExamineRequestGetExamineListWithType:(MOBILE_EXAMINE_TYPES)type page:(NSInteger)page successBlock:(void(^)(NSArray <ExamineOrderModel *>*examineFlowList))successBlock fail:(void(^)(id error))failBlock
{
    NSString *url = [NSString stringWithFormat:@"%@oa_application_order/find",BossBasicURL];
    NSMutableDictionary *paramDic = [NSMutableDictionary dictionaryWithDictionary:@{
                                                                                    @"_meta":@{
                                                                                            @"page":@(page),
                                                                                            @"limit":@(30),
                                                                                            @"sort":@{
                                                                                                    @"submit_at":@(-1),
                                                                                                    }
                                                                                            }
                                                                                    }];
    NSArray *stateArray = @[@(OA_EXAMINE_STATE_UNDERWAY)];
    switch (type) {
        case MOBILE_WAIT_EXAMINE:
        {
            [paramDic setObject:@{
                                  @"page":@(page),
                                  @"limit":@(30),
                                  @"sort":@{
                                          @"urge_state":@(1),
                                          @"submit_at":@(-1),
                                          }
                                  } forKey:@"_meta"];
            [paramDic setObject:@[kCurrentBossAccount.account_id] forKey:@"current_pending_accounts"];
            [paramDic setObject:stateArray forKey:@"state"];
        }
            break;
        case MOBILE_PUT_EXAMINE_ALL:
        {
            stateArray = @[@(OA_EXAMINE_STATE_DONE),@(OA_EXAMINE_STATE_SHUTDOWN),@(OA_EXAMINE_STATE_UNDERWAY)];
            [paramDic setObject:kCurrentBossAccount.account_id forKey:@"apply_account_id"];
            [paramDic setObject:stateArray forKey:@"state"];
        }
            break;
        case MOBILE_PUT_EXAMINE_PRESENT:
        {
            stateArray = @[@(OA_EXAMINE_STATE_UNDERWAY)];
            [paramDic setObject:kCurrentBossAccount.account_id forKey:@"apply_account_id"];
            [paramDic setObject:stateArray forKey:@"state"];
        }
            break;
        case MOBILE_PUT_EXAMINE_SUCCEED:
        {
            stateArray = @[@(OA_EXAMINE_STATE_DONE)];
            [paramDic setObject:kCurrentBossAccount.account_id forKey:@"apply_account_id"];
            [paramDic setObject:stateArray forKey:@"state"];
        }
            break;
        case MOBILE_PUT_EXAMINE_FAIL:
        {
            stateArray = @[@(OA_EXAMINE_STATE_SHUTDOWN)];
            [paramDic setObject:kCurrentBossAccount.account_id forKey:@"apply_account_id"];
            [paramDic setObject:stateArray forKey:@"state"];
        }
            break;
        case MOBILE_PASS_EXAMINE_ALL:
        {
            stateArray = @[@(OA_EXAMINE_STATE_UNDERWAY),@(OA_EXAMINE_STATE_DONE),@(OA_EXAMINE_STATE_SHUTDOWN)];
            [paramDic setObject:@[kCurrentBossAccount.account_id] forKey:@"flow_accounts"];
            [paramDic setObject:stateArray forKey:@"state"];
        }
            break;
        case MOBILE_PASS_EXAMINE_PRESENT:
        {
            stateArray = @[@(OA_EXAMINE_STATE_UNDERWAY)];
            [paramDic setObject:@[kCurrentBossAccount.account_id] forKey:@"flow_accounts"];
            [paramDic setObject:stateArray forKey:@"state"];
        }
            break;
        case MOBILE_PASS_EXAMINE_SUCCEED:
        {
            stateArray = @[@(OA_EXAMINE_STATE_DONE)];
            [paramDic setObject:@[kCurrentBossAccount.account_id] forKey:@"flow_accounts"];
            [paramDic setObject:stateArray forKey:@"state"];
        }
            break;
        case MOBILE_PASS_EXAMINE_FAIL:
        {
            stateArray = @[@(OA_EXAMINE_STATE_SHUTDOWN)];
            [paramDic setObject:@[kCurrentBossAccount.account_id] forKey:@"flow_accounts"];
            [paramDic setObject:stateArray forKey:@"state"];
        }
            break;
        default:
            break;
    }
    
    [NNBBasicRequest postJsonWithUrl:url parameters:paramDic CMD:nil success:^(id responseObject) {
//        DLog(@"%@", responseObject);
        if (!successBlock) {
            return;
        }
        NSMutableArray *array = [NSMutableArray array];
        for (NSDictionary* dataDic in responseObject[@"data"]) {
            ExamineOrderModel *model = [[ExamineOrderModel alloc] init];
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
 @param showError 是否展示错误
 @param successBlock 返回审批单详情
 @param failBlock 服务器响应失败
 */
+ (void)OaExamineRequestGetExamineDetailWithExamineId:(NSString *)examineId showError:(BOOL)showError successBlock:(void(^)(ExamineOrderModel *examineFlowModel))successBlock fail:(void(^)(id error))failBlock
{
    NSString *url = [NSString stringWithFormat:@"%@oa_application_order/get",BossBasicURL];
    NSDictionary *paramDic = @{
                               @"id":examineId,
                               };
    NSLog(@"paramDic = %@",paramDic);
    if (showError) {
        [NNBBasicRequest postJsonWithUrl:url parameters:paramDic CMD:nil success:^(id responseObject) {
            DLog(@"%@", responseObject);
            if (!successBlock) {
                return;
            }
            ExamineOrderModel *model = [[ExamineOrderModel alloc] init];
            [model setValuesForKeysWithDictionary:responseObject];
            successBlock(model);
            
        } fail:^(id error) {
            if(failBlock){
                failBlock(error);
            }
        }];
    } else {
        [NNBBasicRequest postJsonNativeWithUrl:url parameters:paramDic cmd:nil success:^(id responseObject) {
            DLog(@"%@", responseObject);
            if (!successBlock) {
                return;
            }
            ExamineOrderModel *model = [[ExamineOrderModel alloc] init];
            [model setValuesForKeysWithDictionary:responseObject];
            successBlock(model);

        } fail:^(id error) {
            if(failBlock){
                failBlock(error);
            }
        }];
    }
}

/**
 费用单列表
 
 @param page 页码
 @param successBlock 返回费用单列表
 @param failBlock 服务器响应失败
 */
+ (void)OaExamineRequestGetCostOrderListWithPage:(NSInteger)page successBlock:(void(^)(NSArray <CostOrderModel *>*costOrderList))successBlock fail:(void(^)(id error))failBlock
{
    NSString *url = [NSString stringWithFormat:@"%@oa_cost_order/find",BossBasicURL];
    NSDictionary *paramDic = @{
                               @"_meta":@{
                                       @"page":@(page),
                                       @"limit":@(30),
                                       }
                               };
    [NNBBasicRequest postJsonWithUrl:url parameters:paramDic CMD:nil success:^(id responseObject) {
        DLog(@"%@", responseObject);
        if (!successBlock) {
            return;
        }
        NSMutableArray *array = [NSMutableArray array];
        for (NSDictionary* dataDic in responseObject[@"data"]) {
            CostOrderModel *model = [[CostOrderModel alloc] init];
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
 查看费用申请单详情
 
 @param orderId 申请单id
 @param successBlock 成功的回调
 @param failBlock 服务器响应失败
 */
+ (void)OaApplyOrderDetailWithOrderId:(NSString *)orderId successBlock:(void(^)(CostOrderModel *applyOrder))successBlock fail:(void(^)(id error))failBlock
{
    NSString *url = [NSString stringWithFormat:@"%@oa_cost_order/get",BossBasicURL];
    NSDictionary *paramDic = @{
                               @"id":orderId,
                               };
    [NNBBasicRequest postJsonWithUrl:url parameters:paramDic CMD:nil success:^(id responseObject) {
        DLog(@"%@", responseObject);
        if (!successBlock) {
            return;
        }
        CostOrderModel *model = [[CostOrderModel alloc] init];
        [model setValuesForKeysWithDictionary:responseObject];
        successBlock(model);

    } fail:^(id error) {
        if(failBlock){
            failBlock(error);
        }
    }];
}

/**
 审核同意
 
 @param examineOrderId 审批单ID
 @param recordId 审批流转记录ID
 @param note 原因
 @param successBlock 服务器响应返回
 @param failBlock 服务器响应失败
 */
+ (void)OaExamineRequestAgreeWithExamineOrderId:(NSString *)examineOrderId examineRecordId:(NSString *)recordId note:(NSString *)note success:(void(^)(BOOL ok))successBlock fail:(void(^)(id error))failBlock
{
    NSString *url = [NSString stringWithFormat:@"%@oa_application_order/approve",BossBasicURL];
    NSMutableDictionary *paramDic = [NSMutableDictionary dictionaryWithDictionary:@{
                                                                                    @"order_id":examineOrderId,
                                                                                    @"order_record_id":recordId,
                                                                                    }];
    if (![JYCSimpleToolClass stringIsEmpty:note]) {
        [paramDic setObject:note forKey:@"note"];
    }
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
 审核驳回
 
 @param examineOrderId 审批单ID
 @param recordId 审批流转记录ID
 @param rejectNodeId 被驳回的节点id
 @param note 原因
 @param successBlock 服务器响应返回
 @param failBlock 服务器响应失败
 */
+ (void)OaExamineRequestRejectWithExamineOrderId:(NSString *)examineOrderId examineRecordId:(NSString *)recordId rejectNodeId:(NSString *)rejectNodeId note:(NSString *)note success:(void(^)(BOOL ok))successBlock fail:(void(^)(id error))failBlock
{
    NSString *url = [NSString stringWithFormat:@"%@oa_application_order/reject",BossBasicURL];
    NSMutableDictionary *paramDic = [NSMutableDictionary dictionaryWithDictionary:@{
                               @"order_id":examineOrderId,
                               @"order_record_id":recordId,
                               }];
    if (![JYCSimpleToolClass stringIsEmpty:note]) {
        [paramDic setObject:note forKey:@"note"];
    }
    if (![JYCSimpleToolClass stringIsEmpty:rejectNodeId]) {
        [paramDic setObject:rejectNodeId forKey:@"reject_to_node_id"];
    }
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
 标记打款
 
 @param orderId 审批单ID
 @param orderRecordId 审批记录ID
 @param payState -1(异常) 100 （已打款）
 @param note 原因
 @param successBlock 标记打款成功
 @param failBlock 服务器未响应
 */
+ (void)OaExamineRequestMarkPaidWithOrderId:(NSString *)orderId orderRecordId:(NSString *)orderRecordId paidState:(PAY_STATE)payState note:(NSString *)note success:(void(^)(BOOL ok))successBlock fail:(void(^)(id error))failBlock
{
    NSString *url = [NSString stringWithFormat:@"%@oa_application_order/mark_paid",BossBasicURL];
    NSMutableDictionary *paramDic = [NSMutableDictionary dictionaryWithDictionary:@{
                                                                                    @"order_id":orderId,
                                                                                    @"order_record_id":orderRecordId,
                                                                                    @"paid_state":@(payState),
                                                                                    }];
    if (![JYCSimpleToolClass stringIsEmpty:note]) {
        [paramDic setObject:note forKey:@"note"];
    }
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
    NSString *url = [NSString stringWithFormat:@"%@oa_application_order/urge",BossBasicURL];
    NSDictionary *paramDic = @{
                               @"order_id":examineId,
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
 获取催办记录详情
 
 @param urgeId 催办记录ID
 @param recordId 被催办的审批记录ID
 @param successBlock 催办记录
 @param failBlock 服务器响应失败
 */
+ (void)OaExamineRequestGetUrgeDetailWithUrgeId:(NSString *)urgeId orderRecordId:(NSString *)recordId success:(void(^)(ApplicationUrgeRecordModel *urgeRecordModel))successBlock fail:(void(^)(id error))failBlock
{
    NSString *url = [NSString stringWithFormat:@"%@oa_application_order/get_urge_detail",BossBasicURL];
    NSDictionary *paramDic = @{
                               @"id":urgeId,
                               @"order_record_id":recordId,
                               };
    [NNBBasicRequest postJsonWithUrl:url parameters:paramDic CMD:nil success:^(id responseObject) {
        DLog(@"%@", responseObject);
        if (!successBlock) {
            return;
        }
        ApplicationUrgeRecordModel *model = [[ApplicationUrgeRecordModel alloc] init];
        [model setValuesForKeysWithDictionary:responseObject];
        successBlock(model);
    } fail:^(id error) {
        if(failBlock){
            failBlock(error);
        }
    }];
}
@end
