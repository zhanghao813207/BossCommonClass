//
//  IndexInfoModel.m
//  AFNetworking
//
//  Created by 贾远潮 on 2018/11/7.
//

#import "IndexInfoModel.h"

@implementation IndexInfoModel
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
