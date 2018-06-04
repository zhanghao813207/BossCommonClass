//
//  CityModel.m
//  Pods-BossKnight
//
//  Created by 贾远潮 on 2018/5/23.
//

#import "CityModel.h"

@implementation CityModel

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

- (NSDictionary *)decodeToDic
{
    NSDictionary *localDic = @{
                               @"city_name":self.city_name ? : @"",
                               @"city":self.city ? : @"",
                               @"city_spelling":self.city_spelling ? : @"",
                               @"city_name_joint":self.city_name_joint ? : @"",
                               };
    return localDic;
}


@end
