//
//  SupplementOpinionModel.m
//  BossManager
//
//  Created by 贾远潮 on 2018/12/12.
//  Copyright © 2018 贾远潮. All rights reserved.
//

#import "SupplementOpinionModel.h"
#import "NSDate+Helper.h"

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
    
    if ([key isEqualToString:@"created_at"]) {
        //        yyyy-MM-dd HH:mm:ss
        NSString *normalTimeString = [JYCSimpleToolClass fastChangeToNormalTimeWithString:value];
        self.created_at = normalTimeString;
        
        NSDate *date = [NSDate dateFromString:normalTimeString];
        
        NSString *mainString = [JYCSimpleToolClass standardTimeFormatterToWChatTimeFormatterByDate:date nowDate:[NSDate date] showToday:YES showFullYear:NO showChineYear:NO];
        
        NSString *lastString = [JYCSimpleToolClass segementOneDayByDate:date segement:NO];
        
        NSString *timeString = [NSString stringWithFormat:@"%@ %@",lastString,mainString];
        
        self.wchat_created_at = timeString;
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
