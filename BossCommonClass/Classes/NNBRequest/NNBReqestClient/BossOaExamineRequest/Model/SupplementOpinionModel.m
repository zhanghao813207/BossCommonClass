//
//  SupplementOpinionModel.m
//  BossManager
//
//  Created by 贾远潮 on 2018/12/12.
//  Copyright © 2018 贾远潮. All rights reserved.
//

#import "SupplementOpinionModel.h"

@implementation SupplementOpinionModel

- (void)setValue:(id)value forKey:(NSString *)key
{
    if (!value || value == [NSNull null]) {
        return;
    }
    
    if ([key isEqualToString:@"creator_info"]) {
        AccountModel *model = [[AccountModel alloc] init];
        [model setValuesForKeysWithDictionary:value];
        self.creator_info = model;
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
