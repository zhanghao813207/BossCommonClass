//
//  JYCSimpleToolClass.m
//  BasicCommonClass
//
//  Created by 贾远潮 on 2018/3/12.
//

#import "JYCSimpleToolClass.h"
#include <CommonCrypto/CommonDigest.h>
#include <CommonCrypto/CommonHMAC.h>
#import "NSDate+Helper.h"
#import "UIImage+Category.h"

@implementation JYCSimpleToolClass

/**
 获取当前控制器
 
 @return 当前控制器
 */
+ (UIViewController *)getCurrentVC
{
    
    UIViewController *rootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    UIViewController *currentVC = [self getCurrentVCFrom:rootVC];
    return  currentVC;
}

+ (UIViewController *)getCurrentVCFrom:(UIViewController *)rootVC
{
    UIViewController *currentVC;
    
    if ([rootVC presentedViewController]) {
        // 视图是被presented出来的
        rootVC = [rootVC presentedViewController];
    }
    
    if ([rootVC isKindOfClass:[UITabBarController class]]) {
        // 根视图为UITabBarController
        currentVC = [self getCurrentVCFrom:[(UITabBarController *)rootVC selectedViewController]];
        
    } else if ([rootVC isKindOfClass:[UINavigationController class]]){
        // 根视图为UINavigationController
        currentVC = [self getCurrentVCFrom:[(UINavigationController *)rootVC visibleViewController]];
    } else {
        // 根视图为非导航类
        currentVC = rootVC;
    }
    return currentVC;
}

#pragma mark -- 设备信息获取

/**
 获取UUID
 
 @return uuid 字符串
 */
