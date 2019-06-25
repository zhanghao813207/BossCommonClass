//
//  RepaymentOrderModel.m
//  BossCommonClass
//
//  Created by 张浩 on 2019/6/19.
//

#import "RepaymentOrderModel.h"

@implementation RepaymentOrderModel

- (void)setValue:(id)value forKey:(NSString *)key
{
    if (!value || value == [NSNull null]) {
        return;
    }
    
    if ([key isEqualToString:@"loan_order_info"]) {
        LoanOrderModel *model = [[LoanOrderModel alloc] init];
        [model setValuesForKeysWithDictionary:value];
        self.loan_order_info = model;
        return;
    }
    
    if ([key isEqualToString:@"apply_account_info"]) {
        AccountModel *model = [[AccountModel alloc] init];
        [model setValuesForKeysWithDictionary:value];
        self.apply_account_info = model;
        return;
    }
    
    [super setValue:value forKey:key];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

- (NSString *)repaymentMoneyStr{
    return [NSString stringWithFormat:@"￥%.2f",self.repayment_money / 100.0];
}

- (NSString *)loanMoneyStr{
    return self.loan_order_info.loanMoneyStr;
}

- (NSString *)repaymentMoneyByLoanStr{
    return [NSString stringWithFormat:@"￥%.2f",self.loan_order_info.repayment_money / 100.0];
}

- (NSString *)nonRepaymentMoneyStr{
    return [NSString stringWithFormat:@"￥%.2f",self.loan_order_info.non_repayment_money / 100.0];
}

- (NSString *)repaymentNoteStr{
    return self.repayment_note && self.repayment_note.length > 0 ? self.repayment_note : @"无";
}

@end
