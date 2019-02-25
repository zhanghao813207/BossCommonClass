//
//  MerchantBriefModel.m
//  AFNetworking
//
//  Created by 张浩 on 2019/2/18.
//

#import "MerchantBriefModel.h"

@implementation MerchantBriefModel

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

/**
 模型转字典
 
 @return 字典
 */
- (NSDictionary *)decodeToDic
{
    NSDictionary *dic = @{
                                @"_id":self._id ? : @"",
                                @"merchant_code":self.merchant_code ? : @"",
                                @"name":self.name ? : @"",
                                @"api_gateway":self.api_gateway ? : @"",
                                @"state":@(self.state),
                                @"created_at":self.created_at ? : @""
                          };
    return dic;
}

@end
