//
//  QuaComputeLogic.m
//  AFNetworking
//
//  Created by 贾远潮 on 2018/11/6.
//

#import "QuaComputeLogic.h"

@implementation QuaComputeLogic

- (void)setValue:(id)value forKey:(NSString *)key
{
    if (!value || value == [NSNull null]) {
        return;
    }
    
    if ([key isEqualToString:@"range_params"]) {
        RangeParamModel *model = [[RangeParamModel alloc] init];
        [model setValuesForKeysWithDictionary:value];
        self.range_params = model;
        return;
    }
    
    if ([key isEqualToString:@"multiple_params"]) {
        NSMutableArray *array = [NSMutableArray array];
        for (NSDictionary *dic in value) {
            MultipleParamModel *model = [[MultipleParamModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [array addObject:model];
        }
        self.multiple_params = [array copy];
        return;
    }
    
    if ([key isEqualToString:@"battle_params"]) {
        BattleParamModel *model = [[BattleParamModel alloc] init];
        [model setValuesForKeysWithDictionary:value];
        self.battle_params = model;
        return;
    }
    
    [super setValue:value forKey:key];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}


@end
