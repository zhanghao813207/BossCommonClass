
//
//  NSString+Time.m
//  转星期
//
//  Created by admin on 2019/4/27.
//  Copyright © 2019 admin. All rights reserved.
//

#import "NSString+Time.h"
#import "NSDate+Extension.h"

@implementation NSString (Time)
- (NSString *)getTimeStr:(NSString *)timeStr {
    NSString *normalTime = self;
    
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    // 如果是真机调试，转换这种欧美时间，需要设置locale
    fmt.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    // 创建日期
    NSDate *createDate = [fmt dateFromString:normalTime];
    
    // 当前时间
    NSDate *now = [NSDate date];
    
    // 日历对象（方便比较两个日期之间的差距）
    NSCalendar *calendar = [NSCalendar currentCalendar];
    // NSCalendarUnit枚举代表想获得哪些差值
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    // 计算两个日期之间的差值
    NSDateComponents *cmps = [calendar components:unit fromDate:createDate toDate:now options:0];
    
    
    if ([createDate isThisYear]) { // 今年d
        if ([createDate isYesterday]) { // 昨天
            fmt.dateFormat = @"昨天 HH:mm";
            return [fmt stringFromDate:createDate];
        } else if ([createDate isToday]) { // 今天
            //            if (cmps.hour >= 1) {
            //                return [NSString stringWithFormat:@"%d小时前", (int)cmps.hour];
            //            } else if (cmps.minute >= 1) {
            //                return [NSString stringWithFormat:@"%d分钟前", (int)cmps.minute];
            //            } else {
            //                return @"刚刚";
            //            }
            fmt.dateFormat = @"HH:mm";
            return [fmt stringFromDate:createDate];
        } else { // 今年的其他日子
            if ([createDate isThisWeak]) {//本周内
                fmt.dateFormat = @"HH:mm";
                NSString *tempStr = [fmt stringFromDate:createDate];
                return [NSString stringWithFormat:@"%@ %@",[self weekdayStringFromDate:createDate],tempStr];
            }
            fmt.dateFormat = @"yyyy-MM-dd HH:mm";
            return [fmt stringFromDate:createDate];
        }
    } else { // 非今年
        fmt.dateFormat = @"yyyy-MM-dd HH:mm";
        return [fmt stringFromDate:createDate];
    }
    
}


- (NSString*)weekdayStringFromDate:(NSDate *)inputDate {    NSArray *weekdays = [NSArray arrayWithObjects:[NSNull null], @"星期日", @"星期一", @"星期二", @"星期三", @"星期四", @"星期五", @"星期六",nil];
    NSCalendar * calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
    [calendar setTimeZone: timeZone];
    NSCalendarUnit calendarUnit = NSCalendarUnitWeekday;    NSDateComponents* theComponents = [calendar components:calendarUnit fromDate:inputDate];    return[weekdays objectAtIndex:theComponents.weekday];
    
}

/**
*  变更时间格式满足现实要求, 将20191010变更为2019/10/10格式
*/
+(NSString *)changeTimeDisplayFormatWithOriginalTime:(NSString *)originalTime{
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    format.dateFormat = @"yyyyMMdd";
    NSDate *date = [format dateFromString:originalTime];
    format.dateFormat = @"yyyy/MM/dd";
    return  [format stringFromDate:date];
}

@end
