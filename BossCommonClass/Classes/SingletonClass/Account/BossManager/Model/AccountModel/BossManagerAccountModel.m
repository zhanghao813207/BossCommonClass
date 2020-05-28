//
//  BossManagerAccountModel.m
//  AFNetworking
//
//  Created by 张浩 on 2019/2/20.
//

#import "BossManagerAccountModel.h"

@implementation BossManagerAccountModel

- (void)setValue:(id)value forKey:(NSString *)key
{
    if (!value || value == [NSNull null]) {
        return;
    }
    
    if ([key isEqualToString:@"permission"]) {
        NSMutableArray *array = [NSMutableArray array];
        for (NSDictionary *dic in value) {
            PermissionModel *model = [[PermissionModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [array addObject:model];
        }
        self.permission = [array copy];
        return;
    }
    
    if ([key isEqualToString:@"supplier_list"]) {
        NSMutableArray *array = [NSMutableArray array];
        for (NSDictionary *dic in value) {
            SupplierModel *model = [[SupplierModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [array addObject:model];
        }
        self.supplier_list = [array copy];
        return;
    }
    
    if ([key isEqualToString:@"city_list"]) {
        NSMutableArray *array = [NSMutableArray array];
        for (NSDictionary *dic in value) {
            CityModel *model = [[CityModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [array addObject:model];
        }
        self.city_list = [array copy];
        return;
    }
    
    if ([key isEqualToString:@"platform_list"]) {
        NSMutableArray *array = [NSMutableArray array];
        for (NSDictionary *dic in value) {
            PlatformModel *model = [[PlatformModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [array addObject:model];
        }
        self.platform_list = [array copy];
        return;
    }
    
    if ([key isEqualToString:@"biz_district_list"]) {
        NSMutableArray *array = [NSMutableArray array];
        for (NSDictionary *dic in value) {
            BizDistrictModel *model = [[BizDistrictModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [array addObject:model];
        }
        self.biz_district_list = [array copy];
        return;
    }
//    if ([key isEqualToString:@"config"]) {
//        NSDictionary *dic = value;
//        self.configModel = [[configModel alloc] initWithDictionary:dic];
//        return;
//    }

    [super setValue:value forKey:key];
}

-(BOOL)safeAuth{
    NSString *safeKey = [NSString stringWithFormat:@"%@safeAuthAgree",self._id];
   return  [[NSUserDefaults standardUserDefaults] valueForKey:safeKey];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

/**
 模型转字典
 
 @return 字典
 */
- (NSDictionary *)decodeToDic
{
    NSDictionary *dic = @{
                                          @"state":@(self.state),
                                          @"position_id":@(self.position_id),
                                          @"gid":@(self.gid),
                                          
                                          @"phone":self.phone ? : @"",
                                          @"staff_id":self.staff_id ? : @"",
                                          @"name":self.name ? : @"",
                                          @"updated_at":self.updated_at ? : @"",
                                          @"operator_id":self.operator_id ? : @"",
                                          @"position_name":self.position_name ? : @"",
                                          @"created_at":self.created_at ? : @"",
                                          @"operator_name":self.operator_name ? : @"",
                                          @"_id":self._id ? : @"",
                               
                                          @"supplier_cascade_list":self.supplier_cascade_list ? : @[],
                                          @"city_cascade_list":self.city_cascade_list ? : @[],
                                          
                                          @"permission": [JYCSimpleToolClass encodeArrayToArray:self.permission],
                                          @"city_list": [JYCSimpleToolClass encodeArrayToArray:self.city_list],
                                          @"platform_list": [JYCSimpleToolClass encodeArrayToArray:self.platform_list],
                                          @"biz_district_list": [JYCSimpleToolClass encodeArrayToArray:self.biz_district_list],
                                          @"supplier_list": [JYCSimpleToolClass encodeArrayToArray:self.supplier_list]
                                          
                        };
    return dic;
}

@end
