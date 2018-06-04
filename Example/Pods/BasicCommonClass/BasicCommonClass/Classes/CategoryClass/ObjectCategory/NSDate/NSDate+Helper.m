//
// NSDate+Helper.m
//
// Created by Billy Gray on 2/26/09.
// Copyright (c) 2009–2012, ZETETIC LLC
// All rights reserved.
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are met:
//     * Redistributions of source code must retain the above copyright
//       notice, this list of conditions and the following disclaimer.
//     * Redistributions in binary form must reproduce the above copyright
//       notice, this list of conditions and the following disclaimer in the
//       documentation and/or other materials provided with the distribution.
//     * Neither the name of the ZETETIC LLC nor the
//       names of its contributors may be used to endorse or promote products
//       derived from this software without specific prior written permission.
//
// THIS SOFTWARE IS PROVIDED BY ZETETIC LLC ''AS IS'' AND ANY
// EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
// WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
// DISCLAIMED. IN NO EVENT SHALL ZETETIC LLC BE LIABLE FOR ANY
// DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
// (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
// LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
// ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
// (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
// SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//

#import "NSDate+Helper.h"

static NSString *kNSDateHelperFormatFullDateWithTime    = @"MMM d, yyyy h:mm a";
static NSString *kNSDateHelperFormatFullDate            = @"MMM d, yyyy";
static NSString *kNSDateHelperFormatShortDateWithTime   = @"MMM d h:mm a";
static NSString *kNSDateHelperFormatShortDate           = @"MMM d";
static NSString *kNSDateHelperFormatWeekday             = @"EEEE";
static NSString *kNSDateHelperFormatWeekdayWithTime     = @"EEEE h:mm a";
static NSString *kNSDateHelperFormatTime                = @"h:mm a";
static NSString *kNSDateHelperFormatTimeWithPrefix      = @"'at' h:mm a";
static NSString *kNSDateHelperFormatSQLDate             = @"yyyy-MM-dd";
static NSString *kNSDateHelperFormatSQLTime             = @"HH:mm:ss";
static NSString *kNSDateHelperFormatSQLDateWithTime     = @"yyyy-MM-dd HH:mm:ss";

@implementation NSDate (Helper)

static NSCalendar *_calendar = nil;
static NSDateFormatter *_displayFormatter = nil;

+ (void)initializeStatics {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        @autoreleasepool {
            if (_calendar == nil) {
#if __has_feature(objc_arc)
                _calendar = [NSCalendar currentCalendar];
#else
                _calendar = [[NSCalendar currentCalendar] retain];
#endif
                _calendar.timeZone = [[NSTimeZone alloc] initWithName:@"GMT+0800"];
            }
            if (_displayFormatter == nil) {
                _displayFormatter = [[NSDateFormatter alloc] init];
                _displayFormatter.timeZone = [[NSTimeZone alloc] initWithName:@"GMT+0800"];
            }
        }
    });
}

+ (NSCalendar *)sharedCalendar {
    [self initializeStatics];
    return _calendar;
}

+ (NSDateFormatter *)sharedDateFormatter {
    [self initializeStatics];
    return _displayFormatter;
}

/*
 * This guy can be a little unreliable and produce unexpected results,
 * you're better off using daysAgoAgainstMidnight
 */
- (NSUInteger)daysAgo {
    NSCalendar *calendar = [[self class] sharedCalendar];
    NSDateComponents *components = [calendar components:(NSCalendarUnitDay)
                                               fromDate:self
                                                 toDate:[NSDate date]
                                                options:0];
	return [components day];
}

- (NSUInteger)daysAgoAgainstMidnight {
	// get a midnight version of ourself:
	NSDateFormatter *mdf = [[self class] sharedDateFormatter];
	[mdf setDateFormat:@"yyyy-MM-dd"];
	NSDate *midnight = [mdf dateFromString:[mdf stringFromDate:self]];
	return (int)[midnight timeIntervalSinceNow] / (60*60*24) *-1;
}

- (NSString *)stringDaysAgo {
	return [self stringDaysAgoAgainstMidnight:YES];
}

