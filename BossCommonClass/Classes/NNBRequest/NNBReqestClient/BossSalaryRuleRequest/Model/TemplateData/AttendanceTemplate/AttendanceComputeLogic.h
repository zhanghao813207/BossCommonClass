//
//  AttendanceComputeLogic.h
//  AFNetworking
//
//  Created by 贾远潮 on 2018/11/6.
//

#import <Foundation/Foundation.h>
#import "BossBasicDefine.h"
#import "WorkLogicOnceParamModel.h"
#import "WorkLogicOrderUnitParamModel.h"
#import "WorkLogicSalaryBaseParamModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface AttendanceComputeLogic : NSObject

/**
 总额补贴 work_logic_by_once:一次补贴  work_logic_by_order_unit:按单补贴 work_logic_by_salary_base:底薪补贴
 */
@property (nonatomic, strong) NSString *biz_logic;

@property (nonatomic, strong) WorkLogicOnceParamModel *by_once_params;

@property (nonatomic, strong) WorkLogicOrderUnitParamModel *by_order_unit_params;

@property (nonatomic, strong) WorkLogicSalaryBaseParamModel *by_salary_base_params;

@end

NS_ASSUME_NONNULL_END
