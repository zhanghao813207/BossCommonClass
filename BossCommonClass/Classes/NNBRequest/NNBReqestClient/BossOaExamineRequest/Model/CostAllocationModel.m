//
//  CostAllocationModel.m
//  AFNetworking
//
//  Created by 贾远潮 on 2018/8/24.
//

#import "CostAllocationModel.h"
#import "BossBasicDefine.h"
@implementation CostAllocationModel

- (void)setValue:(id)value forKey:(NSString *)key
{
    if (!value || value == [NSNull null]) {
        return;
    }
    
    [super setValue:value forKey:key];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

- (NSString *)allocationString
{
    if (!_allocationString) {
//        归属信息都显示 且顺序为平台—供应商—城市—商圈
        NSMutableArray *array = [NSMutableArray array];
      
        if (![JYCSimpleToolClass stringIsEmpty:self.platform_name]) {
            [array addObject:self.platform_name];
        }
        if (![JYCSimpleToolClass stringIsEmpty:self.supplier_name]) {
            [array addObject:self.supplier_name];
        }
        if (![JYCSimpleToolClass stringIsEmpty:self.city_name]) {
            [array addObject:self.city_name];
        }
        if (![JYCSimpleToolClass stringIsEmpty:self.biz_district_name]) {
            [array addObject:self.biz_district_name];
        }
        
        _allocationString = [NSString stringWithFormat:@"%@ ￥%.2f", [array componentsJoinedByString:@"-"],self.money / 100.0];
    }
    return _allocationString;

}

- (NSString *)teamAllocationString
{
    if (!_teamAllocationString) {
//        归属信息都显示 且顺序为平台—供应商—城市—商圈
        NSMutableArray *array = [NSMutableArray array];
      
        if (![JYCSimpleToolClass stringIsEmpty:self.platform_name]) {
            [array addObject:self.platform_name];
        }
        if (![JYCSimpleToolClass stringIsEmpty:self.supplier_name]) {
            [array addObject:self.supplier_name];
        }
        if (![JYCSimpleToolClass stringIsEmpty:self.city_name]) {
            [array addObject:self.city_name];
        }
        if (![JYCSimpleToolClass stringIsEmpty:self.biz_district_name]) {
            [array addObject:self.biz_district_name];
        }
        NSString *teamTypeString = [self getTeamTypeString:self.team_type];
        if (![JYCSimpleToolClass stringIsEmpty:teamTypeString]) {
            [array addObject:teamTypeString];
        }
        if (![JYCSimpleToolClass stringIsEmpty:self.team_name]) {
            [array addObject:self.team_name];
        }
//        if (![JYCSimpleToolClass stringIsEmpty:self.team_id]) {
//            [array addObject:self.team_id];
//        }
        
        _teamAllocationString = [NSString stringWithFormat:@"%@ ￥%.2f", [array componentsJoinedByString:@"-"],self.money / 100.0];
    }
    return _teamAllocationString;
}

- (NSString *)personAllocationString
{
    if (!_personAllocationString) {
//        归属信息都显示 且顺序为平台—供应商—城市—商圈
        NSMutableArray *array = [NSMutableArray array];
      
        if (![JYCSimpleToolClass stringIsEmpty:self.platform_name]) {
            [array addObject:self.platform_name];
        }
        if (![JYCSimpleToolClass stringIsEmpty:self.supplier_name]) {
            [array addObject:self.supplier_name];
        }
        if (![JYCSimpleToolClass stringIsEmpty:self.city_name]) {
            [array addObject:self.city_name];
        }
        if (![JYCSimpleToolClass stringIsEmpty:self.biz_district_name]) {
            [array addObject:self.biz_district_name];
        }
        NSLog(@"个人信息:%@",self.staff_info);
        NSString *name = self.staff_info[@"name"];
        NSString *identityCardId = self.staff_info[@"identity_card_id"];

        if (![JYCSimpleToolClass stringIsEmpty:name]) {
            [array addObject:name];
        }
        if (![JYCSimpleToolClass stringIsEmpty:identityCardId]) {
            [array addObject:identityCardId];
        }

        _personAllocationString = [NSString stringWithFormat:@"%@ ￥%.2f", [array componentsJoinedByString:@"-"],self.money / 100.0];
    }
    return _personAllocationString;
}

- (NSString *)getTeamTypeString:(TeamType)type {
    switch (type) {
        case TEAM_TYPE_OWNER_TEAM:
            return @"业主小队";
            break;
        case TEAM_TYPE_COACH_TEAM:
            return @"私教小队";
            break;
        case TEAM_TYPE_COACH_GROUP_TEAM:
            return @"私教团队";
            break;
        case TEAM_TYPE_COMPANY_TEAM:
            return @"业务赋能小队";
            break;
        case TEAM_TYPE_DATA_TEAM:
            return @"数据小队";
            break;
        case TEAM_TYPE_OPERATION_TEAM:
            return @"运维小队";
            break;
        case TEAM_TYPE_BUSINESS_TEAM:
            return @"商务小队";
            break;
        
        default:
            return @"";
            break;
    }
    
}
@end
