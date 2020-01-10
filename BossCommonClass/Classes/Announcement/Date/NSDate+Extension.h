//
//  NSDate+Extension.h
//  AFNetworking
//
//  Created by admin on 2019/4/26.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDate (Extension)
/**
 *  判断某个时间是否为今年
 */
- (BOOL)isThisYear;
/**
 *  判断某个时间是否为昨天
 */
- (BOOL)isYesterday;
/**
 *  判断某个时间是否为今天
 */
- (BOOL)isToday;

/**
 判断是不是本周
 */
- (BOOL)isThisWeak;


/// 获取指定date的详细信息
@property (readonly) NSInteger year;    // 年
@property (readonly) NSInteger month;   // 月
@property (readonly) NSInteger day;     // 日
@property (readonly) NSInteger hour;    // 时
@property (readonly) NSInteger minute;  // 分
@property (readonly) NSInteger second;  // 秒
@property (readonly) NSInteger weekday; // 星期(转成了中国式 星期一（1）~星期日（7）)
@property (readonly) BOOL isToday; //是否为今天
@property (readonly) BOOL isYesterday; //是否为昨天
@property (readonly) BOOL isThisWeak; // 是否为本周内
@property (readonly) BOOL isThisMonth; // 是否为本月
@property (readonly) BOOL isThisYear; //是否为今年

/**
 今天 00：00 ：00  凌晨0时
 @return 日期
 */
+(NSDate *)today;

/*时间组合器*/
+ (NSDate *)dateWithYear:(NSInteger)year;
/** yyyy-MM */
+ (NSDate *)dateWithYear:(NSInteger)year month:(NSInteger)month;
/** yyyy-MM-dd */
+ (NSDate *)dateWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day;
/** yyyy-MM-dd HH*/
+ (NSDate *)dateWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day hour:(NSInteger)hour;
/** yyyy-MM-dd HH:mm */
+ (NSDate *)dateWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day hour:(NSInteger)hour minute:(NSInteger)minute;
/** MM-dd HH:mm */
+ (NSDate *)dateWithMonth:(NSInteger)month day:(NSInteger)day hour:(NSInteger)hour minute:(NSInteger)minute;
/** MM-dd */
+ (NSDate *)dateWithMonth:(NSInteger)month day:(NSInteger)day;
/** HH:mm */
+ (NSDate *)dateWithHour:(NSInteger)hour minute:(NSInteger)minute;

/**本周星期一*/
+ (NSDate *)weekFirstDayWithToday;
/**某一天所在周星期一*/
+ (NSDate *)weekFirstDayWithDate:(NSString *)date;
/**某一天上周星期一*/
+ (NSDate *)frontWeekFirstDayWithDate:(NSString *)date;
/**某一天下周星期一*/
+ (NSDate *)nextWeekFirstDayWithDate:(NSString *)date;

/**
 某年某月的第一天时间
 @param month 月
 @param year 年
 @return NSDate
 */
+ (NSDate *)mothFirstDayWithYear:(NSUInteger)year month:(NSUInteger)month;

/**
 今天 所在月的第一天
 @return NSDate
 */
+ (NSDate *)todayMothFirstDay;

/**
 指定时间的上个月的第一天
 @param date 指定时间
 @return 上个月的第一天
 */
+ (NSDate *)mothFirstDayWithFrontMonth:(NSDate *)date;

/**
 指定时间的下一个月的第一天
 @param date 指定时间
 @return 下月的第一天
 */
+ (NSDate *)mothFirstDayWithNextMonth:(NSDate *)date;


/**
 某年某月有多少天
 
 @param month 月
 @param year 年
 @return 天数
 */
+ (NSUInteger)daysInMonth:(NSUInteger)month ofYear:(NSUInteger)year;

/**
 某年某月的第一天是星期几
 
 @param month 月
 @param year 年
 @return 星期几
 */
+ (NSUInteger)firstWeekdayInMonth:(NSUInteger)month ofYear:(NSUInteger)year;


/**
 NSDateComponents 类型转 NSDate
 @param components NSDateComponents
 @return NSDate
 */
+ (NSDate *)dateFromDateComponents:(NSDateComponents *)components;

/**
 NSDate转NSDateComponents
 @param date date descriptionNSDate
 @return NSDateComponents
 */
+ (NSDateComponents *)dateComponentsFromDate:(NSDate *)date;

/**
 日期对比是否为同一天
 @param date 对比日
 @param otherDate 另一个对比日
 @return 是否一样
 */
+ (BOOL)compareDate:(NSDate *)date otherDate:(NSDate *)otherDate;

/**
 时间戳转 展示字符串
 规则 今天 12:12  昨天 12:12  12月12日 12:12 跨年 2018年12月12日 12:12
 @param dTime 时间戳
 @return 时间显示
 */
+(NSString *)doubleTimeChangeToShowString:(double)dTime;

/**
 星期转中文字符串
 
 @param weekday 星期几
 @return 中文字符串
 */
+ (NSString *)stringOfWeekdayInChinese:(NSUInteger)weekday;


/**
 日期转字符串 （给定格式）
 
 @param date 日期
 @param format 格式字符串
 @return 日期字符串
 */
+ (NSString *)dateString:(NSDate *)date format:(NSString *)format;

/**
 字符串转日期 （给定格式）
 
 @param dateString 日期字符串
 @param format g格式字符串
 @return 日期
 */
+ (NSDate *)date:(NSString *)dateString format:(NSString *)format;

/**
 *  比较两个时间大小（可以指定比较级数，即按指定格式进行比较）
 */
- (NSComparisonResult)compare:(NSDate *)targetDate format:(NSString *)format;

/// 比较两个时间的先后顺序,compareStr是否在baseStr之后
/// @param compareStr  比对的时间
/// @param baseStr 比对的基础时间点
+ (BOOL)compareDateOrderdWithCompareStr:(NSString *)compareStr
                            withBaseStr:(NSString *)baseStr;

/// 传入的时间和当前时间的时间间隔是否大于某个特定值(如15天)
/// @param compareStr  比对的时间
/// @param numday 比对的天数
+ (BOOL)numberOfDaysWithCompareDate:(NSString *)compareStr
                         withNumday:(int)numday;

/// 比较时间戳跟当前时间相差多久
/// @param compareTime 传入的时间
/// @return 相差的天数
+ (NSInteger)diffDaysWithCompareTime:(NSInteger)compareTime;


/// 判断"比较的时间"是否在当前时间之前
/// @param compareDate 比较的时间
+ (BOOL)currentdayBeforeAtCompareDate:(NSInteger)compareDate;

/**
 得到当前时间N天前后的日期
 @param day   传入正数 n天后   传入负数 N天前
 @return return value description
 */
+ (NSDate *)getTimeAfterNowWithDay:(int)day;

//设置你需要增加或减少的年、月、日即可获得新的日期
+ (NSDate *)getLaterDateFromDate:(NSDate *)date withYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day;

@end

NS_ASSUME_NONNULL_END
