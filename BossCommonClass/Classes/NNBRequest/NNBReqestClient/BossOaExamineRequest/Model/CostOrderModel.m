//
//  CostOrderModel.m
//  AFNetworking
//
//  Created by 贾远潮 on 2018/8/24.
//

#import "CostOrderModel.h"

@implementation CostOrderModel

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
    
    if ([key isEqualToString:@"cost_accounting_info"]) {
        CostAccountingModel *model = [[CostAccountingModel alloc] init];
        [model setValuesForKeysWithDictionary:value];
        self.cost_accounting_info = model;
        return;
    }
    
    if ([key isEqualToString:@"apply_account_info"]) {
        AccountModel *model = [[AccountModel alloc] init];
        [model setValuesForKeysWithDictionary:value];
        self.apply_account_info = model;
        return;
    }

    if ([key isEqualToString:@"biz_extra_house_contract_info"]) {
        OaHouseContractModel *model = [[OaHouseContractModel alloc] init];
        [model setValuesForKeysWithDictionary:value];
        self.biz_extra_house_contract_info = model;
        return;
    }
    
    if ([key isEqualToString:@"cost_allocation_list"]) {
        NSMutableArray *array = [NSMutableArray array];
        for (NSDictionary *dic in value) {
            CostAllocationModel *model = [[CostAllocationModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [array addObject:model];
        }
        self.cost_allocation_list = [array copy];
        return;
    }

    [super setValue:value forKey:key];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}


@end
