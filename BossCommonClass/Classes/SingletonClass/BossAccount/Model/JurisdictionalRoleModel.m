//
//  JurisdictionalRoleModel.m
//  BossCommonClass
//
//  Created by 贾远潮 on 2018/7/16.
//

#import "JurisdictionalRoleModel.h"

@implementation JurisdictionalRoleModel


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
                               @"operable":@([@(self.operable) boolValue]),
                               @"gid":@(self.gid),
                               @"pid":@(self.pid),
                               
                               @"name":self.name ? : @"",
                               
                               @"permission_id_list":self.permission_id_list ? : @[],
                               };
    return localDic;
}

@end
