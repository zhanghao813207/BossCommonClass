//
//  ApplyOrderModel.m
//  AFNetworking
//
//  Created by 贾远潮 on 2018/8/9.
//

#import "ApplyOrderModel.h"

@implementation ApplyOrderModel

- (void)setValue:(id)value forKey:(NSString *)key
{
    if (!value || value == [NSNull null]) {
        return;
    }
    
    if ([key isEqualToString:@"payee_info"]) {
        PayeeInfoModel *model = [[PayeeInfoModel alloc] init];
        [model setValuesForKeysWithDictionary:value];
        self.payee_info = model;
        return;
    }
    
    if ([key isEqualToString:@"history_id_list"]) {
        NSMutableArray *array = [NSMutableArray array];
        for (NSDictionary *dic in value) {
            ApplyOrderModel *model = [[ApplyOrderModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [array addObject:model];
        }
        self.history_id_list = [array copy];
        return;
    }
    
    [super setValue:value forKey:key];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}


@end