+ (NSString *)getUUID
{
    NSString *uuid = [[NSUserDefaults standardUserDefaults] valueForKey:@"uuid"];
    if (uuid.length < 1) {
        CFUUIDRef puuid = CFUUIDCreate( nil );
        CFStringRef uuidString = CFUUIDCreateString( nil, puuid );
        NSString * result = (NSString *)CFBridgingRelease(CFStringCreateCopy( NULL, uuidString));
        CFRelease(puuid);
        CFRelease(uuidString);
        result = [result stringByReplacingOccurrencesOfString:@"-" withString:@""];
        [[NSUserDefaults standardUserDefaults] setValue:result forKey:@"uuid"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        uuid = result;
    }
    return uuid;
}

#pragma mark -- 数据加密

#pragma mark - hmacMD5加密
/**
 HmacMD5 加密
 
 @param key 加密的key值
 @param data 加密数据
 @return 加密结果
 */
+ (NSString *)HmacMD5:(NSString *)key data:(NSString *)data
{
    const char *cKey  = [key cStringUsingEncoding:NSASCIIStringEncoding];
    const char *cData = [data cStringUsingEncoding:NSASCIIStringEncoding];
    
    unsigned char cHMAC[CC_MD5_DIGEST_LENGTH];
    CCHmac(kCCHmacAlgMD5, cKey, strlen(cKey), cData, strlen(cData), cHMAC);
    
    NSData *HMAC = [[NSData alloc] initWithBytes:cHMAC
                                          length:sizeof(cHMAC)];
    
    
    return [JYCSimpleToolClass hexRepresentationWithSpaces_AS:NO data:HMAC];
}

/**
 加密中的空格
 
 @param spaces 是否去除空格
 @param data 加密数据
 @return 加密结果
 */
+ (NSString*)hexRepresentationWithSpaces_AS:(BOOL)spaces data:(NSData *)data {
    const unsigned char* bytes = (const unsigned char*)[data bytes];
    NSUInteger nbBytes = [data length];
    
    static const NSUInteger spaceEveryThisManyBytes = 4UL;
    
    static const NSUInteger lineBreakEveryThisManySpaces = 4UL;
    const NSUInteger lineBreakEveryThisManyBytes = spaceEveryThisManyBytes * lineBreakEveryThisManySpaces;
    NSUInteger strLen = 2*nbBytes + (spaces ? nbBytes/spaceEveryThisManyBytes : 0);
    
    NSMutableString* hex = [[NSMutableString alloc] initWithCapacity:strLen];
    for(NSUInteger i=0; i<nbBytes; ) {
        [hex appendFormat:@"%02x", bytes[i]];
        ++i;
        if (spaces) {
            if (i % lineBreakEveryThisManyBytes == 0) [hex appendString:@"\n"];
            else if (i % spaceEveryThisManyBytes == 0) [hex appendString:@" "];
        }
    }
    return hex;
}

#pragma mark - md5摘要算法

/**
 md5摘要算法
 
 @param codeString 要加密的字符串
 @return 加密结果
 */
+ (NSString *)md5String:(NSString *)codeString
{
    
    if(codeString == nil || [codeString length] == 0){
        return nil;
    }
    
    const char *value = [codeString UTF8String];
    
    unsigned char outputBuffer[CC_MD5_DIGEST_LENGTH];
    CC_MD5(value, (CC_LONG)strlen(value), outputBuffer);
    
    NSMutableString *outputString = [[NSMutableString alloc] initWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(NSInteger count = 0; count < CC_MD5_DIGEST_LENGTH; count++){
        [outputString appendFormat:@"%02x",outputBuffer[count]];
    }
    
    return outputString;
}

#pragma mark -- 字符校验相关
/**
 是否是手机号
 
 @param string 字符串
 @return 结果
 */
+ (BOOL)isPhoneStringWithString:(NSString *)string;
{
    //    NSArray *mobilePhone = @[@"134",@"135",@"136",@"137",@"138",@"139",@"147",@"150",@"151",@"152",@"157",@"158",@"159",@"177",@"170",@"173",@"178",@"182",@"183",@"184",@"187",@"188",@"130",@"131",@"132",@"145",@"155",@"156",@"175",@"176",@"185",@"186",@"133",@"149",@"153",@"173",@"177",@"180",@"181",@"189",@"171"];
    if (string.length < 11) {
        return NO;
    }
    //    else if(string.length < 3){
    //        return [self regularNumber:string];
    //    }
    //    if(string.length > 2 && ![mobilePhone containsObject:[string substringWithRange:NSMakeRange(0, 3)]]){
    //        return NO;
    //    }else
    return [self regularPhone:string];
    //    if(string.length >= 11){
    //    }
    //    return NO;
    //    else if ([[string substringWithRange:NSMakeRange(0, 1)] isEqualToString:@"1"]) {
    //        return YES;
    //    } else{
    //        return NO;
    //    }
}

+ (BOOL)regularNumber:(NSString *)num
{
    NSString *numRegex = @"^[0-9]{0,36}$";
    return [self regularString:num regex:numRegex];
}

+ (BOOL)regularPhone:(NSString*)phone
{
    NSString *phoneRegex = @"^(1[3456789])\\d{9}$";
    
    return [self regularString:phone regex:phoneRegex];
}

+ (BOOL)regularString:(NSString*)str regex:(NSString*)regex
{
    NSPredicate *regexPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [regexPredicate evaluateWithObject:str];
}

/**
 字符串是否是银行卡号
 
 @param bankCardNumber 银行卡号
 @return 是否是
 */
+ (BOOL)stringIsBankCardNumber:(NSString *)bankCardNumber;
{
    if (bankCardNumber.length < 15 || bankCardNumber.length > 19) {
        return NO;
    }
    return YES;
}

/**
 字符串是否为空
 
 @param string 需要判断的字符串
 @return 是否空
 */
+ (BOOL)stringIsEmpty:(NSString *)string;
{
    if (string && ![string isEqualToString:@""]) {
        return NO;
    }
    return YES;
}

#pragma mark -- data转换相关

/**
 将数组转换成字典
 
 @param array 数组
 @param key 数组中对象的某个属性
 @return 转换成的字典
 */
+ (NSDictionary *)changeToDictionaryWithArray:(NSArray *)array byKey:(NSString *)key;
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    if (array.count > 0) {
        if ([array[0] valueForKey:key]) {
            for (id item in array) {
                [dic setObject:item forKey:[item valueForKey:key]];
            }
        }
    }
    return [dic copy];
}

/**
 字典转json字符串
 
 @param dic 字典
 @return json字符串
 */
+ (NSString*)dictionaryToJson:(NSDictionary *)dic
{
    NSError *parseError = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

/**
 字典转模型时使用
 
 @param class 目标模型
 @param value 字典 或者  模型
 @return 返回值
 */
+ (id)setValueOfClass:(Class)class withValue:(id)value
{
    if ([value isKindOfClass:class]) {
        return value;
    } else if ([value isKindOfClass:[NSDictionary class]]) {
        id model = [[class alloc] init];
        [model setValuesForKeysWithDictionary:value];
        return model;
    }
    return nil;
}

/**
 模型数组转字典数组
 
 @param array 模型数组(模型需要实现decodeToDic方法)
 @return 字典数组
 */
+ (NSArray *)encodeArrayToArray:(NSArray *)array
{
    NSMutableArray *arrayM = [NSMutableArray array];
    for (id model in array) {
        if ([model respondsToSelector:@selector(decodeToDic)]) {
            NSDictionary *dic = [model performSelector:@selector(decodeToDic)];
            [arrayM addObject:dic];
        } else {
            NSLog(@"当前模型请实现 decodeToDic 方法");
        }
    }
    return [arrayM copy];
}

#pragma mark -- UI相关

/**
 给view指定的角切圆角
 
 @param corners 切圆角的位置
 @param cornerRadii 切圆角的大小
 @param view 被切圆角的view
 */
+ (void)maskCorners:(UIRectCorner)corners cornerRadii:(CGSize)cornerRadii view:(UIView *)view
{
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds byRoundingCorners:corners cornerRadii:cornerRadii];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = view.bounds;
    maskLayer.path = maskPath.CGPath;
    view.layer.mask = maskLayer;
}

#pragma mark -- image相关

/**
 生成二维码
 
 @param codeString 二维码信息
 @return 二维码图片
 */
+ (UIImage *)createQRCodeWithString:(NSString *)codeString
{
    // 1.创建过滤器，这里的@"CIQRCodeGenerator"是固定的
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    
    // 2.恢复默认设置
    [filter setDefaults];
    [filter setValue:@"H" forKey:@"inputCorrectionLevel"];
    
    // 3. 给过滤器添加数据
    NSData *data = [codeString dataUsingEncoding:NSUTF8StringEncoding];
    // 注意，这里的value必须是NSData类型
    [filter setValue:data forKeyPath:@"inputMessage"];
    
    // 4. 生成二维码
    CIImage *outputImage = [filter outputImage];
    
    // 5. 显示二维码
    UIImage *image = [UIImage creatNonInterpolatedUIImageFormCIImage:outputImage withSize:10000];
    
    return image;
}

/**
 生成纯色图片
 
 @param color 颜色
 @return 返回图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f); //宽高 1.0只要有值就够了
    UIGraphicsBeginImageContext(rect.size); //在这个范围内开启一段上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);//在这段上下文中获取到颜色UIColor
    CGContextFillRect(context, rect);//用这个颜色填充这个上下文
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();//从这段上下文中获取Image属性,,,结束
    UIGraphicsEndImageContext();
    
    return image;
}

/**
 截图
 
 @param view 所截view
 @return 图片
 */
+ (UIImage *)captureImageFromView:(UIView *)view
{
    
    CGRect screenRect = [view bounds];
    
    UIGraphicsBeginImageContext(screenRect.size);
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    [view.layer renderInContext:ctx];
    
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
    
}

/**
 图片转成数据
 
 @param image 图片
 @return 数据
 */
+ (NSData *)dataByImage:(UIImage *)image
{
    NSData *data;
    if (UIImagePNGRepresentation(image) == nil) {
        data = UIImageJPEGRepresentation(image, 1);
    } else {
        data = UIImagePNGRepresentation(image);
    }
    return data;
}

#pragma mark -- 富文本

/**
 改变字符串中某些文字的颜色
 
 @param changeColorStringArray 要改变颜色的字符串
 @param string 总字符串
 @param color 要改变的颜色
 @return 富文本
 */
+ (NSAttributedString *)changeColorString:(NSArray <NSString *>*)changeColorStringArray inString:(NSString *)string withColor:(UIColor *)color
{
    if (changeColorStringArray.count < 1) {
        return [[NSAttributedString alloc] initWithString:@""];
    }
    
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:string];
    
    for (NSInteger i = 0; i < changeColorStringArray.count; i++) {
        NSString *targetString = changeColorStringArray[i];
        NSRange stringRange = [string rangeOfString:targetString options:NSBackwardsSearch];
        if (stringRange.location != NSNotFound) {
            [attString addAttributes:@{NSForegroundColorAttributeName:color} range:stringRange];
        }
    }
    return [attString copy];
}

