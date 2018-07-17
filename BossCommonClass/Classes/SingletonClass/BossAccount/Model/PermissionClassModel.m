//
//  PermissionClassModel.m
//  BossCommonClass
//
//  Created by 贾远潮 on 2018/7/16.
//

#import "PermissionClassModel.h"

@implementation PermissionClassModel

- (void)setValue:(id)value forKey:(NSString *)key
{
    if (!value || value == [NSNull null]) {
        return;
    }
    
    [super setValue:value forKey:key];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        self._id = [NSString stringWithFormat:@"%@",value ? : @""];
    }
}

- (NSDictionary *)decodeToDic
{
    NSDictionary *localDic = @{
                               @"available":@([@(self.available) boolValue]),
                               @"sort":@(self.sort),
                               @"state":@(self.state),
                               
                               @"desc":self.desc ? : @"",
                               @"id":self._id ? : @"",
                               @"p_type":self.p_type ? : @"",
                               @"path":self.path ? : @"",
                               };
    return localDic;
}

@end
