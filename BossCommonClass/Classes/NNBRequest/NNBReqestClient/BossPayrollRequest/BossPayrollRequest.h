//
//  BossPayrollRequest.h
//  BossCommonClass
//
//  Created by 贾远潮 on 2018/11/2.
//

#import <Foundation/Foundation.h>
#import "PayrollStatementModel.h"
#import "PayrollStatementDetailModel.h"
#import "BossBasicDefine.h"

NS_ASSUME_NONNULL_BEGIN

@interface BossPayrollRequest : NSObject

/**
 薪资单汇总列表

 @param platform 平台code
 @param supplierIds 供应商ID
 @param citycode 城市code
 @param work_types 工作性质(3001:兼职,3002:全职)
 @param state 审核状态(1=待审核, 50=审核中,100=审核通过)
 @param successBlock 成功回调
 @param failBlock 失败回调
 */
+ (void)payrollFindWithPlatform:(NSString *)platform supplierId:(NSArray *)supplierIds city:(NSArray <NSString *>*)citycode workType:(NSArray <NSNumber *>*)work_types state:(NSArray *)state success:(void(^)(NSArray <PayrollStatementModel *>*payrollStatementArray))successBlock fail:(void(^)(id error))failBlock;


/**
 薪资单列表
 
 @param page 页数
 @param payrollStatementId 薪资单账单ID
 @param bizDistrictId 商圈ID
 @param staffName 姓名
 @param pay_salary_state 薪资发放状态(1:正常,2:缓发)
 @param successBlock 成功
 @param failBlock 失败
 */
+ (void)payrollFindPayrollWithPage:(NSInteger)page statementId:(NSString *)payrollStatementId bizDistrictId:(NSString *)bizDistrictId name:(NSString *)staffName paySalaryState:(PaySalaryState)pay_salary_state success:(void (^)(BOOL hasMore, NSArray <PayrollStatementDetailModel *>*payroll_list))successBlock fail:(void(^)(id error))failBlock;

/**
 按平台城市查询商圈
 
 @param cityList 城市列表
 @param successBlock 成功回调城市商圈列表
 @param failBlock 失败回调
 */
+ (void)payrollGetBizDistrictByCityList:(NSArray *)cityList success:(void(^)(NSArray <BizDistrictModel *>*bizDistrictList))successBlock fail:(void(^)(id error))failBlock;


@end
NS_ASSUME_NONNULL_END
