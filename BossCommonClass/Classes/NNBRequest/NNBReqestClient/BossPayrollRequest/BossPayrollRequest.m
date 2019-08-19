//
//  BossPayrollRequest.m
//  BossCommonClass
//
//  Created by 贾远潮 on 2018/11/2.
//

#import "BossPayrollRequest.h"
#import "NNBBasicRequest.h"
#import "NNBRequestManager.h"

@implementation BossPayrollRequest

/**
 结算单汇总列表
 
 @param platform 平台code
 @param supplierIds 供应商ID
 @param citycode 城市code
 @param work_types 工作性质(3001:乙类,3002:全职)
 @param state 审核状态(1=待审核, 50=审核中,100=审核通过)
 @param successBlock 成功回调
 @param failBlock 失败回调
 */
+ (void)payrollFindWithPlatform:(NSString *)platform supplierId:(NSArray *)supplierIds city:(NSArray <NSString *>*)citycode workType:(NSArray <NSNumber *>*)work_types state:(NSArray *)state success:(void(^)(NSArray <PayrollStatementModel *>*payrollStatementArray))successBlock fail:(void(^)(id error))failBlock
{
    NSDictionary *paramDic = @{
                               @"_meta":@{
                                       @"page":@(1),
                                       @"limit":@(1),
                                       },
                               @"platform_code":platform,
                               @"supplier_id":supplierIds,
                               @"city_code":citycode,
                               @"work_type":work_types,
                               @"state":state,
                               };
    [NNBBasicRequest postJsonWithUrl:kUrl parameters:paramDic CMD:@"payroll.payroll_statement.find" success:^(id responseObject) {
        if (!successBlock) {
            return;
        }
        NSMutableArray *array = [NSMutableArray array];
        for (NSDictionary *resDic in responseObject[@"data"]) {
            PayrollStatementModel *model = [[PayrollStatementModel alloc] init];
            [model setValuesForKeysWithDictionary:resDic];
            [array addObject:model];
        }
        successBlock([array copy]);
    } fail:^(id error) {
        DLog(@"payrollerror = %@",error);
    }];
}

/**
 结算单列表
 
 @param page 页数
 @param payrollStatementId 结算单账单ID
 @param bizDistrictId 商圈ID
 @param staffName 姓名
 @param pay_salary_state 服务费发放状态(1:正常,2:缓发)
 @param successBlock 成功
 @param failBlock 失败
 */
+ (void)payrollFindPayrollWithPage:(NSInteger)page statementId:(NSString *)payrollStatementId bizDistrictId:(NSString *)bizDistrictId name:(NSString *)staffName paySalaryState:(PaySalaryState)pay_salary_state success:(void (^)(BOOL hasMore, NSArray <PayrollStatementDetailModel *>*payroll_list))successBlock fail:(void(^)(id error))failBlock
{
    NSMutableDictionary *paramDic = @{
                                      @"_meta":@{
                                              @"page":@(page),
                                              @"limit":@(30),
                                              },
                                      @"salary_statement_id":payrollStatementId,
//                                    @"name":staffName,
                                      @"pay_salary_state":@(pay_salary_state),
                                      }.mutableCopy;
    if (bizDistrictId) {
        [paramDic setObject:bizDistrictId forKey:@"salary_statement_id"];
    }
    [NNBBasicRequest postJsonWithUrl:kUrl parameters:paramDic CMD:@"payroll.payroll.find" success:^(id responseObject) {
        if (!successBlock) {
            return;
        }
        NSMutableArray *array = [NSMutableArray array];
        for (NSDictionary *resDic in responseObject[@"data"]) {
            PayrollStatementDetailModel *model = [[PayrollStatementDetailModel alloc] init];
            [model setValuesForKeysWithDictionary:resDic];
            [array addObject:model];
        }
        successBlock([responseObject[@"_meta"][@"has_more"] boolValue],[array copy]);
    } fail:^(id error) {
        DLog(@"payrollerror = %@",error);
    }];
}

/**
 按平台城市查询商圈
 
 @param cityList 城市列表
 @param successBlock 成功回调城市商圈列表
 @param failBlock 失败回调
 */
+ (void)payrollGetBizDistrictByCityList:(NSArray *)cityList success:(void(^)(NSArray <BizDistrictModel *>*bizDistrictList))successBlock fail:(void(^)(id error))failBlock
{
    NSString *url = [NSString stringWithFormat:@"%@platform/get_biz_district",kUrlApiVersion(@"/1.0")];
    NSDictionary *paramDic = @{
                               @"city_list":cityList,
                               };
    [NNBBasicRequest postJsonWithUrl:url parameters:paramDic CMD:nil success:^(id responseObject) {
        if (!successBlock) {
            return;
        }
        NSMutableArray *array = [NSMutableArray array];
        for (NSDictionary *resDic in responseObject[@"biz_district_list"]) {
            BizDistrictModel *model = [[BizDistrictModel alloc] init];
            [model setValuesForKeysWithDictionary:resDic];
            [array addObject:model];
        }
        successBlock([array copy]);
    } fail:^(id error) {
        DLog(@"payrollerror = %@",error);
    }];

}
@end
