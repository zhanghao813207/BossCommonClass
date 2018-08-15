//
//  SubItemBean.m
//  AFNetworking
//
//  Created by 贾远潮 on 2018/8/13.
//

#import "SubItemBean.h"

@implementation SubItemBean

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
