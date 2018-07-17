//
//  BizDistrictModel.m
//  AFNetworking
//
//  Created by 贾远潮 on 2018/7/17.
//

#import "BizDistrictModel.h"

@implementation BizDistrictModel

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
                               @"biz_district_id":self.biz_district_id ? : @"",
                               @"biz_district_name":self.biz_district_name ? : @"",
                               };
    return localDic;
}

@end
