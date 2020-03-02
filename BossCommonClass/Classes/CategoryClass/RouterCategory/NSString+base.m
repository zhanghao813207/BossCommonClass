//
//  NSString+base.m
//  BossCommonClass
//
//  Created by 高炀辉 on 2019/8/22.
//

#import "NSString+base.h"
#import "BossBasicDefine.h"

@implementation NSString (base)

+ (NSString *)isEmptyString:(NSString *)str{
    NSLog(@"%@", self);
    if (str.length > 0 && str != nil) {
        return str;
    } else {
        return @"";
    }
}

+ (BOOL)isEmptyStringWithString:(NSString *)str{
    
    if (str == nil || str == NULL || [str isEqualToString:@""] || [str isKindOfClass:[NSNull class]] || [str isEqualToString:@"(null)"] || str.length == 0){
        return YES;
    }
    return NO;
}


@end
