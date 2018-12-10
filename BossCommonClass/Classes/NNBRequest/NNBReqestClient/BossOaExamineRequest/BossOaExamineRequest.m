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
+ (void)OaExamineRequestGetExamineListWithType:(MOBILE_EXAMINE_TYPES)type page:(NSInteger)page successBlock:(void(^)(BOOL hasMore, NSArray <ExamineOrderModel *>*examineFlowList))successBlock fail:(void(^)(id error))failBlock
{
    // 分页信息
    NSDictionary *meta = @{
                           @"page":@(page),
                           @"limit":@(30),
                           @"sort":@{
                                   @"submit_at":@(-1)
                                   }
                           };
    
    NSMutableDictionary *paramDic = [NSMutableDictionary dictionaryWithDictionary:meta];
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
    
    [NNBBasicRequest postJsonWithUrl:BossBasicURLV2 parameters:paramDic CMD:@"oa.application_order.find" success:^(id responseObject) {
        DLog(@"%@", responseObject);
        if (!successBlock) {
            return;
        }
        NSMutableArray *array = [NSMutableArray array];
        for (NSDictionary* dataDic in responseObject[@"data"]) {
            ExamineOrderModel *model = [[ExamineOrderModel alloc] init];
            [model setValuesForKeysWithDictionary:dataDic];
            [array addObject:model];
        }
        successBlock([responseObject[@"_meta"][@"has_more"] boolValue],[array copy]);
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
    NSDictionary *paramDic = @{
                               @"id":examineId,
                               };
    if (showError) {
        [NNBBasicRequest postJsonWithUrl:BossBasicURLV2 parameters:paramDic CMD:@"oa.application_order.get" success:^(id responseObject) {
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
        [NNBBasicRequest postJsonWithUrl:BossBasicURLV2 parameters:paramDic CMD:@"oa.application_order.get" success:^(id responseObject) {
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
 费用申请单详情
 
 @param orderId 申请单id
 @param successBlock 成功的回调
 @param failBlock 服务器响应失败
 */
+ (void)OaApplyOrderDetailWithOrderId:(NSString *)orderId successBlock:(void(^)(CostOrderModel *applyOrder))successBlock fail:(void(^)(id error))failBlock
{
    NSDictionary *paramDic = @{
                               @"id":orderId,
                               };
    
    [NNBBasicRequest postJsonWithUrl:BossBasicURLV2 parameters:paramDic CMD:@"oa.cost_order.get" success:^(id responseObject) {
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
    NSMutableDictionary *paramDic = [NSMutableDictionary dictionaryWithDictionary:@{
                                                                                    @"order_id":examineOrderId,
                                                                                    @"order_record_id":recordId,
                                                                                    }];
    if (![JYCSimpleToolClass stringIsEmpty:note]) {
        [paramDic setObject:note forKey:@"note"];
    }
    
    [NNBBasicRequest postJsonWithUrl:BossBasicURLV2 parameters:paramDic CMD:@"oa.application_order.approve" success:^(id responseObject) {
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
    
    [NNBBasicRequest postJsonWithUrl:BossBasicURLV2 parameters:paramDic CMD:@"oa.application_order.reject" success:^(id responseObject) {
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
    NSDictionary *paramDic = @{
                               @"order_id":examineId,
                               };
    [NNBBasicRequest postJsonWithUrl:BossBasicURLV2 parameters:paramDic CMD:@"oa.application_order.urge" success:^(id responseObject) {
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
    NSMutableDictionary *paramDic = [NSMutableDictionary dictionaryWithDictionary:@{
                                                                                    @"order_id":orderId,
                                                                                    @"order_record_id":orderRecordId,
                                                                                    @"paid_state":@(payState),
                                                                                    }];
    if (![JYCSimpleToolClass stringIsEmpty:note]) {
        [paramDic setObject:note forKey:@"note"];
    }
    
    [NNBBasicRequest postJsonWithUrl:BossBasicURLV2 parameters:paramDic CMD:@"oa.application_order.mark_paid" success:^(id responseObject) {
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
    NSDictionary *paramDic = @{
                               @"id":urgeId,
                               @"order_record_id":recordId,
                               };
    
    [NNBBasicRequest postJsonWithUrl:BossBasicURLV2 parameters:paramDic CMD:@"oa.application_order.get_urge_detail" success:^(id responseObject) {
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
