//
//  PayrollStatementDetailModel.h
//  AFNetworking
//
//  Created by 贾远潮 on 2018/11/5.
//

#import "PayrollStatementModel.h"
#import "SalaryDataModel.h"
#import "StaffInfoModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PayrollStatementDetailModel : PayrollStatementModel

/**
 员工id
 */
@property (nonatomic, strong) NSString *staff_id;

/**
 薪资数据
 */
@property (nonatomic, strong) SalaryDataModel *salary_data;

/**
 员工信息
 */
@property (nonatomic, strong) StaffInfoModel *staff_info;

@end

NS_ASSUME_NONNULL_END
