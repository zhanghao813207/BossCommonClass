//
//  PayeeAccountModel.m
//  BossCommonClass
//
//  Created by 张浩 on 2019/6/18.
//

#import "PayeeAccountModel.h"

@implementation PayeeAccountModel

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
