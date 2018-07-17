//
//  JurisdictionalPositionModel.m
//  BossCommonClass
//
//  Created by 贾远潮 on 2018/7/16.
//

#import "JurisdictionalPositionModel.h"

@implementation JurisdictionalPositionModel

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
                               @"pid":@(self.pid),
                               
                               @"position_id":self.position_id ? : @"",
                               @"position_name":self.position_name ? : @"",
                               };
    return localDic;
}

@end
