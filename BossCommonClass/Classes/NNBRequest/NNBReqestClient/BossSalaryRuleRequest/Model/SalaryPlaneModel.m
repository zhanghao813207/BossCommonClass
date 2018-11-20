//
//  SalaryPlaneModel.m
//  AFNetworking
//
//  Created by 贾远潮 on 2018/11/6.
//

#import "SalaryPlaneModel.h"
#import "NSDate+Helper.h"
@implementation SalaryPlaneModel

- (void)setValue:(id)value forKey:(NSString *)key
{
    if (!value || value == [NSNull null]) {
        return;
    }
    
    if ([key isEqualToString:@"compute_data_set"]) {
        ComputeDatasetInfoModel *model = [[ComputeDatasetInfoModel alloc] init];
        if ([value isKindOfClass:[NSArray class]]) {
            [model setValuesForKeysWithDictionary:value[0]];
        } else if([value isKindOfClass:[NSDictionary class]]){
            [model setValuesForKeysWithDictionary:value];
        }
        self.compute_data_set = model;
        return;
    }
    
    if ([key isEqualToString:@"compute_task_info"]) {
        SalaryComputeDatasetModel *model = [[SalaryComputeDatasetModel alloc] init];
        [model setValuesForKeysWithDictionary:value];
        self.compute_task_info = model;
        return;
    }
    if ([key isEqualToString:@"rules_list"]) {
        NSMutableArray *array = [NSMutableArray array];
        for (NSDictionary *dic in value) {
            TemplateRuleModel *model = [[TemplateRuleModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [array addObject:model];
        }
        self.rules_list = [array copy];
        return;
    }
    
    if ([key isEqualToString:@"from_date"]) {
        NSString *fromDate = [NSString stringWithFormat:@"%@",value];
        NSDate *computeData = [NSDate dateFromString:fromDate withFormat:@"yyyyMMdd"];
        NSString *fromDateString = [NSDate stringFromDate:computeData withFormat:@"yyyy年MM月dd日"];
        self.from_date = fromDateString;
        return;
    }
    if ([key isEqualToString:@"to_date"]) {
        NSString *fromDate = [NSString stringWithFormat:@"%@",value];
        NSDate *computeData = [NSDate dateFromString:fromDate withFormat:@"yyyyMMdd"];
        NSString *fromDateString = [NSDate stringFromDate:computeData withFormat:@"yyyy年MM月dd日"];
        self.to_date = fromDateString;
        return;
    }

    [super setValue:value forKey:key];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

- (NSString *)computeMonth
{
    if (!_computeMonth) {
        NSDate *computeData = [NSDate dateFromString:self.to_date withFormat:@"yyyy年MM月dd日"];
        _computeMonth = [NSDate stringFromDate:computeData withFormat:@"M"];
    }
    return _computeMonth;

}

@end
