//
//  PayrollStatementDetailModel.m
//  AFNetworking
//
//  Created by 贾远潮 on 2018/11/5.
//

#import "PayrollStatementDetailModel.h"

@implementation PayrollStatementDetailModel

- (void)setValue:(id)value forKey:(NSString *)key
{
    if (!value || value == [NSNull null]) {
        return;
    }
    
    if ([key isEqualToString:@"salary_data"]) {
        SalaryDataModel *model = [[SalaryDataModel alloc] init];
        [model setValuesForKeysWithDictionary:value];
        self.salary_data = model;
        return;
    }
    
    if ([key isEqualToString:@"staff_info"]) {
        StaffInfoModel *model = [[StaffInfoModel alloc] init];
        [model setValuesForKeysWithDictionary:value];
        self.staff_info = model;
        return;
    }
    
    [super setValue:value forKey:key];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}


@end
