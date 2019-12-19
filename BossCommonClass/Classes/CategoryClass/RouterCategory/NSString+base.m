//
//  NSString+base.m
//  BossCommonClass
//
//  Created by 高炀辉 on 2019/8/22.
//

#import "NSString+base.h"

@implementation NSString (base)

+ (NSString *)isEmptyString:(NSString *)str{
    NSLog(@"%@", self);
    if (str.length > 0 && str != nil) {
        return str;
    } else {
        return @"";
    }
}

- (BOOL)isEmptyString{
    if (self == nil || [self isEqualToString:@""] || [self isKindOfClass:[NSNull class]]){
        return YES;
    }
    return NO;
}

@end
