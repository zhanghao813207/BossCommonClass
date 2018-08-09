//
//  BossOaExamineRequest.h
//  BossCommonClass
//
//  Created by 贾远潮 on 2018/8/8.
//

#import <Foundation/Foundation.h>
#import "BossBasicDefine.h"
#import "ExamineFlowModel.h"
@interface BossOaExamineRequest : NSObject

/**
 获取审批列表

 @param type 移动端费用状态
 @param successBlock 返回审批列表
 @param failBlock 服务器响应失败
 */
+ (void)OaExamineRequestGetExamineListWithType:(MOBILE_EXAMINE_TYPES)type successBlock:(void(^)(NSArray <ExamineFlowModel *>*examineFlowList))successBlock fail:(void(^)(id error))failBlock;

/**
 费用汇总单详情

 @param examineId 汇总单ID
 @param successBlock 返回审批单详情
 @param failBlock 服务器响应失败
 */
+ (void)OaExamineRequestGetExamineDetailWithExamineId:(NSString *)examineId successBlock:(void(^)(ExamineFlowModel *examineFlowModel))successBlock fail:(void(^)(id error))failBlock;

/**
 查看费用申请单详情

 @param orderId 申请单id
 @param successBlock 成功的回调
 @param failBlock 服务器响应失败
 */
+ (void)OaApplyOrderDetailWithOrderId:(NSString *)orderId successBlock:(void(^)(ApplyOrderModel *applyOrder))successBlock fail:(void(^)(id error))failBlock;

/**
 审批操作

 @param examineId 审批单id
 @param state 审批动作
 @param des 审批意见
 @param successBlock 操作是否成功
 @param failBlock 服务器响应失败
 */
+ (void)OaExamineRequestWithExamineId:(NSString *)examineId examineState:(OA_EXAMINE_NODE_STATE)state des:(NSString *)des success:(void(^)(BOOL ok))successBlock fail:(void(^)(id error))failBlock;

/**
 催办操作

 @param examineId 汇总单ID
 @param successBlock 成功的回调
 @param failBlock 服务器响应失败
 */
+ (void)OaExamineRequestUrgedWithExamineId:(NSString *)examineId success:(void(^)(BOOL ok))successBlock fail:(void(^)(id error))failBlock;

@end
