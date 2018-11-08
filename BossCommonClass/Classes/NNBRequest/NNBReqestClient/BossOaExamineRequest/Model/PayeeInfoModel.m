//
//  PayeeInfoModel.m
//  AFNetworking
//
//  Created by 贾远潮 on 2018/8/9.
//

#import "PayeeInfoModel.h"

@implementation PayeeInfoModel

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