- (NSString *)stringDaysAgoAgainstMidnight:(BOOL)flag {
	NSUInteger daysAgo = (flag) ? [self daysAgoAgainstMidnight] : [self daysAgo];
	NSString *text = nil;
	switch (daysAgo) {
		case 0:
			text = NSLocalizedString(@"Today", nil);
			break;
		case 1:
			text = NSLocalizedString(@"Yesterday", nil);
			break;
		default:
			text = [NSString stringWithFormat:@"%d days ago", (int)daysAgo];
	}
	return text;
}

- (NSUInteger)hour {
    NSCalendar *calendar = [[self class] sharedCalendar];
    NSDateComponents *weekdayComponents = [calendar components:(NSCalendarUnitHour) fromDate:self];
	return [weekdayComponents hour];
}

- (NSUInteger)minute {
    NSCalendar *calendar = [[self class] sharedCalendar];
    NSDateComponents *weekdayComponents = [calendar components:(NSCalendarUnitMinute) fromDate:self];
	return [weekdayComponents minute];
}

- (NSUInteger)year {
    NSCalendar *calendar = [[self class] sharedCalendar];
    NSDateComponents *weekdayComponents = [calendar components:(NSCalendarUnitYear) fromDate:self];
	return [weekdayComponents year];
}
- (NSUInteger)month {
    NSCalendar *calendar = [[self class] sharedCalendar];
    NSDateComponents *weekdayComponents = [calendar components:(NSCalendarUnitMonth) fromDate:self];
	return [weekdayComponents month];
}

- (NSUInteger)day {
    NSCalendar *calendar = [[self class] sharedCalendar];
    NSDateComponents *weekdayComponents = [calendar components:(NSCalendarUnitDay) fromDate:self];
	return [weekdayComponents day];
}
- (NSUInteger)second {
    NSCalendar *calendar = [[self class] sharedCalendar];
    NSDateComponents *weekdayComponents = [calendar components:(NSCalendarUnitSecond) fromDate:self];
	return [weekdayComponents second];
}

- (long int)utcTimeStamp{
    return lround(floor([self timeIntervalSince1970]));
}

- (NSUInteger)weekday {
    NSDateComponents *weekdayComponents = [[[self class] sharedCalendar] components:(NSCalendarUnitWeekday) fromDate:self];
	return [weekdayComponents weekday];
}

- (NSUInteger)weekNumber {
    NSCalendar *calendar = [[self class] sharedCalendar];
    NSDateComponents *dateComponents = [calendar components:(NSCalendarUnitWeekOfMonth) fromDate:self];
    return [dateComponents weekOfMonth];
}

+ (NSDate *)dateFromString:(NSString *)string {
	return [NSDate dateFromString:string withFormat:[NSDate dbFormatString]];
}

+ (NSDate *)dateFromString:(NSString *)string withFormat:(NSString *)format {
    NSDateFormatter *formatter = [self sharedDateFormatter];
	[formatter setDateFormat:format];
	NSDate *date = [formatter dateFromString:string];
	return date;
}

+ (NSString *)stringFromDate:(NSDate *)date withFormat:(NSString *)format {
	return [date stringWithFormat:format];
}

+ (NSString *)stringFromDate:(NSDate *)date {
	return [date string];
}

