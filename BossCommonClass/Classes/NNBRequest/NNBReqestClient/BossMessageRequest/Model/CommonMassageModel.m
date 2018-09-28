//
//  CommonMassageModel.m
//  AFNetworking
//
//  Created by 贾远潮 on 2018/9/2.
//

#import "CommonMassageModel.h"
#import "NSDate+Helper.h"
@implementation CommonMassageModel


- (void)setValue:(id)value forKey:(NSString *)key
{
    if (!value || value == [NSNull null]) {
        return;
    }
    
    if ([key isEqualToString:@"created_at"]) {
        NSString *normalTime = [JYCSimpleToolClass fastChangeToNormalTimeWithString:value];
        self.created_at = normalTime;
        
        NSDate *date = [NSDate dateFromString:normalTime withFormat:@"yyyy-MM-dd HH:mm:ss"];
        
        NSString *mainString = [JYCSimpleToolClass standardTimeFormatterToWChatTimeFormatterByDate:date nowDate:[NSDate date] showToday:YES showFullYear:NO showChineYear:YES];
        
        NSString *mainTitleString = [JYCSimpleToolClass standardTimeFormatterToWChatTimeFormatterByDate:date nowDate:[NSDate date] showToday:NO showFullYear:YES showChineYear:YES];
        
        NSString *lastString = [JYCSimpleToolClass segementOneDayByDate:date segement:YES];
        
        self.wchat_created_at = [NSString stringWithFormat:@"%@",mainString];
        
        self.wchat_title_created_at = [NSString stringWithFormat:@"%@ %@",mainTitleString, lastString];
        return;
    }
    
    [super setValue:value forKey:key];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

@end
