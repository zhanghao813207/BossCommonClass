//
//  JYCSimpleToolClass.h
//  BasicCommonClass
//
//  Created by 贾远潮 on 2018/3/12.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface JYCSimpleToolClass : NSObject

/**
 获取当前控制器
 
 @return 当前控制器
 */
+ (UIViewController *)getCurrentVC;

#pragma mark -- 设备信息获取

/**
 获取UUID
 
 @return uuid 字符串
 */
+ (NSString *)getUUID;

#pragma mark -- 数据加密

/**
 HmacMD5 加密
 
 @param key 加密的key值
 @param data 加密数据
 @return 加密结果
 */
+ (NSString *)HmacMD5:(NSString *)key data:(NSString *)data;

/**
 md5摘要算法
 
 @param codeString 要加密的字符串
 @return 加密结果
 */
+ (NSString *)md5String:(NSString *)codeString;

#pragma mark -- 字符校验相关
/**
 是否是手机号
 
 @param string 字符串
 @return 结果
 */
+ (BOOL)isPhoneStringWithString:(NSString *)string;

+ (BOOL)regularNumber:(NSString *)num;

/**
 字符串是否是银行卡号
 
 @param bankCardNumber 银行卡号
 @return 是否是
 */
+ (BOOL)stringIsBankCardNumber:(NSString *)bankCardNumber;

/**
 字符串是否为空
 
 @param string 需要判断的字符串
 @return 是否空
 */
+ (BOOL)stringIsEmpty:(NSString *)string;


#pragma mark -- data转换相关

/**
 将数组转换成字典
 
 @param array 数组
 @param key 数组中对象的某个属性
 @return 转换成的字典
 */
+ (NSDictionary *)changeToDictionaryWithArray:(NSArray *)array byKey:(NSString *)key;

/**
 字典转json字符串

 @param dic 字典
 @return json字符串
 */
+ (NSString*)dictionaryToJson:(NSDictionary *)dic;

/**
 字典转模型时使用
 
 @param class 目标模型
 @param value 字典 或者  模型
 @return 返回值
 */
+ (id)setValueOfClass:(Class)class withValue:(id)value;

/**
 模型数组转字典数组
 
 @param array 模型数组(模型需要实现decodeToDic方法)
 @return 字典数组
 */
+ (NSArray *)encodeArrayToArray:(NSArray *)array;

#pragma mark -- UI相关

/**
 给view指定的角切圆角
 
 @param corners 切圆角的位置
 @param cornerRadii 切圆角的大小
 @param view 被切圆角的view
 */
+ (void)maskCorners:(UIRectCorner)corners cornerRadii:(CGSize)cornerRadii view:(UIView *)view;

#pragma mark -- image相关

/**
 生成二维码
 
 @param codeString 二维码信息
 @return 二维码图片
 */
+ (UIImage *)createQRCodeWithString:(NSString *)codeString;

/**
 生成纯色图片
 
 @param color 颜色
 @return 返回图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color;

/**
 截图
 
 @param view 所截view
 @return 图片
 */
+ (UIImage *)captureImageFromView:(UIView *)view;

/**
 图片转成数据
 
 @param image 图片
 @return 数据
 */
+ (NSData *)dataByImage:(UIImage *)image;

#pragma mark -- 富文本

/**
 改变字符串中某些文字的颜色
 
 @param changeColorStringArray 要改变颜色的字符串
 @param string 总字符串
 @param color 要改变的颜色
 @return 富文本
 */
+ (NSAttributedString *)changeColorString:(NSArray <NSString *>*)changeColorStringArray inString:(NSString *)string withColor:(UIColor *)color;

/**
 改变字符中某些文字的字体大小
 
 @param changeFontStringArray 要改变字体的数组
 @param string 总字符串
 @param font 要改变的font
 @return 富文本
 */
+ (NSAttributedString *)changeFontString:(NSArray <NSString *>*)changeFontStringArray inString:(NSString *)string withFont:(UIFont *)font;


#pragma mark -- date 时间相关

/**
 将后台传出的时间格式改成一般格式 中时区转东八区
 
 @param timeString 后端返回的时间
 @return 一般时间格式
 */
+ (NSString *)changeNormalTimeWithString:(NSString *)timeString;

/**
 将后台传出的时间格式改成一般格式 只是转格式
 
 @param timeString 后端返回的时间
 @return 一般时间格式
 */
+ (NSString *)fastChangeToNormalTimeWithString:(NSString *)timeString;

/**
 快速修改日期格式
 
 @param timeString 标准时间字符串
 @return xx月xx日 上午/下午 xx:xx 格式的时间
 */
+ (NSString *)quickChangeTimeWithTimeString:(NSString *)timeString;

@end
