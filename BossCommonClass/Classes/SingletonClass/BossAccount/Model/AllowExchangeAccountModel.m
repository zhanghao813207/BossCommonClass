//
//  AllowExchangeAccountModel.m
//  AFNetworking
//
//  Created by 贾远潮 on 2018/7/17.
//

#import "AllowExchangeAccountModel.h"

@implementation AllowExchangeAccountModel

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
    NSDictionary *localAccountInfoDic = @{
                                          @"account_id":self.account_id ? : @"",
                                          @"position_name":self.position_name ? : @"",
                                          @"name":self.name ? : @"",
                                          
                                          
                                          @"supplier_list":self.supplier_list ? : @[],
                                          @"supplier_name_list":self.supplier_name_list ? : @[],
                                          };
    return localAccountInfoDic;
}



@end
