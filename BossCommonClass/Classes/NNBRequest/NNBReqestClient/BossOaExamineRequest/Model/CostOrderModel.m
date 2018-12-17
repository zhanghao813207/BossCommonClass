//
//  CostOrderModel.m
//  AFNetworking
//
//  Created by 贾远潮 on 2018/8/24.
//

#import "CostOrderModel.h"
#import "NSDate+Helper.h"

@interface CostOrderModel()

/**
 费用分摊方式 字符串
 */
@property (nonatomic, strong) NSString *allocation_name;

@end

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
    
    if ([key isEqualToString:@"submit_at"]) {
        NSString *normalTime = [JYCSimpleToolClass fastChangeToNormalTimeWithString:value];
        self.submit_at = normalTime;
        
        NSDate *date = [NSDate dateFromString:normalTime withFormat:@"yyyy-MM-dd HH:mm:ss"];
        
        self.submit_at_int = [date stringWithFormat:@"yyyyMM"];
        return;
    }

    [super setValue:value forKey:key];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

- (NSString *)allocation_name
{
    switch (self.allocation_mode) {
        case ALLOCATION_MODE_BALANCE:
            _allocation_name = @"平均分摊";
            break;
        case ALLOCATION_MODE_CUSTOM:
            _allocation_name = @"自定义分摊";
            break;
        default:
            _allocation_name = @"未知";
            break;
    }
    return _allocation_name;
}

@end
