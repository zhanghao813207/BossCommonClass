//
//  PayrollStatementModel.m
//  BossCommonClass
//
//  Created by 贾远潮 on 2018/11/5.
//

#import "PayrollStatementModel.h"

@implementation PayrollStatementModel

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