/**
 改变字符中某些文字的字体大小
 
 @param changeFontStringArray 要改变字体的数组
 @param string 总字符串
 @param font 要改变的font
 @return 富文本
 */
+ (NSAttributedString *)changeFontString:(NSArray <NSString *>*)changeFontStringArray inString:(NSString *)string withFont:(UIFont *)font
{
    if (changeFontStringArray.count < 1) {
        return [[NSAttributedString alloc] initWithString:@""];
    }
    
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:string];
    
    for (NSInteger i = 0; i < changeFontStringArray.count; i++) {
        NSString *targetString = changeFontStringArray[i];
        NSRange stringRange = [string rangeOfString:targetString options:NSBackwardsSearch];
        if (stringRange.location != NSNotFound) {
            [attString addAttributes:@{NSFontAttributeName:font} range:stringRange];
        }
    }
    return [attString copy];
}

#pragma mark -- date 时间相关

/**
 将后台传出的时间格式改成一般格式 中时区转东八区
 
 @param timeString 后端返回的时间
 @return 一般时间格式
 */
+ (NSString *)changeNormalTimeWithString:(NSString *)timeString
{
    if (!timeString || ![timeString isKindOfClass:[NSString class]]) {
        return nil;
    }
    if (timeString.length <= 19) {
        return timeString;
    }
    timeString = [timeString substringToIndex:19];
    timeString = [timeString stringByReplacingOccurrencesOfString:@"T" withString:@" "];
    NSDate *date = [NSDate dateFromString:timeString];
    date = [NSDate dateWithHour:date.hour + 8 minute:date.minute];
    NSString *timeStrings = [NSDate stringFromDate:date withFormat:@"yyyy-MM-dd HH:mm:ss"];
    return timeStrings;
}

