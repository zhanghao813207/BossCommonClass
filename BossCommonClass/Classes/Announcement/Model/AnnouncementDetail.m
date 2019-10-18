
//
//  AnnouncementDetail.m
//  AFNetworking
//
//  Created by admin on 2019/4/22.
//

#import "AnnouncementDetail.h"
#import "MJExtension.h"
#import "Media_info.h"
#import "JYCSimpleToolClass.h"
#import "NSDate+Helper.h"
#import "NSString+Time.h"
#import "NSDate+Extension.h"



@implementation AnnouncementDetail
- (instancetype)init
{
    self = [super init];
    if (self) {
        [AnnouncementDetail mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"media_info_list":@"Media_info",@"member_info_list":@"Sender_info"};
        }];
    }
    return self;
}

- (messageContextType)message_type{
    return self.message_mime_kind;
}

- (NSString *)time {
    NSString *normalTime = [JYCSimpleToolClass fastChangeToNormalTimeWithString:self.created_at];
    NSDate *normalDate = [NSDate dateFromString:normalTime];
    NSString *tempDate = [NSDate stringFromDate:normalDate withFormat:@"yyyy-MM-dd HH:mm:ss"];
    return [tempDate getTimeStr:@""];
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    // 如果是真机调试，转换这种欧美时间，需要设置locale
    fmt.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    // 创建日期
    NSDate *createDate = [fmt dateFromString:tempDate];
    // 当前时间
    NSDate *now = [NSDate date];
    
    // 日历对象（方便比较两个日期之间的差距）
    NSCalendar *calendar = [NSCalendar currentCalendar];
    // NSCalendarUnit枚举代表想获得哪些差值
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    // 计算两个日期之间的差值
    NSDateComponents *cmps = [calendar components:unit fromDate:createDate toDate:now options:0];
    
    if ([normalDate isThisYear]) { // 今年d
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
            fmt.dateFormat = @"MM-dd HH:mm";
            return [fmt stringFromDate:createDate];
        }
    } else { // 非今年
        fmt.dateFormat = @"yyyy-MM-dd HH:mm";
        return [fmt stringFromDate:createDate];
    }
    
}
@end
