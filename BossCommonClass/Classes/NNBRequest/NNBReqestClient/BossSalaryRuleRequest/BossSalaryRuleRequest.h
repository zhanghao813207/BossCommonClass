//
//  BossSalaryRuleRequest.h
//  BossCommonClass
//
//  Created by 贾远潮 on 2018/11/6.
//

#import <Foundation/Foundation.h>
#import "SalaryPlaneModel.h"
#import "TemplateDataBasicModel.h"
#import "AttendanceTemplateModel.h"
#import "OrderTemplateModel.h"
#import "QualityTemplateModel.h"
#import "ManageTemplateModel.h"
#import "SalaryComputeDatasetModel.h"
#import "IndexInfoModel.h"
#import "BossBasicDefine.h"

NS_ASSUME_NONNULL_BEGIN

@interface BossSalaryRuleRequest : NSObject

/**
 获取指标列表

 @param platformCode 平台code
 @param successBlock 成功回调
 @param failBlock 服务器响应失败
 */
+ (void)salaryRequestFindSalaryVarListWithPlatformCode:(NSString *)platformCode success:(void(^)(NSArray <IndexInfoModel *>*indexList))successBlock fail:(void(^)(id error))failBlock;

/**
 服务费方案版本详情

 @param versionId 版本ID
 @param successBlock 成功回调
 @param failBlock 服务器响应失败
 */
+ (void)salaryRuleRequestGetSalaryPlaneDetailWithVersionId:(NSString *)versionId success:(void(^)(SalaryPlaneModel *salaryPlaneModel))successBlock fail:(void(^)(id error))failBlock;


/**
 服务费计算规则列表

 @param ruleCollectionId 服务费规则集ID
 @param collection_cate 规则分类(1:单量,2:出勤,3:质量,4:管理)
 @param successBlock 成功回调
 @param failBlock 失败
 */
+ (void)salaryRuleRequestFindSalaryRuleListWithRuleCollectionId:(NSString *)ruleCollectionId salarRuleCollectionType:(SalaryRuleCollectionType)collection_cate success:(void(^)(NSArray <TemplateDataBasicModel *>*templateList))successBlock fail:(void (^)(id error))failBlock;

/**
 人员服务费计算结果集列表
 
 @param page 页数
 @param taskId  服务费试算任务id
 @param type '1（人员明细）2（商圈）3（城市）'
 @param successBlock 成功的回调
 @param failBlock 服务器响应失败
 */
+ (void)salaryComputeFindSalaryComputeDataSetWithPage:(NSInteger)page taskID:(NSString *)taskId type:(SalaryComputeTaskType)type success:(void(^)(BOOL hasMore, NSArray <SalaryComputeDatasetModel *> *salaryComputeList))successBlock fail:(void (^)(id error))failBlock;

@end

NS_ASSUME_NONNULL_END
