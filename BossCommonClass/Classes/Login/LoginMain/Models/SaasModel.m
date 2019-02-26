//
//  SaasModel.m
//  AFNetworking
//
//  Created by 张浩 on 2019/2/18.
//

#import "SaasModel.h"

@implementation SaasModel

- (void)setValue:(id)value forKey:(NSString *)key
{
    if (!value || value == [NSNull null]) {
        return;
    }
    
    if ([key isEqualToString:@"merchant_info"]) {
        MerchantBriefModel *model = [[MerchantBriefModel alloc] init];
        [model setValuesForKeysWithDictionary:value];
        self.merchant_info = model;
        return;
    }
    
    [super setValue:value forKey:key];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

- (NSString *)url
{
    if(_merchant_info){
        return _merchant_info.api_gateway;
    }
    return @"";
}

- (NSDictionary *)decodeToDic
{
    NSDictionary *dic = @{
                          @"_id":self._id ? : @"",
                          @"access_key":self.access_key ? : @"",
                          @"secret_key":self.secret_key ? : @"",
                          @"merchant_id":self.merchant_id ? : @"",
                          @"merchant_info":self.merchant_info ? [self.merchant_info decodeToDic] : @{},
                          @"accountList":self.accountList ? : [NSMutableArray array]
                          };
    
    return dic;
}

@end
