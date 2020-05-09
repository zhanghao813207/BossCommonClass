//
//  CityModel.m
//  Pods-BossKnight
//
//  Created by 贾远潮 on 2018/5/23.
//

#import "CityModel.h"
#import "JYCSimpleToolClass.h"
@implementation CityModel

- (void)setValue:(id)value forKey:(NSString *)key
{
    if (!value || value == [NSNull null]) {
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
    
    [super setValue:value forKey:key];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

- (NSDictionary *)decodeToDic
{
    NSDictionary *localDic = @{
                               @"biz_district_list":[JYCSimpleToolClass encodeArrayToArray:self.biz_district_list],
                               @"city_name":self.city_name ? : @"",
                               @"city":self.city ? : @"",
                               @"city_spelling":self.city_spelling ? : @"",
                               @"city_name_joint":self.city_name_joint ? : @"",
                               };
    return localDic;
}

@end
