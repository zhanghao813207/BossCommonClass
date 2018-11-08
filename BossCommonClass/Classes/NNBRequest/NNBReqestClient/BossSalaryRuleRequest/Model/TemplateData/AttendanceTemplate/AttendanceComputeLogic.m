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

@end