+ (NSString *)stringForDisplayFromDate:(NSDate *)date prefixed:(BOOL)prefixed alwaysDisplayTime:(BOOL)displayTime {
    /*
	 * if the date is in today, display 12-hour time with meridian,
	 * if it is within the last 7 days, display weekday name (Friday)
	 * if within the calendar year, display as Jan 23
	 * else display as Nov 11, 2008
	 */
	NSDate *today = [NSDate date];
    NSDateComponents *offsetComponents = [[self sharedCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay)
                                                                  fromDate:today];
	NSDate *midnight = [[self sharedCalendar] dateFromComponents:offsetComponents];
	NSString *displayString = nil;
	// comparing against midnight
    NSComparisonResult midnight_result = [date compare:midnight];
	if (midnight_result == NSOrderedDescending) {
		if (prefixed) {
			[[self sharedDateFormatter] setDateFormat:kNSDateHelperFormatTimeWithPrefix]; // at 11:30 am
		} else {
			[[self sharedDateFormatter] setDateFormat:kNSDateHelperFormatTime]; // 11:30 am
		}
	} else {
		// check if date is within last 7 days
		NSDateComponents *componentsToSubtract = [[NSDateComponents alloc] init];
		[componentsToSubtract setDay:-7];
		NSDate *lastweek = [[self sharedCalendar] dateByAddingComponents:componentsToSubtract toDate:today options:0];
#if !__has_feature(objc_arc)
		[componentsToSubtract release];
#endif
        NSComparisonResult lastweek_result = [date compare:lastweek];
		if (lastweek_result == NSOrderedDescending) {
            if (displayTime) {
                [[self sharedDateFormatter] setDateFormat:kNSDateHelperFormatWeekdayWithTime];
            } else {
                [[self sharedDateFormatter] setDateFormat:kNSDateHelperFormatWeekday]; // Tuesday
            }
		} else {
			// check if same calendar year
			NSInteger thisYear = [offsetComponents year];
			NSDateComponents *dateComponents = [[self sharedCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay)
                                                            fromDate:date];
			NSInteger thatYear = [dateComponents year];
			if (thatYear >= thisYear) {
                if (displayTime) {
                    [[self sharedDateFormatter] setDateFormat:kNSDateHelperFormatShortDateWithTime];
                }
                else {
                    [[self sharedDateFormatter] setDateFormat:kNSDateHelperFormatShortDate];
                }
			} else {
                if (displayTime) {
                    [[self sharedDateFormatter] setDateFormat:kNSDateHelperFormatFullDateWithTime];
                }
                else {
                    [[self sharedDateFormatter] setDateFormat:kNSDateHelperFormatFullDate];
                }
			}
		}
		if (prefixed) {
			NSString *dateFormat = [[self sharedDateFormatter] dateFormat];
			NSString *prefix = @"'on' ";
			[[self sharedDateFormatter] setDateFormat:[prefix stringByAppendingString:dateFormat]];
		}
	}
	// use display formatter to return formatted date string
	displayString = [[self sharedDateFormatter] stringFromDate:date];
	return displayString;
}

+ (NSString *)stringForDisplayFromDate:(NSDate *)date prefixed:(BOOL)prefixed {
	return [[self class] stringForDisplayFromDate:date prefixed:prefixed alwaysDisplayTime:NO];
}

+ (NSString *)stringForDisplayFromDate:(NSDate *)date {
	return [self stringForDisplayFromDate:date prefixed:NO];
}

- (NSString *)stringWithFormat:(NSString *)format {
	[[self class] initializeStatics];
	[[[self class] sharedDateFormatter] setDateFormat:format];
	NSString *timestamp_str = [[[self class] sharedDateFormatter] stringFromDate:self];
	return timestamp_str;
}

- (NSString *)stringWithFormatISO8601; {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSLocale *enUSPOSIXLocale = [NSLocale localeWithLocaleIdentifier:@"en_US_POSIX"];
    [dateFormatter setLocale:enUSPOSIXLocale];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZZZZZ"];
    NSString *outputString = [dateFormatter stringFromDate:self];
#if !__has_feature(objc_arc)
    [dateFormatter release];
#endif
    return outputString;
}

- (NSString *)string {
	return [self stringWithFormat:[NSDate dbFormatString]];
}

- (NSString *)stringWithDateStyle:(NSDateFormatterStyle)dateStyle timeStyle:(NSDateFormatterStyle)timeStyle {
	[[[self class] sharedDateFormatter] setDateStyle:dateStyle];
	[[[self class] sharedDateFormatter] setTimeStyle:timeStyle];
	NSString *outputString = [[[self class] sharedDateFormatter] stringFromDate:self];
	return outputString;
}

