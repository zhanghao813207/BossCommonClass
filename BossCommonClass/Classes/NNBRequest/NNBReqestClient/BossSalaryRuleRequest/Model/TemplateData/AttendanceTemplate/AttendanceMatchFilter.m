//
//  AttendanceMatchFilter.m
//  AFNetworking
//
//  Created by 贾远潮 on 2018/11/6.
//

#import "AttendanceMatchFilter.h"

@implementation AttendanceMatchFilter

- (void)setValue:(id)value forKey:(NSString *)key
{
    if (!value || value == [NSNull null]) {
        return;
    }
    
    if ([key isEqualToString:@"order_vars"]) {
        OrderVarModel *model = [[OrderVarModel alloc] init];
        [model setValuesForKeysWithDictionary:value];
        self.order_vars = model;
        return;
    }
    
    [super setValue:value forKey:key];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}


@end
