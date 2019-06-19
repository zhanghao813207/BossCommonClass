//
//  RepaymentOrderModel.h
//  BossCommonClass
//
//  Created by 张浩 on 2019/6/19.
//

#import <Foundation/Foundation.h>
#import "BossBasicDefine.h"
#import "LoanOrderModel.h"
#import "AccountModel.h"

NS_ASSUME_NONNULL_BEGIN

/**
 还款单Model
 */
@interface RepaymentOrderModel : NSObject

/**
 还款单ID
 */
@property (nonatomic, strong) NSString *_id;

/**
 借款单ID
 */
@property (nonatomic, strong) NSString *loan_order_id;

/**
 借款单信息
 */
@property (nonatomic, strong) LoanOrderModel *loan_order_info;

/**
 申请人ID
 */
@property (nonatomic, strong) NSString *apply_account_id;

/**
 申请人信息
 */
@property (nonatomic, strong) AccountModel *apply_account_info;

/**
 单据状态
 */
@property (nonatomic, assign) OrderState state;

/**
 还款金额(分)
 */
@property (nonatomic, assign) NSInteger repayment_money;

/**
 还款备注
 */
@property (nonatomic, strong) NSString *repayment_note;

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

#pragma mark - additional attribute

/**
 还款金额字符串
 */
@property (nonatomic, strong, readonly) NSString *repaymentMoneyStr;

/**
 借款金额字符串
 */
@property (nonatomic, strong, readonly) NSString *loanMoneyStr;

/**
 已还金额字符串
 */
@property (nonatomic, strong, readonly) NSString *repaymentMoneyByLoanStr;

/**
 未还款金额字符串
 */
@property (nonatomic, strong, readonly) NSString *nonRepaymentMoneyStr;

/**
 还款备注
 */
@property (nonatomic, strong, readonly) NSString *repaymentNoteStr;

@end

NS_ASSUME_NONNULL_END
