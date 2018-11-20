//
//  AttendanceComputeLogic.m
//  AFNetworking
//
//  Created by 贾远潮 on 2018/11/6.
//

#import "AttendanceComputeLogic.h"

@implementation AttendanceComputeLogic

- (void)setValue:(id)value forKey:(NSString *)key
{
    if (!value || value == [NSNull null]) {
        return;
    }
    
    if ([key isEqualToString:@"by_once_params"]) {
        WorkLogicOnceParamModel *model = [[WorkLogicOnceParamModel alloc] init];
        [model setValuesForKeysWithDictionary:value];
        self.by_once_params = model;
        return;
    }

    if ([key isEqualToString:@"by_order_unit_params"]) {
        WorkLogicOrderUnitParamModel *model = [[WorkLogicOrderUnitParamModel alloc] init];
        [model setValuesForKeysWithDictionary:value];
        self.by_order_unit_params = model;
        return;
    }

    if ([key isEqualToString:@"by_salary_base_params"]) {
        WorkLogicSalaryBaseParamModel *model = [[WorkLogicSalaryBaseParamModel alloc] init];
        [model setValuesForKeysWithDictionary:value];
        self.by_salary_base_params = model;
        return;
    }

    
    [super setValue:value forKey:key];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

- (NSString *)subsidyString
{
    if (!_subsidyString) {
        NSString *string = @"";
        if ([self.biz_logic isEqualToString:@"work_logic_by_once"]) {
            if (self.by_once_params.auto_inc_option) {
                string = [NSString stringWithFormat:@"一次性补贴%ld元",self.by_once_params.once_money];
            }
            if (self.by_once_params.auto_dec_option) {
                string = [NSString stringWithFormat:@"。不满足%ld天，每%ld天扣%ld元",self.by_once_params.when_days,self.by_once_params.dec_unit_days,self.by_once_params.dec_unit_money];
            }
        } else if ([self.biz_logic isEqualToString:@"work_logic_by_order_unit"]){
            string = [NSString stringWithFormat:@"%@满足%ld单，每%ld单补%ld元",self.by_order_unit_params.orderUnitTypeString,self.by_order_unit_params.min_order_amount,self.by_order_unit_params.inc_unit_order,self.by_order_unit_params.inc_unit_money];
        } else {
            string = [NSString stringWithFormat:@"底薪%ld元",self.by_salary_base_params.salary_inc_money];
        }
        
        _subsidyString = string;
    }
    return _subsidyString;
}

@end
