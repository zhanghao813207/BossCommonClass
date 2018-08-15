//
//  Specification.m
//  AFNetworking
//
//  Created by 贾远潮 on 2018/8/13.
//

#import "Specification.h"

@implementation Specification

- (void)setValue:(id)value forKey:(NSString *)key
{
    if (!value || value == [NSNull null]) {
        return;
    }
    
    if ([key isEqualToString:@"sub_item"]) {
        NSMutableArray *array = [NSMutableArray array];
        for (NSDictionary *dic in value) {
            SubItemBean *model = [[SubItemBean alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [array addObject:model];
        }
        self.sub_item = [array copy];
        return;
    }
    
    
    [super setValue:value forKey:key];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}


@end
