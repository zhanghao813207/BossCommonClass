//
//  SalaryDataModel.h
//  AFNetworking
//
//  Created by 贾远潮 on 2018/11/5.
//

#import <Foundation/Foundation.h>
#import "BossBasicDefine.h"
#import "MoneyDetailItemModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SalaryDataModel : NSObject

/**
 姓名
 */
@property (nonatomic, strong) NSString *name;

/**
 身份证号
 */
@property (nonatomic, strong) NSString *identity_card_id;

@property (nonatomic, strong) NSString *phone;

@property (nonatomic, strong) NSString *bank_card_id;
@property (nonatomic, strong) NSString *bank_branch;
@property (nonatomic, strong) NSString *bank_location;
@property (nonatomic, strong) NSString *platform_code;
@property (nonatomic, strong) NSString *supplier_id;
@property (nonatomic, strong) NSString *city_code;
@property (nonatomic, assign) PositionID position_id;

/**
 在职状态
 */
@property (nonatomic, assign) StaffStates state;

/**
 入职时间
 */
@property (nonatomic, strong) NSString *entry_date;

/**
 应聘渠道
 */
@property (nonatomic, strong) NSString *recruitment_channel_id;

/**
 合同归属
 */
@property (nonatomic, strong) NSString *contract_belong_id;

/**
 离职时间
 */
@property (nonatomic, strong) NSString *departure_date;

/**
 完成单量
 */
@property (nonatomic, assign) NSInteger order_count;

/**
 出单天数
 */
@property (nonatomic, assign) NSInteger work_days;

/**
 人效(单/人日)
 */
@property (nonatomic, assign) NSInteger work_efficiency;

/**
 有效出勤
 */
@property (nonatomic, assign) NSInteger valid_attendance;

/**
 准时单量
 */
@property (nonatomic, assign) NSInteger month_time_limit_complete_order_count;

/**
 超时单量
 */
@property (nonatomic, assign) NSInteger month_timeout_order_count;

/**
 好评单量
 */
@property (nonatomic, assign) NSInteger month_praise_order_count;

/**
 差评单量
 */
@property (nonatomic, assign) NSInteger month_bad_order_count;
/**
 单量提成
 */
@property (nonatomic, assign) NSInteger order_money;

/**
 出勤补贴
 */
@property (nonatomic, assign) NSInteger work_money;

/**
 质量补贴
 */
@property (nonatomic, assign) NSInteger qa_money;

/**
 管理扣罚
 */
@property (nonatomic, assign) NSInteger operation_money;

/**
 新项目
 */
@property (nonatomic, assign) NSInteger new_item;

/**
 骑士补款
 */
@property (nonatomic, strong) NSArray <MoneyDetailItemModel *>*knight_payment;

/**
 特殊时段补贴
 */
@property (nonatomic, assign) NSInteger special_time_subsidy;

/**
 特殊季节补贴
 */
@property (nonatomic, assign) NSInteger special_season_subsidy;
/**
 恶劣天气补贴
 */
@property (nonatomic, assign) NSInteger bad_weather_subsidy;
/**
 优秀员工奖励
 */
@property (nonatomic, assign) NSInteger excellent_staff_award;
/**
 调整考勤差异
 */
@property (nonatomic, assign) NSInteger adjustment_work_differences;
/**
 调整单量差异
 */
@property (nonatomic, assign) NSInteger adjustment_order_differences;
/**
 扣罚减免
 */
@property (nonatomic, assign) NSInteger deduction_reduction;
/**
 工龄补助
 */
@property (nonatomic, assign) NSInteger subsidy_seniority;
/**
 充电补助
 */
@property (nonatomic, assign) NSInteger subsidy_charge;
/**
 车补
 */
@property (nonatomic, assign) NSInteger subsidy_car;
/**
 话补
 */
@property (nonatomic, assign) NSInteger subsidy_phone;
/**
 装备押金返还
 */
@property (nonatomic, assign) NSInteger equipment_deposit_return;
/**
 其他补款
 */
@property (nonatomic, assign) NSInteger order_payment;
/**
 骑士扣款
 */
@property (nonatomic, strong) NSArray <MoneyDetailItemModel *>*knight_deduction;
/**
 平台线下罚款
 */
@property (nonatomic, assign) NSInteger platform_offline_deduction;
/**
 住宿/房租扣款
 */
@property (nonatomic, assign) NSInteger rent_deduction;
/**
 水电网费扣款
 */
@property (nonatomic, assign) NSInteger water_and_internet_deduction;
/**
 违反站内管理扣款
 */
@property (nonatomic, assign) NSInteger violation_station_admin_deduction;
/**
 意外险扣款
 */
@property (nonatomic, assign) NSInteger accident_deduction;
/**
 社保代缴扣款(单位承担)
 */
@property (nonatomic, assign) NSInteger social_security_deduction;
/**
 电动车扣款
 */
@property (nonatomic, assign) NSInteger electric_vehicle_deduction;
/**
 装备扣款
 */
@property (nonatomic, assign) NSInteger equipment_deduction;
/**
 装备押金扣款
 */
@property (nonatomic, assign) NSInteger equipment_deposit_deduction;
/**
 其他扣款
 */
@property (nonatomic, assign) NSInteger order_deduction;
/**
 物资扣款
 */
@property (nonatomic, assign) NSInteger material_deduction;
/**
 实扣物资扣款
 */
@property (nonatomic, assign) NSInteger real_material_deduction;
/**
 实扣物资保证金总额
 */
@property (nonatomic, assign) NSInteger real_material_deposit_deduction;
/**
 应发工资
 */
@property (nonatomic, assign) NSInteger payable_money;
/**
 人事扣款
 */
@property (nonatomic, strong) NSArray <MoneyDetailItemModel *>*adjustment_hr_dec_money;
/**
 实扣装备扣款
 */
@property (nonatomic, assign) NSInteger real_equipment_deduction;
/**
 实扣三方扣款
 */
//@property (nonatomic, assign) NSInteger adjustment_hr_dec_money;

/**
 实扣装备保证金
 */
@property (nonatomic, assign) NSInteger real_equipment_cash_deposit;

/**
 实扣跨行扣款
 */
@property (nonatomic, assign) NSInteger real_inter_bank_cost;

/**
 实发工资
 */
@property (nonatomic, assign) NSInteger net_pay_money;

@end

NS_ASSUME_NONNULL_END