- (NSDate *)beginningOfWeek {
	// largely borrowed from "Date and Time Programming Guide for Cocoa"
	// we'll use the default calendar and hope for the best
	NSCalendar *calendar = [[self class] sharedCalendar];
    NSDate *beginningOfWeek = nil;
	BOOL ok = [calendar rangeOfUnit:NSCalendarUnitWeekOfMonth startDate:&beginningOfWeek
						   interval:NULL forDate:self];
	if (ok) {
		return beginningOfWeek;
	}
	// couldn't calc via range, so try to grab Sunday, assuming gregorian style
	// Get the weekday component of the current date
	NSDateComponents *weekdayComponents = [calendar components:NSCalendarUnitWeekOfMonth fromDate:self];
	/*
	 Create a date components to represent the number of days to subtract from the current date.
	 The weekday value for Sunday in the Gregorian calendar is 1, so subtract 1 from the number of days to subtract from the date in question.  (If today's Sunday, subtract 0 days.)
	 */
	NSDateComponents *componentsToSubtract = [[NSDateComponents alloc] init];
	[componentsToSubtract setDay: 0 - ([weekdayComponents weekday] - 1)];
	beginningOfWeek = nil;
	beginningOfWeek = [calendar dateByAddingComponents:componentsToSubtract toDate:self options:0];
#if !__has_feature(objc_arc)
	[componentsToSubtract release];
#endif
	//normalize to midnight, extract the year, month, and day components and create a new date from those components.
	NSDateComponents *components = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay)
											   fromDate:beginningOfWeek];
	return [calendar dateFromComponents:components];
}

- (NSDate *)beginningOfDay {
    NSCalendar *calendar = [[self class] sharedCalendar];
    // Get the weekday component of the current date
	NSDateComponents *components = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay)
											   fromDate:self];
	return [calendar dateFromComponents:components];
}

- (NSDate *)endOfWeek {
    NSCalendar *calendar = [[self class] sharedCalendar];
    // Get the weekday component of the current date
	NSDateComponents *weekdayComponents = [calendar components:NSCalendarUnitWeekday fromDate:self];
	NSDateComponents *componentsToAdd = [[NSDateComponents alloc] init];
	// to get the end of week for a particular date, add (7 - weekday) days
	[componentsToAdd setDay:(7 - [weekdayComponents weekday])];
	NSDate *endOfWeek = [calendar dateByAddingComponents:componentsToAdd toDate:self options:0];
#if !__has_feature(objc_arc)
	[componentsToAdd release];
#endif
	return endOfWeek;
}

- (NSDate *)dateByMonth:(NSInteger)month {
    NSCalendar *calendar = [[self class] sharedCalendar];
    NSDateComponents *components = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay| NSCalendarUnitHour| NSCalendarUnitMinute|NSCalendarUnitSecond) fromDate:self];
    [components setMonth:month];
    [components setDay:1];
    [components setHour:0];
    [components setMinute:0];
    [components setSecond:0];
     return [calendar dateFromComponents:components];
}

- (NSDate *)dateBySubtractingMonths:(NSInteger)month {
    NSCalendar *calendar = [[self class] sharedCalendar];
    NSDateComponents *components = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay| NSCalendarUnitHour| NSCalendarUnitMinute|NSCalendarUnitSecond) fromDate:self];
    components.month -= month;
     return [calendar dateFromComponents:components];
}

- (NSDate *)endDateByMonth:(NSInteger)month {
    NSDate *dete = [self dateByMonth:month];
    NSCalendar *calendar = [[self class] sharedCalendar];
    NSRange range = [calendar rangeOfUnit:NSCalendarUnitDay
                                   inUnit: NSCalendarUnitMonth
                                  forDate:dete];
    NSDateComponents *components = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay| NSCalendarUnitHour| NSCalendarUnitMinute|NSCalendarUnitSecond) fromDate:dete];
    [components setDay:range.length];
    [components setHour:23];
    [components setMinute:59];
    components.second=59;
     return [calendar dateFromComponents:components];
}

+ (NSString *)dateForList:(NSString *)str {
    NSDate *date = [self dateFromString:str withFormat:@"yyyy-MM-dd HH:mm:ss"];
    return [self stringFromDate:date withFormat:@"dd/MM"];
}
//减去多少天，过去多少天
- (NSDate *)dateBySubtractingDays:(NSInteger)day {
    NSCalendar *calendar = [[self class] sharedCalendar];

    NSDateComponents *components = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay| NSCalendarUnitHour| NSCalendarUnitMinute|NSCalendarUnitSecond) fromDate:self];
    components.day -= day;
     return [calendar dateFromComponents:components];
}

- (NSDate *)dateByAddingDays:(NSInteger)days {
    NSCalendar *calendar = [[self class] sharedCalendar];
    
    NSDateComponents *components = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay| NSCalendarUnitHour| NSCalendarUnitMinute|NSCalendarUnitSecond) fromDate:self];
    components.day += days;
    return [calendar dateFromComponents:components];
}

