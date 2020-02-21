//
//  NSString+base.h
//  BossCommonClass
//
//  Created by 高炀辉 on 2019/8/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (base)

/// 是否为空若为空返回空字符串否则返回自己
+ (NSString *)isEmptyString:(NSString *)str;

+ (BOOL)isEmptyStringWithString:(NSString *)str;

+(NSString *)configImageWithState:(NSInteger)state withStateLeavingType:(NSInteger)stateLeavingType;
@end

NS_ASSUME_NONNULL_END
