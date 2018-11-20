//
//  MoneyDetailItemModel.m
//  AFNetworking
//
//  Created by 贾远潮 on 2018/11/14.
//

#import "MoneyDetailItemModel.h"
#import "BossBasicDefine.h"
@implementation MoneyDetailItemModel

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
