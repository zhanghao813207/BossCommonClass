//
//  TokenModel.m
//  AFNetworking
//
//  Created by 张浩 on 2019/2/20.
//

#import "TokenModel.h"

@implementation TokenModel

- (void)setValue:(id)value forKey:(NSString *)key
{
    [super setValue:value forKey:key];
}

- (void)setValue:(id)value forUndefinedKey:(nonnull NSString *)key
{
    
}

- (BOOL)checkExpired
{
    NSDate *currentDate = [NSDate date];
    NSTimeInterval timeInterval =  currentDate.timeIntervalSince1970;
    NSTimeInterval expired_at = [_expired_at doubleValue];
    NSLog(@"timeInterval = %f expired_at = %f", timeInterval, expired_at);
    return timeInterval >= expired_at ? YES : NO;
}

/**
 模型转字典
 
 @return 字典
 */
- (NSDictionary *)decodeToDic
{
    NSDictionary *dic = @{
                          @"account_id":self.account_id ? : @"",
                            @"access_token":self.access_token ? : @"",
                            @"refresh_token":self.refresh_token ? : @"",
                            @"expired_at":self.expired_at ? : @""
                        };
    return dic;
}

@end
