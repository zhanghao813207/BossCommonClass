//
//  PayrollStatementModel.h
//  BossCommonClass
//
//  Created by 贾远潮 on 2018/11/5.
//

#import <Foundation/Foundation.h>
#import "BossBasicDefine.h"
NS_ASSUME_NONNULL_BEGIN

@interface PayrollStatementModel : NSObject

/**
 _id
 */
@property (nonatomic, strong) NSString *_id;

/**
 供应商id
 */
@property (nonatomic, strong) NSString *supplier_id;

/**
 平台code
 */
@property (nonatomic, strong) NSString *platform_code;

/**
 城市code
 */
@property (nonatomic, assign) NSInteger city_code;

/**
 商圈ID
 */
@property (nonatomic, strong) NSString *biz_district_id;

/**
 数据维度(2:商圈, 3:城市)
 */
@property (nonatomic, assign) StatementDataDomain domain;

/**
 周期类型(按月:1, 按日:2)
 */
@property (nonatomic, assign) PayrooCycleType payroll_cycle_type;

/**
 薪资计划id
 */
@property (nonatomic, strong) NSString *payroll_plan_id;

/**
 薪资计划周期编号
 */
@property (nonatomic, assign) NSInteger payroll_cycle_no;


/**
 职位id
 */
@property (nonatomic, assign) PositionID position_id;

/**
 总单量
 */
@property (nonatomic, assign) NSInteger order_count;

/**
 人员数量
 */
@property (nonatomic, assign) NSInteger staff_count;


/**
 单量提成金额
 */
@property (nonatomic, assign) NSInteger order_money;

/**
 出勤补贴金额
 */
@property (nonatomic, assign) NSInteger work_money;


/**
 质量补贴金额
 */
@property (nonatomic, assign) NSInteger qa_money;

/**
 管理补贴金额
 */
@property (nonatomic, assign) NSInteger operation_money;

/**
 应发总额
 */
@property (nonatomic, assign) NSInteger payable_money;

/**
 实发总额
 */
@property (nonatomic, assign) NSInteger net_pay_money;

/**
 状态(1=待审核, 50=审核中,100=审核通过)
 */
@property (nonatomic, assign) COST_ORDER_STATE state;

/**
 工作性质
 */
@property (nonatomic, assign) STAFFWORKTYPE work_type;

/**
 人事扣款总额
 */
@property (nonatomic, assign) NSInteger adjustment_hr_dec_money;

/**
 人事补款总额
 */
@property (nonatomic, assign) NSInteger adjustment_hr_inc_money;

/**
 员工扣款总额
 */
@property (nonatomic, assign) NSInteger adjustment_staff_dec_money;

/**
 员工补款总额
 */
@property (nonatomic, assign) NSInteger adjustment_staff_inc_money;

/**
 员工补款状态
 */
@property (nonatomic, assign) BOOL adjustment_staff_inc_state;

/**
 员工扣款状态
 */
@property (nonatomic, assign) BOOL adjustment_staff_dec_state;

/**
 人事补款状态
 */
@property (nonatomic, assign) BOOL adjustment_hr_inc_state;

/**
 人事扣款状态
 */
@property (nonatomic, assign) BOOL adjustment_hr_dec_state;

/**
 单均成本
 */
@property (nonatomic, assign) NSInteger single_average_amount;

/**
 OA审批单ID
 */
@property (nonatomic, strong) NSString *oa_application_order_id;

/**
 薪资计算结果集ID
 */
@property (nonatomic, strong) NSString *salary_compute_data_set_id;

/**
 起始日期
 */
@property (nonatomic, assign) NSInteger start_date;

/**
 结束日期
 */
@property (nonatomic, assign) NSInteger end_date;

/**
 日
 */
@property (nonatomic, assign) NSInteger day;

/**
 月
 */
@property (nonatomic, assign) NSInteger month;

/**
 年
 */
@property (nonatomic, assign) NSInteger year;

/**
 创建时间
 */
@property (nonatomic, strong) NSString *created_at;

/**
 更新时间
 */
@property (nonatomic, strong) NSString *updated_at;

@end

NS_ASSUME_NONNULL_END
