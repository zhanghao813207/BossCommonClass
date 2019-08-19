//
//  PayrollStatementModel.m
//  BossCommonClass
//
//  Created by 贾远潮 on 2018/11/5.
//

#import "PayrollStatementModel.h"

@implementation PayrollStatementModel

- (void)setValue:(id)value forKey:(NSString *)key
{
    if (!value || value == [NSNull null]) {
        return;
    }
    
    [super setValue:value forKey:key];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

- (NSString *)workTypeString
{
    switch (self.work_type) {
            case STAFFWORKTYPEFULLTIME:
            _workTypeString = @"甲类";
            break;
            case STAFFWORKTYPEPARTTIME:
            _workTypeString = @"乙类";
            break;
        default:
            _workTypeString = @"未知";
            break;
    }
    return _workTypeString;
}

- (NSString *)payroll_cycle_string
{
    switch (self.payroll_cycle_type) {
            case PayrooCycleTypeMonth:
            _payroll_cycle_string = [NSString stringWithFormat:@"按月/%ld月",self.cycle_interval];
            break;
            case PayrooCycleTypeDay:
            _payroll_cycle_string = [NSString stringWithFormat:@"按日/%ld日",self.cycle_interval];
            break;
        default:
            _payroll_cycle_string = @"未知";
            break;
    }
    return _payroll_cycle_string;
}

@end
