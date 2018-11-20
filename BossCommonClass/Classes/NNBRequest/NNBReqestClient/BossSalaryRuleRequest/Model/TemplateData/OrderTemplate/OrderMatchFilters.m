//
//  OrderMatchFilters.m
//  AFNetworking
//
//  Created by 贾远潮 on 2018/11/6.
//

#import "OrderMatchFilters.h"
//#import ""
@implementation OrderMatchFilters

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
