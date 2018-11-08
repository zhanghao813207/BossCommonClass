//
//  RangeParamModel.m
//  AFNetworking
//
//  Created by 贾远潮 on 2018/11/6.
//

#import "RangeParamModel.h"

@implementation RangeParamModel
- (void)setValue:(id)value forKey:(NSString *)key
{
    if (!value || value == [NSNull null]) {
        return;
    }
    
    if ([key isEqualToString:@"range_table"]) {
        NSMutableArray *array = [NSMutableArray array];
        for (NSDictionary *dic in value) {
            OrderRangeTableModel *model = [[OrderRangeTableModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [array addObject:model];
        }
        self.range_table = [array copy];
        return;
    }
    
    [super setValue:value forKey:key];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

@end
