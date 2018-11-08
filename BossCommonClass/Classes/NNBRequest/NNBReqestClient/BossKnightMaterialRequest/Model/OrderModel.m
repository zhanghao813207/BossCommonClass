//
//  OrderModel.m
//  Pods-BossKnight
//
//  Created by 贾远潮 on 2018/5/23.
//

#import "OrderModel.h"

@implementation OrderModel

- (void)setValue:(id)value forKey:(NSString *)key
{
    if (!value || value == [NSNull null]) {
        return;
    }
    
    if ([key isEqualToString:@"material_list"]) {
        NSMutableArray *array = [NSMutableArray array];
        for (NSDictionary *dic in value) {
            KnightMaterialModel *model = [[KnightMaterialModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [array addObject:model];
        }
        self.material_list = [array copy];
        return;
    }
    
    
    [super setValue:value forKey:key];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if (!value || value == [NSNull null]) {
        return;
    }
    
    if ([key isEqualToString:@"_id"]) {
        self.order_id = value;
        return;
    }
}


@end
