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

@end
