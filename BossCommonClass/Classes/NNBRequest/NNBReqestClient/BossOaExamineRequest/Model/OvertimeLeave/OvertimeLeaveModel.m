//
//  LoanOrderModel.m
//  BossCommonClass
//
//  Created by 张浩 on 2019/6/18.
//

#import "OvertimeLeaveModel.h"

@implementation OvertimeLeaveModel

- (void)setValue:(id)value forKey:(NSString *)key
{
    if (!value || value == [NSNull null]) {
        return;
    }
    
    if ([key isEqualToString:@"actual_loan_info"]) {
        ActualLoanModel *model = [[ActualLoanModel alloc] init];
        [model setValuesForKeysWithDictionary:value];
        self.actual_loan_info = model;
        return;
    }
    
    if ([key isEqualToString:@"payee_account_info"]) {
        PayeeAccountModel *model = [[PayeeAccountModel alloc] init];
        [model setValuesForKeysWithDictionary:value];
        self.payee_account_info = model;
        return;
    }
    
    [super setValue:value forKey:key];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

#pragma mark - setter/getter

- (NSString *)loanTypeStr{
    NSString *loanTypeStr = @"";
    switch (self.loan_type) {
        case LoanTypeOrdinary:
            loanTypeStr = @"普通借款";
            break;
        case LoanTypeSpecial:
            loanTypeStr = @"专项借款";
            break;
        default:
            break;
    }
    return loanTypeStr;
}

- (NSString *)loanMoneyStr{
    return [NSString stringWithFormat:@"￥%.2f",self.loan_money / 100.0];
}

- (NSString *)belongStr{
    NSString *belongStr = [NSString stringWithFormat:@"%@-%@-%@", self.platform_name, self.supplier_name, self.city_name];
    if(self.biz_district_name && self.biz_district_name.length > 0){
        belongStr = [NSString stringWithFormat:@"%@-%@", belongStr, self.biz_district_name];
    }
    return belongStr;
}

- (NSString *)repaymentMethodStr {
    NSString *repaymentMethodStr = @"";
    switch (self.repayment_method) {
        case RepaymentMethodCurrency:
            repaymentMethodStr = @"货币";
            break;
        default:
            break;
    }
    return repaymentMethodStr;
}

- (NSString *)repaymentCycleStr {
    NSString *repaymentCycleStr = @"";
    switch (self.repayment_cycle) {
        case RepaymentCycleOneTime:
            repaymentCycleStr = @"一次还";
            break;
        case RepaymentCycleInstalment:
            repaymentCycleStr = @"分期还";
            break;
        default:
            break;
    }
    return repaymentCycleStr;
}

@end
