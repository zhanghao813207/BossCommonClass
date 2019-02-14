//
//  ContractBelongModel.m
//  AFNetworking
//
//  Created by 张浩 on 2019/1/22.
//

#import "ContractBelongModel.h"

@implementation ContractBelongModel

- (void)setValue:(id)value forKey:(NSString *)key
{
    [super setValue:value forKey:key];
}

- (void)setValue:(id)value forUndefinedKey:(nonnull NSString *)key
{
    
}

/**
 模型转字典
 
 @return 字典
 */
- (NSDictionary *)decodeToDic
{
    NSDictionary *localDic = @{
                                          @"_id":self._id ? : @"",
                                          @"name":self.name ? : @"",
                                          @"legal_person":self.legal_person ? : @"",
                                          @"address":self.address ? : @"",
                                          @"state":self.state,
                                          @"is_electronic_sign":[NSNumber numberWithBool:self.is_electronic_sign]
                                          };
    return localDic;
}

@end