/**
 将后台传出的时间格式改成一般格式 只是转格式
 
 @param timeString 后端返回的时间
 @return 一般时间格式
 */
+ (NSString *)fastChangeToNormalTimeWithString:(NSString *)timeString
{
    if (!timeString || ![timeString isKindOfClass:[NSString class]]) {
        return nil;
    }
    if (timeString.length <= 19) {
        return timeString;
    }
    timeString = [timeString substringToIndex:19];
    timeString = [timeString stringByReplacingOccurrencesOfString:@"T" withString:@" "];
    NSDate *date = [NSDate dateFromString:timeString];
    //    date = [NSDate dateWithHour:date.hour + 8 minute:date.minute];
    NSString *timeStrings = [NSDate stringFromDate:date withFormat:@"yyyy-MM-dd HH:mm:ss"];
    return timeStrings;
}

/**
 快速修改日期格式
 
 @param timeString 标准时间字符串
 @return xx月xx日 上午/下午 xx:xx 格式的时间
 */
+ (NSString *)quickChangeTimeWithTimeString:(NSString *)timeString
{
    NSDate *date = [NSDate dateFromString:timeString withFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *MString = [NSDate stringFromDate:date withFormat:@"M月d日"];
    
    NSString *lastString = [self segementOneDayByDate:date segement:YES];
    lastString = [NSString stringWithFormat:@"%@ %@",MString,lastString];
    return lastString;
}

/**
 将一天时间分割开

 @param date 需要分割的时间
 @return 时间点
 */
+ (NSString *)segementOneDayByDate:(NSDate *)date segement:(BOOL)segement
{
    NSString *hString = [NSDate stringFromDate:date withFormat:@"HH"];
    NSString *mString = [NSDate stringFromDate:date withFormat:@"mm"];
    
    if (segement) {
        NSInteger hours = [hString integerValue];
        
        NSString *lastString;
        
        if (hours > 12) {
            lastString = [NSString stringWithFormat:@"下午%ld:%@",hours - 12,mString];
        } else if(hours == 12) {
            lastString = [NSString stringWithFormat:@"下午%ld:%@",hours,mString];
        } else if(hours < 6 && hours >= 0) {
            lastString = [NSString stringWithFormat:@"凌晨%ld:%@",hours,mString];
        } else {
            lastString = [NSString stringWithFormat:@"上午%ld:%@",hours,mString];
        }
        return lastString;
    } else {
        return [NSString stringWithFormat:@"%@:%@",hString,mString];
    }
}

/**
 标准时间格式转微信时间格式

 @param passDate 待比较的时间
 @param nowDate 当前的时间
 @param showToday 是否显示今天
 @param fullYear 是否显示全年
 @param chinaYear 是否显示xx年xx月xx日
 @return 微信时间格式
 */
+ (NSString *)standardTimeFormatterToWChatTimeFormatterByDate:(NSDate *)passDate nowDate:(NSDate *)nowDate showToday:(BOOL)showToday showFullYear:(BOOL)fullYear showChineYear:(BOOL)chinaYear
{
    // 精确 到 秒
    NSTimeInterval passDateInterval = [passDate timeIntervalSince1970];
    NSTimeInterval nowDateInterval = [nowDate timeIntervalSince1970];
    
    if (passDateInterval > nowDateInterval) {
        NSLog(@"传入的过去时间比要比较的时间靠后！");
        return @"";
    }
    
    NSString *passDateMString = [NSDate stringFromDate:passDate withFormat:@"M月d日"];
    NSString *nowDateMString = [NSDate stringFromDate:nowDate withFormat:@"M月d日"];

    if ([passDateMString isEqualToString:nowDateMString]) {
        // 同一天
//        NSLog(@"传入的为同一天");
        if (showToday) {
            return @"今天";
        } else {
            return @"";
        }
    }
    
    NSDate *yesterdayDate = [NSDate dateWithTimeInterval:-60 * 60 * 24 sinceDate:nowDate];
    NSString *yesterdayMString = [NSDate stringFromDate:yesterdayDate withFormat:@"M月d日"];

    if ([yesterdayMString isEqualToString:passDateMString]) {
        // 昨天
        return @"昨天";
    }
    
    if(![self isSameYearOfDate:passDate nowDate:nowDate]){
        // 不同年
        if (fullYear) {
            if (chinaYear) {
                return [NSDate stringFromDate:passDate withFormat:@"yyyy年MM月dd日"];
            } else {
                return [NSDate stringFromDate:passDate withFormat:@"yyyy/MM/dd"];
            }
        } else {
            if (chinaYear) {
                return [NSDate stringFromDate:passDate withFormat:@"yy年MM月dd日"];
            } else {
                return [NSDate stringFromDate:passDate withFormat:@"yy/MM/dd"];
            }
        }
    }
    
    // 同年
    
    if (![self isSameMonthOfDate:passDate nowDate:nowDate]) {
        // 不同月
        if (chinaYear) {
            return [NSDate stringFromDate:passDate withFormat:@"MM月dd日"];
        } else {
            return [NSDate stringFromDate:passDate withFormat:@"MM/dd"];
        }
    }
    
    // 同月
    NSTimeInterval timeInterval = nowDateInterval - passDateInterval;
    
    if (timeInterval < 60 * 60 * 24 * 7) {
        // 没超过七天 同一周
        if ([self getWeekWithDate:passDate china:YES] < [self getWeekWithDate:nowDate china:YES]) {
            return [self weekdayStringFromDate:passDate];
        }
    }
    if (chinaYear) {
        return [NSDate stringFromDate:passDate withFormat:@"MM月dd日"];
    } else {
        return [NSDate stringFromDate:passDate withFormat:@"MM/dd"];
    }
}

+ (BOOL)isSameMonthOfDate:(NSDate *)passDate nowDate:(NSDate *)nowDate
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    int unit = NSCalendarUnitMonth | NSCalendarUnitYear;
    
    //1.获得当前时间的 年月日
    NSDateComponents *nowCmps = [calendar components:unit fromDate:nowDate];
    
    //2.获得self
    NSDateComponents *passCmps = [calendar components:unit fromDate:passDate];
    
    return (nowCmps.year == passCmps.year) && (nowCmps.month == passCmps.month);
}

