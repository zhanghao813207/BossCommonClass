//
//  SalaryModel.h
//  BossCommonClass
//
//  Created by 贾远潮 on 2018/8/12.
//

#import <Foundation/Foundation.h>


@interface SalaryModel : NSObject

/**
 薪资发放状态
 */
@property (nonatomic, assign) NSInteger pay_salary_state;

/**
 完成单量（单）
 */
@property (nonatomic, assign) CGFloat order_count;

/**
 职位id
 */
@property (nonatomic, assign) NSInteger position_id;

/**
 离职日期
 */
@property (nonatomic, strong) NSString *departure_date;

/**
 供应商name
 */
@property (nonatomic, strong) NSString *supplier_name;

/**
 联系方式
 */
@property (nonatomic, strong) NSString *phone;

/**
 月份
 */
@property (nonatomic, strong) NSString *month;

/**
 开户行支行
 */
@property (nonatomic, strong) NSString *bank_branch;

/**
 商圈名称
 */
@property (nonatomic, strong) NSString *biz_district_name;

/**
 准时单量（单）
 */
@property (nonatomic, assign) CGFloat time_limit_complete_order_count;

/**
 三方扣款
 */
@property (nonatomic, assign) CGFloat real_three_sides_deduction_amount ;

/**
 应聘渠道id
 */
@property (nonatomic, assign) NSInteger recruitment_channel_id;

/**
 在职状态id
 */
@property (nonatomic, assign) NSInteger work_state;

/**
 审核日期
 */
@property (nonatomic, strong) NSString *audit_date;

/**
 合同归属
 */
@property (nonatomic, strong) NSString *contract_belong;

/**
 指标列表
 */
@property (nonatomic, strong) NSArray *specification_list;

/**
 银行卡号
 */
@property (nonatomic, strong) NSString *bank_card_id;

/**
 跨行费用
 */
@property (nonatomic, assign) CGFloat real_inter_bank_transfer_amount;


/**
 入职日期
 */
@property (nonatomic, strong) NSString *entry_date;

/**
 出单天数
 */
@property (nonatomic, assign) NSInteger issue_days;

/**
 起始日期
 */
@property (nonatomic, strong) NSString *start_date;

/**
 薪资发放状态 ???????
 */
@property (nonatomic, strong) NSString *update_time;

/**
 超时单量（单）
 */
@property (nonatomic, assign) CGFloat timeout_order_count;

/**
 审核状态
 */
@property (nonatomic, assign) NSInteger audit_state;

/**
 实发工资
 */
@property (nonatomic, assign) CGFloat actual_pay_salary_amount;

/**
 骑士补款
 */
@property (nonatomic, assign) CGFloat knight_payment_amount;

/**
 装备扣款
 */
@property (nonatomic, assign) CGFloat real_equipment_deduction_amount;

/**
 骑士类型id
 */
@property (nonatomic, strong) NSString *knight_type_id;

/**
 装备保证金
 */
@property (nonatomic, assign) CGFloat real_equipmen_cash_deposit_amount;

/**
 应发工资
 */
@property (nonatomic, assign) CGFloat real_pay_salary_amount;

/**
 供应商id
 */
@property (nonatomic, strong) NSString *supplier_id;

/**
 物资扣款
 */
@property (nonatomic, assign) CGFloat material_deduction_amount;


/**
 日期
 */
@property (nonatomic, strong) NSString *date;

/**
 城市名称
 */
@property (nonatomic, strong) NSString *city_name_joint;

/**
 骑士类型
 */
@property (nonatomic, strong) NSString *knight_type_name;


/**
 id
 */
@property (nonatomic, strong) NSString *_id;

/**
 员工姓名
 */
@property (nonatomic, strong) NSString *name;

/**
 开户行省市
 */
@property (nonatomic, strong) NSArray *bank_location;

/**
 人效（单/人日）
 */
@property (nonatomic, assign) CGFloat efficiency;

/**
 上次离职日期
 */
@property (nonatomic, strong) NSString *last_departure_date;

/**
 身份证号
 */
@property (nonatomic, strong) NSString *identity_card_id;

/**
 平台名称
 */
@property (nonatomic, strong) NSString *platform_name;

/**
 薪资模板id
 */
@property (nonatomic, strong) NSString *salary_template_id;

/**
 有效出勤（天）
 */
@property (nonatomic, assign) CGFloat valid_attendance_days;

/**
 骑士扣款
 */
@property (nonatomic, assign) CGFloat knight_deduction_amount;

@end
