//
//  SalaryComputeDatasetModel.m
//  AFNetworking
//
//  Created by 贾远潮 on 2018/11/7.
//

#import "SalaryComputeDatasetModel.h"

@implementation SalaryComputeDatasetModel
- (void)setValue:(id)value forKey:(NSString *)key
{
    if (!value || value == [NSNull null]) {
        return;
    }
    
    if ([key isEqualToString:@"data"]) {
        ComputeDatasetInfoModel *model = [[ComputeDatasetInfoModel alloc] init];
        [model setValuesForKeysWithDictionary:value];
        self.data = model;
        return;
    }
        
    [super setValue:value forKey:key];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if (!value || value == [NSNull null]) {
        return;
    }
    DLog(@"undefineKey %@ %@", key, value);
}

@end
