//
//  QualityMatchFilter.m
//  AFNetworking
//
//  Created by 贾远潮 on 2018/11/6.
//

#import "QualityMatchFilter.h"
#import "OrderVarModel.h"
@implementation QualityMatchFilter

- (void)setValue:(id)value forKey:(NSString *)key
{
    if (!value || value == [NSNull null]) {
        return;
    }
    
    if ([key isEqualToString:@"order_vars"]) {
        OrderVarModel *model = [[OrderVarModel alloc] init];
        [model setValuesForKeysWithDictionary:value];
        self.order_vars = model;
        return;
    }
    
    [super setValue:value forKey:key];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

- (NSString *)statistics_time_type_string
{
    switch (self.statistics_time_type) {
        case 1:
        {
            _statistics_time_type_string = @"按天";
        }
            break;
        case 2:
        {
            _statistics_time_type_string = @"按月";
        }
            break;
        default:
            _statistics_time_type_string = @"未知";
            break;
    }
    return _statistics_time_type_string;
}

- (NSString *)sort_scope_string
{
    switch (self.sort_scope) {
        case 1:
            {
            _sort_scope_string = @"本商圈";
            }
            break;
        case 2:
        {
            _sort_scope_string = @"本城市";
        }
            break;
        default:
            _sort_scope_string = @"无";
            break;
    }
    return _sort_scope_string;
}

- (NSString *)sort_index_type_string
{
    switch (self.sort_index_type) {
        case 1:
            {
            _sort_index_type_string = @"从小到大";
            }
            break;
        case 2:
        {
            _sort_index_type_string = @"从大到小";
        }
            break;
        default:
            _sort_index_type_string = @"未知";
            break;
    }
    return _sort_index_type_string;
}

@end
