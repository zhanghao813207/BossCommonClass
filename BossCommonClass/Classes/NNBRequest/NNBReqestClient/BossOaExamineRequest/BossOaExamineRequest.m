//
//  BossOaExamineRequest.m
//  BossCommonClass
//
//  Created by 贾远潮 on 2018/8/8.
//

#import "BossOaExamineRequest.h"
#import "NNBBasicRequest.h"
#import "NSDate+Helper.h"
#import "BossManagerAccount.h"
#import "SaasModel.h"
#import "NNBRequestManager.h"
#import "PrintBeautifulLog.h"
//调试代码 解决打印不全的问题
#ifdef DEBUG
#define NSLog(FORMAT, ...) fprintf(stderr, "%s:%zd\t%s\n", [[[NSString stringWithUTF8String: __FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat: FORMAT, ## __VA_ARGS__] UTF8String]);
#else
#define NSLog(FORMAT, ...) nil
#endif

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
            [paramDic setObject:@[kCurrentBossManagerAccount.accountModel._id] forKey:@"current_pending_accounts"];
            [paramDic setObject:stateArray forKey:@"state"];
        }
            break;
        case MOBILE_PUT_EXAMINE_ALL:
        {
            stateArray = @[@(OA_EXAMINE_STATE_DONE),@(OA_EXAMINE_STATE_SHUTDOWN),@(OA_EXAMINE_STATE_UNDERWAY)];
            [paramDic setObject:kCurrentBossManagerAccount.accountModel._id forKey:@"apply_account_id"];
            [paramDic setObject:stateArray forKey:@"state"];
        }
            break;
        case MOBILE_PUT_EXAMINE_PRESENT:
        {
            stateArray = @[@(OA_EXAMINE_STATE_UNDERWAY)];
            [paramDic setObject:kCurrentBossManagerAccount.accountModel._id forKey:@"apply_account_id"];
            [paramDic setObject:stateArray forKey:@"state"];
        }
            break;
        case MOBILE_PUT_EXAMINE_SUCCEED:
        {
            stateArray = @[@(OA_EXAMINE_STATE_DONE)];
            [paramDic setObject:kCurrentBossManagerAccount.accountModel._id forKey:@"apply_account_id"];
            [paramDic setObject:stateArray forKey:@"state"];
        }
            break;
        case MOBILE_PUT_EXAMINE_FAIL:
        {
            stateArray = @[@(OA_EXAMINE_STATE_SHUTDOWN)];
            [paramDic setObject:kCurrentBossManagerAccount.accountModel._id forKey:@"apply_account_id"];
            [paramDic setObject:stateArray forKey:@"state"];
        }
            break;
        case MOBILE_PASS_EXAMINE_ALL:
        {
            stateArray = @[@(OA_EXAMINE_STATE_UNDERWAY),@(OA_EXAMINE_STATE_DONE),@(OA_EXAMINE_STATE_SHUTDOWN)];
            [paramDic setObject:@[kCurrentBossManagerAccount.accountModel._id] forKey:@"flow_accounts"];
            [paramDic setObject:stateArray forKey:@"state"];
        }
            break;
        case MOBILE_PASS_EXAMINE_PRESENT:
        {
            stateArray = @[@(OA_EXAMINE_STATE_UNDERWAY)];
            [paramDic setObject:@[kCurrentBossManagerAccount.accountModel._id] forKey:@"flow_accounts"];
            [paramDic setObject:stateArray forKey:@"state"];
        }
            break;
        case MOBILE_PASS_EXAMINE_SUCCEED:
        {
            stateArray = @[@(OA_EXAMINE_STATE_DONE)];
            [paramDic setObject:@[kCurrentBossManagerAccount.accountModel._id] forKey:@"flow_accounts"];
            [paramDic setObject:stateArray forKey:@"state"];
        }
            break;
        case MOBILE_PASS_EXAMINE_FAIL:
        {
            stateArray = @[@(OA_EXAMINE_STATE_SHUTDOWN)];
            [paramDic setObject:@[kCurrentBossManagerAccount.accountModel._id] forKey:@"flow_accounts"];
            [paramDic setObject:stateArray forKey:@"state"];
        }
            break;
        default:
            break;
    }
    
    [NNBBasicRequest postJsonWithUrl:kUrl parameters:paramDic CMD:@"oa.application_order.find" success:^(id responseObject) {
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
        [NNBBasicRequest postJsonWithUrl:kUrl parameters:paramDic CMD:@"oa.application_order.get" success:^(id responseObject) {
            DLog(@"节点1 %@", responseObject);
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
        [NNBBasicRequest postJsonNativeWithUrl:kUrl parameters:paramDic cmd:@"oa.application_order.get" success:^(id responseObject) {
            DLog(@"节点2 %@", responseObject);
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
    
    [NNBBasicRequest postJsonWithUrl:kUrl parameters:paramDic CMD:@"oa.cost_order.get" success:^(id responseObject) {
        NSLog(@"费用单数据%@", responseObject);
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

+ (void)OaExamineRequestAgreeWithExamineOrderId:(NSString *)examineOrderId examineRecordId:(NSString *)recordId note:(NSString *)note nextNodeAccountId:(NSString *)nextNodeAccountId
    nextNodePostId:(NSString *)nextNodePostId success:(void(^)(BOOL ok))successBlock fail:(void(^)(id error))failBlock;
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
    
    if (![JYCSimpleToolClass stringIsEmpty:nextNodePostId]) {
        [paramDic setObject:nextNodePostId forKey:@"next_node_post_id"];
    }
    
    [NNBBasicRequest postJsonNoneWithUrl:kUrl parameters:paramDic CMD:@"oa.application_order.approve" success:^(id responseObject) {
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

+ (void)OaExamineRequestRejectWithExamineOrderId:(NSString *)examineOrderId examineRecordId:(NSString *)recordId rejectNodeId:(NSString *)rejectNodeId rejectToAccountId:(NSString *)rejectToAccountId rejectToPostId:(NSString *)rejectToPostId note:(NSString *)note success:(void(^)(BOOL ok))successBlock fail:(void(^)(id error))failBlock;
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
    
    if (![JYCSimpleToolClass stringIsEmpty:rejectToPostId]) {
        [paramDic setObject:rejectToPostId forKey:@"reject_to_post_id"];
    }

    if (![JYCSimpleToolClass stringIsEmpty:note]) {
        [paramDic setObject:note forKey:@"note"];
    }
    
    [NNBBasicRequest postJsonNoneWithUrl:kUrl parameters:paramDic CMD:@"oa.application_order.reject" success:^(id responseObject) {
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
    
    [NNBBasicRequest postJsonWithUrl:kUrl parameters:paramDic CMD:@"oa.application_order.create_flow_extra" success:^(id responseObject) {
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
    [NNBBasicRequest postJsonWithUrl:kUrl parameters:paramDic CMD:@"oa.application_order.delete_flow_extra" success:^(id responseObject) {
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
    [NNBBasicRequest postJsonNoneWithUrl:kUrl parameters:paramDic CMD:@"oa.application_order.urge" success:^(id responseObject) {
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
    
    [NNBBasicRequest postJsonNoneWithUrl:kUrl parameters:paramDic CMD:@"oa.application_order.mark_paid" success:^(id responseObject) {
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
    
    [NNBBasicRequest postJsonWithUrl:kUrl parameters:paramDic CMD:@"oa.application_order.get_urge_detail" success:^(id responseObject) {
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
        
        NSString *key = [NSString stringWithFormat:@"%tu",i];
        
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
        [NNBBasicRequest postJsonNativeWithUrl:kUrl parameters:paramDic cmd:@"oa.cost_order.get_amount_summary" success:^(id responseObject) {
            DLog(@"%@", responseObject);
            [self getListWithResponseObject:responseObject applyOrderModel:applyOrder key:key bookMonth:bookMonth listDic:listDic list:list success:successBlock];
        } fail:^(id error) {
            [self getListWithResponseObject:@{} applyOrderModel:applyOrder key:key bookMonth:bookMonth listDic:listDic list:list success:successBlock];
            return;
        }];
    }
}

/**
 提报费用金额统计
 
 request param:
 - accounting_id 费用科目id Y
 - platform_code 平台code N
 - supplier_id 供应商id N
 - city_code 城市code N
 - biz_district_id 商圈id N
 - submit_at 提报时间(2018-01) Y
 
 传参规则: 参数有值就传，没有就传null
 参数说明:
 1. 如果精确到platform_code, 则传到platform_code即可
 2. 如果精确到supplier_id, 则传到platform_code, supplier_id即可
 3. 如果精确到city_code, 则传到platform_code, supplier_id, city_code即可
 4. 如果精确到biz_district_id, 则传到platform_code, supplier_id, city_code, biz_district_id即
 
 @param examineOrderModel 审批单
 @param applyOrder 费用单
 @param successBlock 服务器响应成功
 @param failBlock 服务器响应失败
 */
+ (void)OaExamineRequestGetSubmitAmount:(ExamineOrderModel *)examineOrderModel applyOrderModel:(CostOrderModel *)applyOrder success:(void(^)(NSArray <CostOrderSubmitAmountModel *> *submitAmountList))successBlock fail:(void(^)(id error))failBlock
{
    
    CostAccountingModel *costAccountingModel = applyOrder.cost_accounting_info;
    NSString *accountingId = costAccountingModel._id;
    NSString *submitAt = examineOrderModel.submit_at;
    
    NSMutableDictionary *listDic = @{}.mutableCopy;
    NSMutableArray *list = @[].mutableCopy;
    
    for (NSInteger i = 0; i < applyOrder.cost_allocation_list.count; i++) {
        if (applyOrder.cost_allocation_list.count == 0) {
            return;
        }
        
        NSString *key = [NSString stringWithFormat:@"%tu",i];
        
        CostAllocationModel *allocationModel = applyOrder.cost_allocation_list[i];
        
        // 请求参数
        NSMutableDictionary *paramDic = [BossOaExamineRequest getSubmitAmountRequestParams:accountingId submitAt:submitAt allocationModel:allocationModel];
        
        // 发送网络请求
        [NNBBasicRequest postJsonNativeWithUrl:kUrl parameters:paramDic cmd:@"oa.cost_order.get_amount_with_submit" success:^(id responseObject) {
            DLog(@"%@", responseObject);
            [BossOaExamineRequest handleGetSubmitAmountResponse:responseObject applyOrderModel:applyOrder key:key submitAt:submitAt listDic:listDic list:list success:successBlock];
        } fail:^(id error) {
            [BossOaExamineRequest handleGetSubmitAmountResponse:@{} applyOrderModel:applyOrder key:key submitAt:submitAt listDic:listDic list:list success:successBlock];
        }];
    }
}

/**
 提报费用金额统计请求参数
 
 @return 请求参数
 */
+ (NSMutableDictionary *)getSubmitAmountRequestParams:(NSString *)accountingId submitAt:(NSString *) submitAt allocationModel:(CostAllocationModel *)allocationModel
{
    NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
    
    // 科目Id
    [paramDic setValue:accountingId forKey:@"accounting_id"];
    
    // 提报时间 eg:"2018-01-14"
    NSDate *date = [NSDate dateFromString:submitAt withFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *submitAtStr = [date stringWithFormat:@"yyyy-MM-dd"];
    [paramDic setValue:submitAtStr forKey:@"submit_at"];
    
    
    // 请求参数value = @““会被过滤
    // 平台code
    [paramDic setValue:allocationModel.platform_code?:@"" forKey:@"platform_code"];
    // 供应商Id
    [paramDic setValue:allocationModel.supplier_id?:@"" forKey:@"supplier_id"];
    // 城市code
    [paramDic setValue:allocationModel.city_code?:@"" forKey:@"city_code"];
    // 商圈Id
    [paramDic setValue:allocationModel.biz_district_id?:@"" forKey:@"biz_district_id"];
    
    return paramDic;
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
            NSString *indexKey = [NSString stringWithFormat:@"%tu",index];
            
            CostBookMonthBriefModel *indexModel = listDic[indexKey];
            
            [list addObject:indexModel];
        }
        successBlock(list.copy);
    }
}

/**
 提报费用金额统计请求处理
 
 @param responseObject 请求结果
 @param applyOrder 费用单
 @param key key
 @param submitAt 提报时间
 @param listDic 提报费用金额统计集合
 @param list 提报费用金额统计列表
 @param successBlock 请求结果回调
 */
+ (void)handleGetSubmitAmountResponse:(id)responseObject applyOrderModel:(CostOrderModel *)applyOrder key:(NSString *)key submitAt:(NSString *)submitAt listDic:(NSMutableDictionary *)listDic list:(NSMutableArray *)list success:(void(^)(NSArray <CostOrderSubmitAmountModel *> *costBookMonthList))successBlock
{
    CostOrderSubmitAmountModel *model = [[CostOrderSubmitAmountModel alloc] init];
    [model setValuesForKeysWithDictionary:responseObject];
    
    NSDate *date = [NSDate dateFromString:submitAt withFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *submitAtString = [date stringWithFormat:@"yyyy年MM月"];
    // eg:"XXXX年XX月已提报费用合计：￥00.00"
    model.submitAmountStr = [NSString stringWithFormat:@"%@已提报费用合计：￥%.2f",submitAtString,model.amount_money / 100.0];
    [listDic setObject:model forKey:key];
    if (listDic.count == applyOrder.cost_allocation_list.count) {
        for (NSInteger index = 0; index < listDic.count; index++) {
            NSString *indexKey = [NSString stringWithFormat:@"%tu",index];
            
            CostOrderSubmitAmountModel *indexModel = listDic[indexKey];
            
            [list addObject:indexModel];
            
        }
        successBlock(list.copy);
    }
}

@end
