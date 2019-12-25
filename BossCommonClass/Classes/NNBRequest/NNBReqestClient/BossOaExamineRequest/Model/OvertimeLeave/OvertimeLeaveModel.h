//
//  LoanOrderModel.h
//  BossCommonClass
//
//  Created by 张浩 on 2019/6/18.
//

#import <Foundation/Foundation.h>
#import "BossBasicDefine.h"
#import "ActualLoanModel.h"
#import "PayeeAccountModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface OvertimeLeaveModel : NSObject
//请假/加班标题 （实际请假/加班人）
@property (nonatomic, assign) NSString *titleString;

/**
 借款单ID
 */
@property (nonatomic, strong) NSString *_id;

/**
 借款类型
 */
@property (nonatomic, assign) LoanType loan_type;

/**
 单据状态
 */
@property (nonatomic, assign) OrderState state;

/**
 打款状态
 */
@property (nonatomic, assign) PAY_STATE paid_state;

/**
 打款备注
 */
@property (nonatomic, strong) NSString *paid_note;

/**
 备注
 */
@property (nonatomic, strong) NSString *note;

/**
 平台Code
 */
@property (nonatomic, strong) NSString *platform_code;

/**
 平台名称
 */
@property (nonatomic, strong) NSString *platform_name;

/**
 供应商ID
 */
@property (nonatomic, strong) NSString *supplier_id;

/**
 供应商名称
 */
@property (nonatomic, strong) NSString *supplier_name;

/**
 城市Code
 */
@property (nonatomic, strong) NSString *city_code;

/**
 城市名称
 */
@property (nonatomic, strong) NSString *city_name;

/**
 商圈ID
 */
@property (nonatomic, strong) NSString *biz_district_id;

/**
 商圈名称
 */
@property (nonatomic, strong) NSString *biz_district_name;

/**
 实际借款人信息
 */
@property (nonatomic, strong) ActualLoanModel *actual_loan_info;

/**
 收款人账户信息
 */
@property (nonatomic, strong) PayeeAccountModel *payee_account_info;

/**
 借款金额(分)
 */
@property (nonatomic, assign) NSInteger loan_money;

/**
 借款事由
 */
@property (nonatomic, strong) NSString *loan_note;

/**
 还款状态
 */
@property (nonatomic, assign) RepaymentState repayment_state;

/**
 已还款金额(分)
 */
@property (nonatomic, assign) NSInteger repayment_money;

/**
 未还款金额(分)
 */
@property (nonatomic, assign) NSInteger non_repayment_money;

/**
 待还款金额(分)
 */
@property (nonatomic, assign) NSInteger wait_repayment_money;

/**
 还款方式
 */
@property (nonatomic, assign) RepaymentMethod repayment_method;

/**
 还款周期
 */
@property (nonatomic, assign) RepaymentCycle repayment_cycle;

/**
 预计还款时间 20201023
 */
@property (nonatomic, strong) NSString *expected_repayment_time;

/**
 创建时间
 */
@property (nonatomic, strong) NSString *created_at;

/**
 更新时间
 */
@property (nonatomic, strong) NSString *updated_at;

/**
 提交时间
 */
@property (nonatomic, strong) NSString *submit_at;

/**
 完成时间
 */
@property (nonatomic, strong) NSString *done_at;

/**
 关闭时间
 */
@property (nonatomic, strong) NSString *closed_at;

/**
 付款时间
 */
@property (nonatomic, strong) NSString *paid_at;

#pragma mark - additional attribute

/**
 借款类型字符串
 */
@property (nonatomic, strong, readonly) NSString *loanTypeStr;

/**
 金额字符串
 */
@property (nonatomic, strong, readonly) NSString *loanMoneyStr;

/**
 归属字符串
 */
@property (nonatomic, strong, readonly) NSString *belongStr;

/**
 还款方式字符串
 */
@property (nonatomic, strong, readonly) NSString *repaymentMethodStr;

/**
 还款周期字符串
 */
@property (nonatomic, strong, readonly) NSString *repaymentCycleStr;

@end

NS_ASSUME_NONNULL_END