+ (BOOL)isSameYearOfDate:(NSDate *)passDate nowDate:(NSDate *)nowDate
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    int unit = NSCalendarUnitYear;
    
    //1.获得当前时间的 年月日
    NSDateComponents *nowCmps = [calendar components:unit fromDate:nowDate];
    
    //2.获得self
    NSDateComponents *passCmps = [calendar components:unit fromDate:passDate];
    
    return nowCmps.year == passCmps.year;
}

/***
 计算同一周的一种方式  后来学到的 历法是有从哪天算这周开始的参数的
 
 NSCalendar *calender = [NSCalendar currentCalendar];
 
 calender.firstWeekday = 2;//设置每周第一天从周一开始
 
 //计算两个日期分别为这年第几周
 NSUInteger countSelf = [calender ordinalityOfUnit:NSCalendarUnitWeekday inUnit:NSCalendarUnitYear forDate:self];
 NSUInteger countDate = [calender ordinalityOfUnit:NSCalendarUnitWeekday inUnit:NSCalendarUnitYear forDate:date];
 */

//把时间转换成星期
+ (NSString*)weekdayStringFromDate:(NSDate*)inputDate {
    
    NSArray *weekdays = [NSArray arrayWithObjects: [NSNull null], @"周日", @"周一", @"周二", @"周三", @"周四", @"周五", @"周六", nil];
    return [weekdays objectAtIndex:[self getWeekWithDate:inputDate china:NO]];
}

+ (NSInteger)getWeekWithDate:(NSDate *)inputDate china:(BOOL)china
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"zh-Hans"];
    
    [calendar setTimeZone:timeZone];
    
    NSCalendarUnit calendarUnit = NSCalendarUnitWeekday;
    
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:inputDate];
    
    if (!china) {
        return theComponents.weekday;
    } else {
        if (theComponents.weekday == 1) {
            return 7;
        } else {
            return theComponents.weekday - 1;
        }
    }
    
    
}
@end
