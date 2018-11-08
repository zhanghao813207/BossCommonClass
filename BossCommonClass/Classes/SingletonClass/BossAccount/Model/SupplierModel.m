//
//  SupplierModel.m
//  AFNetworking
//
//  Created by 贾远潮 on 2018/8/8.
//

#import "SupplierModel.h"

@implementation SupplierModel

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
                               @"_id":self._id ? : @"",
                               @"name":self.name ? : @"",
                               };
    return localDic;
}


@end