- (NSDate *)dateByAddingHours:(NSInteger)hours {
    NSCalendar *calendar = [[self class] sharedCalendar];
    
    NSDateComponents *components = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay| NSCalendarUnitHour| NSCalendarUnitMinute|NSCalendarUnitSecond) fromDate:self];
    components.hour += hours;
     return [calendar dateFromComponents:components];
}

- (NSDate *)dateByAddingMinutes:(NSInteger)minutes{
    NSCalendar *calendar = [[self class] sharedCalendar];
    
    NSDateComponents *components = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay| NSCalendarUnitHour| NSCalendarUnitMinute|NSCalendarUnitSecond) fromDate:self];
    components.minute += minutes;
    return [calendar dateFromComponents:components];
}

- (NSInteger)dateToInteger {
    NSString *date = [self stringWithFormat:@"yyyyMMdd"];
    return [date integerValue];
}

- (NSDate *)todayStartTime {
    
    NSCalendar *calendar = [[self class] sharedCalendar];
    NSDateComponents *components = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay| NSCalendarUnitHour| NSCalendarUnitMinute|NSCalendarUnitSecond) fromDate:self];
    components.hour = 0;
    components.minute = 0;
    components.second = 0;
    
    return [calendar dateFromComponents:components];
    
}

- (NSDate *)dateAtEndOfDay {
    NSCalendar *calendar = [[self class] sharedCalendar];
    NSDateComponents *components = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay| NSCalendarUnitHour| NSCalendarUnitMinute|NSCalendarUnitSecond) fromDate:self];
    components.hour = 23;
    components.minute = 59;
    components.second = 59;
     return [calendar dateFromComponents:components];
}

- (NSDate *)dateByAddingMonths:(NSInteger)month {
    NSCalendar *calendar = [[self class] sharedCalendar];
    NSDateComponents *components = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay| NSCalendarUnitHour| NSCalendarUnitMinute|NSCalendarUnitSecond) fromDate:self];
    components.month += month;
     return [calendar dateFromComponents:components];
}

- (NSDate *)dateByDay:(NSInteger)day {
    NSCalendar *calendar = [[self class] sharedCalendar];
    NSDateComponents *components = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay| NSCalendarUnitHour| NSCalendarUnitMinute|NSCalendarUnitSecond) fromDate:self];
    components.day = day;
     return [calendar dateFromComponents:components];
}

- (NSDate *)dateAtStartOfDay {
    NSCalendar *calendar = [[self class] sharedCalendar];
    NSDateComponents *components = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay| NSCalendarUnitHour| NSCalendarUnitMinute|NSCalendarUnitSecond) fromDate:self];
    components.hour = 0;
    components.minute = 0;
    components.second = 0;
     return [calendar dateFromComponents:components];
}

- (BOOL)isEarlierThanDate:(NSDate *)date {
    return [self compare:date]==NSOrderedAscending;
}

+ (NSString *)dateIntergerToStr:(NSInteger )intDate {
    NSDate *date = [self dateFromString:[NSString stringWithFormat:@"%ld",(long)intDate] withFormat:@"yyyyMMdd"];
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    format.dateFormat = @"yyyy/MM/dd";
    return [format stringFromDate:date];
}

+ (NSString *)dateFormatString {
	return kNSDateHelperFormatSQLDate;
}

+ (NSString *)timeFormatString {
	return kNSDateHelperFormatSQLTime;
}

+ (NSString *)timestampFormatString {
	return kNSDateHelperFormatSQLDateWithTime;
}

// preserving for compatibility
+ (NSString *)dbFormatString {
	return [NSDate timestampFormatString];
}

+ (NSDate *)dateFromUTCString:(NSString *)utcStr; {
    if (utcStr.length > 10) {
        NSString *d = [utcStr substringWithRange:NSMakeRange(0, 10)];
        NSString *time = [utcStr substringWithRange:NSMakeRange(11, 8)];
        NSString *str = [NSString stringWithFormat:@"%@ %@",d,time];
        //2016-11-05T06:21:06.862000+00:00
        NSString *formatStr = @"yyyy-MM-dd HH:mm:ss";
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        format.dateFormat = formatStr;
        format.timeZone = [[NSTimeZone alloc] initWithName:@"GMT+0000"];
        NSDate *date = [format dateFromString:str];
        return date;
    }else {
        return nil;
    }
}

