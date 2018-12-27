//
//  BossOaExamineRequest.m
//  BossCommonClass
//
//  Created by 贾远潮 on 2018/8/8.
//

#import "BossOaExamineRequest.h"
#import "NNBBasicRequest.h"
#import "NSDate+Helper.h"

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
        [NNBBasicRequest postJsonNativeWithUrl:BossBasicURLV2 parameters:paramDic cmd:@"oa.application_order.get" success:^(id responseObject) {
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
 @param nextNodeAccountId 下一节点的审批人
 @param successBlock 服务器响应返回
 @param failBlock 服务器响应失败
 */
+ (void)OaExamineRequestAgreeWithExamineOrderId:(NSString *)examineOrderId examineRecordId:(NSString *)recordId note:(NSString *)note nextNodeAccountId:(NSString *)nextNodeAccountId success:(void(^)(BOOL ok))successBlock fail:(void(^)(id error))failBlock;
{
    NSMutableDictionary *paramDic = [NSMutableDictionary dictionaryWithDictionary:@{
                                                                                    @"order_id":examineOrderId,
                                                                                    @"order_record_id":recordId,
                                                                                    }];
    if (![JYCSimpleToolClass stringIsEmpty:note]) {
        [paramDic setObject:note forKey:@"note"];
    }
    
    if (![JYCSimpleToolClass stringIsEmpty:nextNodeAccountId]) {
        [paramDic setObject:nextNodeAccountId forKey:@"next_node_account_id"];
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
 @param rejectToAccountId 退回指定节点审批人
 @param note 原因
 @param successBlock 服务器响应返回
 @param failBlock 服务器响应失败
 */
+ (void)OaExamineRequestRejectWithExamineOrderId:(NSString *)examineOrderId examineRecordId:(NSString *)recordId rejectNodeId:(NSString *)rejectNodeId rejectToAccountId:(NSString *)rejectToAccountId note:(NSString *)note success:(void(^)(BOOL ok))successBlock fail:(void(^)(id error))failBlock;
{
    NSMutableDictionary *paramDic = [NSMutableDictionary dictionaryWithDictionary:@{
                               @"order_id":examineOrderId,
                               @"order_record_id":recordId,
                               }];
    if (![JYCSimpleToolClass stringIsEmpty:rejectNodeId]) {
        [paramDic setObject:rejectNodeId forKey:@"reject_to_node_id"];
    }
    
    if (![JYCSimpleToolClass stringIsEmpty:rejectToAccountId]) {
        [paramDic setObject:rejectToAccountId forKey:@"reject_to_account_id"];
    }

    if (![JYCSimpleToolClass stringIsEmpty:note]) {
        [paramDic setObject:note forKey:@"note"];
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
 添加补充意见
 
 @param examineOrderId 审批单ID
 @param recordId 流转记录ID
 @param content 补充意见说明
 @param fileList 附件列表
 @param successBlock 服务器响应返回
 @param failBlock 服务器响应失败
 */
+ (void)OaExamineRequestCreateFlowExtraWithExamineOrderId:(NSString *)examineOrderId examineRecordId:(NSString *)recordId content:(NSString *)content fileList:(NSArray <NSString *>*)fileList success:(void(^)(BOOL ok))successBlock fail:(void(^)(id error))failBlock;
{
    NSMutableDictionary *paramDic = [NSMutableDictionary dictionaryWithDictionary:@{
                                                                                    @"order_id":examineOrderId,
                                                                                    @"record_id":recordId,
     
                                                                }];
    if (![JYCSimpleToolClass stringIsEmpty:content]) {
        [paramDic setObject:content forKey:@"content"];
    }
    
    if (fileList.count > 0) {
        [paramDic setObject:fileList forKey:@"file_list"];
    }
    
    [NNBBasicRequest postJsonWithUrl:BossBasicURLV2 parameters:paramDic CMD:@"oa.application_order.create_flow_extra" success:^(id responseObject) {
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
 删除补充意见
 
 @param flowExtraId 补充意见ID
 @param successBlock 服务器响应返回
 @param failBlock 服务器响应失败
 */
+ (void)OaExamineRequestDeleteFlowExtraWithFlowExtraId:(NSString *)flowExtraId success:(void(^)(BOOL ok))successBlock fail:(void(^)(id error))failBlock
{
    NSMutableDictionary *paramDic = [NSMutableDictionary dictionaryWithDictionary:@{
                                                                                    @"id":flowExtraId,
                                                                                    }];
    [NNBBasicRequest postJsonWithUrl:BossBasicURLV2 parameters:paramDic CMD:@"oa.application_order.delete_flow_extra" success:^(id responseObject) {
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

/**
 费用金额汇总
 @param examineOrderModel 审批单
 @param applyOrder 费用单
 @param successBlock 服务器响应成功
 @param failBlock 服务器响应失败
 */
+ (void)OaExamineRequestGetAmountSummaryWithExamineOrderModel:(ExamineOrderModel *)examineOrderModel applyOrderModel:(CostOrderModel *)applyOrder success:(void(^)(NSArray <CostBookMonthBriefModel *> *costBookMonthList))successBlock fail:(void(^)(id error))failBlock
{
//    @param accountingId 费用科目id
//    @param costTargetId 归属对象(供应商/城市/商圈/平台）ID
//    @param bookMonth 记账月份（201808）
//    @param costCenterType 成本归属类型
    
    CostAccountingModel *costAccountingModel = applyOrder.cost_accounting_info;
    NSString *accountingId = costAccountingModel._id;
    NSString *costTargetId = @"";
    
    NSString *bookMonth = examineOrderModel.submit_at_int;
    CostCenterType type = costAccountingModel.cost_center_type;

    NSMutableDictionary *listDic = @{}.mutableCopy;
    NSMutableArray *list = @[].mutableCopy;
    
    for (NSInteger i = 0; i < applyOrder.cost_allocation_list.count; i++) {
        if (applyOrder.cost_allocation_list.count == 0) {
            return;
        }
        
        NSString *key = [NSString stringWithFormat:@"%ld",i];
        
        CostAllocationModel *allocationModel = applyOrder.cost_allocation_list[i];
        
        switch (costAccountingModel.cost_center_type) {
            case CostCenterTypeItem:
                costTargetId = allocationModel.platform_code?:@"";
                break;
            case CostCenterTypeItemMainHQ:
                costTargetId = allocationModel.supplier_id?:@"";
                break;
            case CostCenterTypeCity:
                costTargetId = allocationModel.city_code?:@"";
                break;
            case CostCenterTypeBD:
                costTargetId = allocationModel.biz_district_id?:@"";
                break;
            case CostCenterTypeKnight:
                costTargetId = allocationModel.biz_district_id?:@"";
                break;
            default:
                break;
        }
        
        NSDictionary *paramDic = @{
                                   @"accounting_id":accountingId,
                                   @"cost_target_id":costTargetId,
                                   @"book_month":bookMonth,
                                   @"cost_center_type":@(type)
                                   };
        [NNBBasicRequest postJsonNativeWithUrl:BossBasicURLV2 parameters:paramDic cmd:@"oa.cost_order.get_amount_summary" success:^(id responseObject) {
            DLog(@"%@", responseObject);
            [self getListWithResponseObject:responseObject applyOrderModel:applyOrder key:key bookMonth:bookMonth listDic:listDic list:list success:successBlock];
        } fail:^(id error) {
            [self getListWithResponseObject:@{} applyOrderModel:applyOrder key:key bookMonth:bookMonth listDic:listDic list:list success:successBlock];
            return;
        }];
    }
}

+ (void)getListWithResponseObject:(id)responseObject applyOrderModel:(CostOrderModel *)applyOrder key:(NSString *)key bookMonth:(NSString *)bookMonth listDic:(NSMutableDictionary *)listDic list:(NSMutableArray *)list success:(void(^)(NSArray <CostBookMonthBriefModel *> *costBookMonthList))successBlock
{
    if (!successBlock) {
        return;
    }
    CostBookMonthBriefModel *model = [[CostBookMonthBriefModel alloc] init];
    [model setValuesForKeysWithDictionary:responseObject];
    
    NSDate *bookDate = [NSDate dateFromString:bookMonth withFormat:@"yyyyMM"];
    NSString *costDateString = [bookDate stringWithFormat:@"yyyy年MM月"];
    
    model.costBookString = [NSString stringWithFormat:@"%@已付款费用合计：￥%.2f",costDateString,model.money / 100.0];
    [listDic setObject:model forKey:key];
    if (listDic.count == applyOrder.cost_allocation_list.count) {
        for (NSInteger index = 0; index < listDic.count; index++) {
            NSString *indexKey = [NSString stringWithFormat:@"%ld",index];
            
            CostBookMonthBriefModel *indexModel = listDic[indexKey];
            
            [list addObject:indexModel];
            
        }
        successBlock(list.copy);
    }
}

@end
