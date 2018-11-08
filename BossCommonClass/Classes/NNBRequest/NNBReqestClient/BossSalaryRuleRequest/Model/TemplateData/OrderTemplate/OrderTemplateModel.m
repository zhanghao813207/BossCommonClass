//
//  OrderTemplateModel.m
//  AFNetworking
//
//  Created by 贾远潮 on 2018/11/6.
//

#import "OrderTemplateModel.h"

@implementation OrderTemplateModel

- (void)setValue:(id)value forKey:(NSString *)key
{
    if (!value || value == [NSNull null]) {
        return;
    }
    
    if ([key isEqualToString:@"match_filters"]) {
        OrderMatchFilters *model = [[OrderMatchFilters alloc] init];
        [model setValuesForKeysWithDictionary:value];
        self.match_filters = model;
        return;
    }
    
    if ([key isEqualToString:@"compute_logic"]) {
        OrderComputeLogic *model = [[OrderComputeLogic alloc] init];
        [model setValuesForKeysWithDictionary:value];
        self.compute_logic = model;
        return;
    }

    
    [super setValue:value forKey:key];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}


@end
