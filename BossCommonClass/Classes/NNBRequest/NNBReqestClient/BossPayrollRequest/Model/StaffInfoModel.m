//
//  StaffInfoModel.m
//  AFNetworking
//
//  Created by 贾远潮 on 2018/11/5.
//

#import "StaffInfoModel.h"

@implementation StaffInfoModel

- (void)setValue:(id)value forKey:(NSString *)key
{
    if (!value || value == [NSNull null]) {
        return;
    }
    
    [super setValue:value forKey:key];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    DLog(@"%@ UndefinedKey %@",NSStringFromClass([self class]), key);
}


@end
