//
//  KnightInfoModel.m
//  AFNetworking
//
//  Created by 贾远潮 on 2018/11/6.
//

#import "KnightInfoModel.h"

@implementation KnightInfoModel

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
