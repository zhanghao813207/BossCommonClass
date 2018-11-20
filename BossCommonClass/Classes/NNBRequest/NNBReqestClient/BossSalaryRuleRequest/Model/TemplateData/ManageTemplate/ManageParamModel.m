//
//  ManageParamModel.m
//  AFNetworking
//
//  Created by 贾远潮 on 2018/11/7.
//

#import "ManageParamModel.h"

@implementation ManageParamModel
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

- (NSString *)logicString
{
    if (!_logicString) {
        if ([self.unit_day isEqualToString:@"attendance_days"]) {
            _logicString = [NSString stringWithFormat:@"出勤天数*%ld",self.unit_money];
        } else {
            _logicString = [NSString stringWithFormat:@"在职天数*%ld",self.unit_money];
        }
    }
    return _logicString;

}

@end
