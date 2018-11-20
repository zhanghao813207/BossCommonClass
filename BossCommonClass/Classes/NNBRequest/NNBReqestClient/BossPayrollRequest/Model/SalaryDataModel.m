//
//  SalaryDataModel.m
//  AFNetworking
//
//  Created by 贾远潮 on 2018/11/5.
//

#import "SalaryDataModel.h"

@implementation SalaryDataModel

- (void)setValue:(id)value forKey:(NSString *)key
{
    if (!value || value == [NSNull null]) {
        return;
    }
    
    if ([key isEqualToString:@"knight_payment"]) {
        NSMutableArray *array = [NSMutableArray array];
        for (NSDictionary *dic in value) {
            MoneyDetailItemModel *model = [[MoneyDetailItemModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [array addObject:model];
        }
        self.knight_payment = [array copy];
        return;
    }
    
    if ([key isEqualToString:@"knight_deduction"]) {
        NSMutableArray *array = [NSMutableArray array];
        for (NSDictionary *dic in value) {
            MoneyDetailItemModel *model = [[MoneyDetailItemModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [array addObject:model];
        }
        self.knight_deduction = [array copy];
        return;
    }

    if ([key isEqualToString:@"adjustment_hr_dec_money"]) {
        NSMutableArray *array = [NSMutableArray array];
        for (NSDictionary *dic in value) {
            MoneyDetailItemModel *model = [[MoneyDetailItemModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [array addObject:model];
        }
        self.adjustment_hr_dec_money = [array copy];
        return;
    }

    [super setValue:value forKey:key];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}


@end
