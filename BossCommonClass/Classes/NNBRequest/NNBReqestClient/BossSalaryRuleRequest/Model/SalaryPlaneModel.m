//
//  SalaryPlaneModel.m
//  AFNetworking
//
//  Created by 贾远潮 on 2018/11/6.
//

#import "SalaryPlaneModel.h"

@implementation SalaryPlaneModel

- (void)setValue:(id)value forKey:(NSString *)key
{
    if (!value || value == [NSNull null]) {
        return;
    }
    
    if ([key isEqualToString:@"compute_dataset_info"]) {
        ComputeDatasetInfoModel *model = [[ComputeDatasetInfoModel alloc] init];
        [model setValuesForKeysWithDictionary:value];
        self.compute_dataset_info = model;
        return;
    }
    
    if ([key isEqualToString:@"knight_info"]) {
        KnightInfoModel *model = [[KnightInfoModel alloc] init];
        [model setValuesForKeysWithDictionary:value];
        self.knight_info = model;
        return;
    }
    
    [super setValue:value forKey:key];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}


@end
