//
//  SalaryModel.m
//  BossCommonClass
//
//  Created by 贾远潮 on 2018/8/12.
//

#import "SalaryModel.h"

@implementation SalaryModel

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

@end
