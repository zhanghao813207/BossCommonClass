//
//  BossNoticeMessageModel.m
//  AFNetworking
//
//  Created by 贾远潮 on 2018/9/2.
//

#import "BossNoticeMessageModel.h"

@implementation BossNoticeMessageModel

- (void)setValue:(id)value forKey:(NSString *)key
{
    if (!value || value == [NSNull null]) {
        return;
    }
    
    if ([key isEqualToString:@"event_extra"]) {
        EventExtraModel *model = [[EventExtraModel alloc] init];
        [model setValuesForKeysWithDictionary:value];
        self.event_extra = model;
        return;
    }
    
    [super setValue:value forKey:key];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

@end
