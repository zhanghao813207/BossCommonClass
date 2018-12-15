//
//  CostBookMonthBriefModel.m
//  BossCommonClass
//
//  Created by 贾远潮 on 2018/12/14.
//

#import "CostBookMonthBriefModel.h"
#import "BossBasicDefine.h"

@implementation CostBookMonthBriefModel

- (void)setValue:(id)value forKey:(NSString *)key
{
    if (!value || value == [NSNull null]) {
        return;
    }
    
    [super setValue:value forKey:key];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if (!value || value == [NSNull null]) {
        return;
    }
    DLog(@"undefineKey %@ %@", key, value);
}

@end
