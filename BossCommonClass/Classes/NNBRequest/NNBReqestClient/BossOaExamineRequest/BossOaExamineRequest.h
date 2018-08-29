//
//  BossOaExamineRequest.h
//  BossCommonClass
//
//  Created by 贾远潮 on 2018/8/8.
//

#import <Foundation/Foundation.h>
#import "BossBasicDefine.h"
#import "ExamineOrderModel.h"
@interface BossOaExamineRequest : NSObject

/**
 获取审批列表

 @param type 移动端费用状态
 @param successBlock 返回审批列表
 @param failBlock 服务器响应失败
 */
+ (void)OaExamineRequestGetExamineListWithType:(MOBILE_EXAMINE_TYPES)type page:(NSInteger)page successBlock:(void(^)(NSArray <ExamineOrderModel *>*examineFlowList))successBlock fail:(void(^)(id error))failBlock;

/**
 费用汇总单详情

 @param examineId 汇总单ID
 @param successBlock 返回审批单详情
 @param failBlock 服务器响应失败
 */
+ (void)OaExamineRequestGetExamineDetailWithExamineId:(NSString *)examineId successBlock:(void(^)(ExamineOrderModel *examineFlowModel))successBlock fail:(void(^)(id error))failBlock;


/**
 费用单列表

 @param page 页码
 @param successBlock 返回费用单列表
 @param failBlock 服务器响应失败
 */
+ (void)OaExamineRequestGetCostOrderListWithPage:(NSInteger)page successBlock:(void(^)(NSArray <CostOrderModel *>*costOrderList))successBlock fail:(void(^)(id error))failBlock;


/**
 查看费用申请单详情

 @param orderId 申请单id
 @param successBlock 成功的回调
 @param failBlock 服务器响应失败
 */
+ (void)OaApplyOrderDetailWithOrderId:(NSString *)orderId successBlock:(void(^)(CostOrderModel *applyOrder))successBlock fail:(void(^)(id error))failBlock;

/**
 审核同意

 @param examineOrderId 审批单ID
 @param recordId 审批流转记录ID
 @param note 原因
 @param successBlock 服务器响应返回
 @param failBlock 服务器响应失败
 */
+ (void)OaExamineRequestAgreeWithExamineOrderId:(NSString *)examineOrderId examineRecordId:(NSString *)recordId note:(NSString *)note success:(void(^)(BOOL ok))successBlock fail:(void(^)(id error))failBlock;

/**
 审核驳回

 @param examineOrderId 审批单ID
 @param recordId 审批流转记录ID
 @param rejectNodeId 被驳回的节点id
 @param note 原因
 @param successBlock 服务器响应返回
 @param failBlock 服务器响应失败
 */
+ (void)OaExamineRequestRejectWithExamineOrderId:(NSString *)examineOrderId examineRecordId:(NSString *)recordId rejectNodeId:(NSString *)rejectNodeId note:(NSString *)note success:(void(^)(BOOL ok))successBlock fail:(void(^)(id error))failBlock;

/**
 催办操作

 @param examineId 汇总单ID
 @param successBlock 成功的回调
 @param failBlock 服务器响应失败
 */
+ (void)OaExamineRequestUrgedWithExamineId:(NSString *)examineId success:(void(^)(BOOL ok))successBlock fail:(void(^)(id error))failBlock;

@end
