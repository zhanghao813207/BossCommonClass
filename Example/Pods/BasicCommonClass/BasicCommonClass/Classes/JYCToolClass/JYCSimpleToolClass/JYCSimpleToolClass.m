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

#pragma mark --将数组转换成字典
/**
 将数组转换成字典
 
 @param array 数组
 @param key 数组中对象的某个属性
 @return 转换成的字典
 */
+ (NSDictionary *)changeToDictionaryWithArray:(NSArray *)array byKey:(NSString *)key
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

#pragma mark --hmacMD5加密
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

#pragma mark -- md5摘要算法

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


#pragma mark --获取UUID
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

/**
 获取当前控制器
 
 @return 当前控制器
 */
+ (UIViewController *)getCurrentVC
{
    
    UIWindow *window = [[UIApplication sharedApplication].windows firstObject];
    if (!window) {
        return nil;
    }
    UIView *tempView;
    for (UIView *subview in window.subviews) {
        if ([[subview.classForCoder description] isEqualToString:@"UILayoutContainerView"]) {
            tempView = subview;
            break;
        }
    }
    if (!tempView) {
        tempView = [window.subviews lastObject];
    }
    
    id nextResponder = [tempView nextResponder];
    while (![nextResponder isKindOfClass:[UIViewController class]] || [nextResponder isKindOfClass:[UINavigationController class]] || [nextResponder isKindOfClass:[UITabBarController class]]) {
        tempView =  [tempView.subviews firstObject];
        
        if (!tempView) {
            return nil;
        }
        nextResponder = [tempView nextResponder];
    }
    return  (UIViewController *)nextResponder;
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

#pragma mark -- 正则匹配

/**
 是否是手机号
 
 @param string 字符串
 @return 结果
 */
+ (BOOL)isPhoneStringWithString:(NSString *)string
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
+ (BOOL)stringIsBankCardNumber:(NSString *)bankCardNumber
{
    if (bankCardNumber.length < 15 || bankCardNumber.length > 19) {
        return NO;
    }
    return YES;
}

/**
 将后台传出的时间格式改成一般格式
 
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

+ (NSString*)dictionaryToJson:(NSDictionary *)dic

{
    NSError *parseError = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
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
 字符串是否为空
 
 @param string 需要判断的字符串
 @return 是否空
 */
+ (BOOL)stringIsEmpty:(NSString *)string
{
    if (string && ![string isEqualToString:@""]) {
        return NO;
    }
    return YES;
}

@end
