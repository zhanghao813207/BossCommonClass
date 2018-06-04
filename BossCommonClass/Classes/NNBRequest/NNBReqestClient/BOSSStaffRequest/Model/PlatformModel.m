//
//  PlatformModel.m
//  Pods-BossKnight
//
//  Created by 贾远潮 on 2018/5/23.
//

#import "PlatformModel.h"

@implementation PlatformModel

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
                               @"platform_name":self.platform_name ? : @"",
                               @"platform_code":self.platform_code ? : @"",
                               };
    return localDic;
}


@end