+ (NSDate *)dateWithHour:(NSInteger)hour minute:(NSInteger)minute {
    NSCalendar *calendar = [[self class] sharedCalendar];
    NSDateComponents *components = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay| NSCalendarUnitHour| NSCalendarUnitMinute|NSCalendarUnitSecond) fromDate:[NSDate date]];
    components.hour = hour;
    components.minute = minute;
    return [calendar dateFromComponents:components];
}

- (NSDate *)dateWithHour:(NSInteger)hour minute:(NSInteger)minute {
    NSCalendar *calendar = [[self class] sharedCalendar];
    NSDateComponents *components = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay| NSCalendarUnitHour| NSCalendarUnitMinute|NSCalendarUnitSecond) fromDate:self];
    components.hour = hour;
    components.minute = minute;
    return [calendar dateFromComponents:components];
}

- (NSDate *)tomorrow {
    return [self dateByAddingDays:1];
}

//星期换算成汉字
- (NSString *)weekDayStrWithPrefix:(NSString *)prefix {
    NSArray *weekdays = @[@"日",@"一",@"二",@"三",@"四",@"五",@"六"];
    NSString *weekDay = weekdays[[self weekday]-1];
    
    return [NSString stringWithFormat:@"%@%@",prefix,weekDay];
}

//未来七天
- (NSArray *)futureSevenDays {
    NSString *formatStr = @"MM月dd日";
    
    return [self fetureDaysWithAddDays:7 formatStr:formatStr];
}

//未来多少天，以及时间格式
- (NSArray *)fetureDaysWithAddDays:(NSInteger )days formatStr:(NSString *)formatStr {
    NSInteger year = self.year;
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    format.dateFormat = formatStr;
    format.timeZone = [[NSTimeZone alloc] initWithName:@"GMT+0800"];
    
    NSMutableArray *futureDays = [@[@"今天"] mutableCopy];
    
    NSDate *currentDate = self;
    for (int i = 1; i < days; i++) {
        currentDate = [self dateByAddingDays:i];
        NSString *dateStr = [format stringFromDate:currentDate];
        dateStr = [NSString stringWithFormat:@"%@ %@",dateStr,[currentDate weekDayStrWithPrefix:@"周"]];
        if (year != currentDate.year) {
            dateStr = [NSString stringWithFormat:@"%ld年 %@",currentDate.year,dateStr];
        }
        [futureDays addObject:dateStr];
    }
    
    return [futureDays copy];
}

//今天从开始时间after个小时开始算起，到截止时间，还剩余的小时数
- (NSArray *)remainHoursToEndDate:(NSDate *)endDate
                  startAfterHours:(NSInteger)after {
    return [self hoursInStartDate:[self dateByAddingHours:after] endDate:endDate];
}

//两个时间点之间的小时数
- (NSArray *)hoursInStartDate:(NSDate *)startDate
                      endDate:(NSDate *)endDate {
    NSInteger start = startDate.hour;
    
    NSInteger end = endDate.hour;
    
    NSMutableArray *hours = [@[] mutableCopy];
    
    for (NSInteger i = start;i < (end+1);i++) {
        [hours addObject:[NSString stringWithFormat:@"%ld",i]];
    }
    
    return hours;
}

- (NSArray *)minutesInStartDate:(NSDate *)startDate
                        endDate:(NSDate *)endDate
                    currentDate:(NSDate *)currentDate{
    
    NSMutableArray *minutes = [@[] mutableCopy];
    
    if (currentDate.hour == startDate.hour) {
        if (startDate.minute == 0 && currentDate.minute == 0) {
            [minutes addObject:@"00"];
        }
        
        if (startDate.minute <= 30 && currentDate.minute <= 30) {
            [minutes addObject:@"30"];
        }
        
    }else if(currentDate.hour == endDate.hour) {
        if (currentDate.minute == 0) {
            [minutes addObject:@"00"];
        }
        
        if (endDate.minute >= 30) {
            [minutes addObject:@"30"];
        }
    }else {
        return @[@"00",@"30"];
    }
    
    return [minutes copy];
}

@end
