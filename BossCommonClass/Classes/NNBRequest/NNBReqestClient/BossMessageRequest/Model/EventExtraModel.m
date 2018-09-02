//
//  EventExtraModel.m
//  AFNetworking
//
//  Created by 贾远潮 on 2018/9/2.
//

#import "EventExtraModel.h"

@implementation EventExtraModel

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