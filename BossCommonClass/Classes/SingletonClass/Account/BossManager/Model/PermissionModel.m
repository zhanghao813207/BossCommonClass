//
//  PermissionModel.m
//  BossCommonClass
//
//  Created by 贾远潮 on 2018/7/16.
//

#import "PermissionModel.h"

@implementation PermissionModel

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
                               @"permission_code":self.permission_code ? : @"",
                               @"permission_name":self.permission_name ? : @"",
                               };
    return localDic;
}


@end
