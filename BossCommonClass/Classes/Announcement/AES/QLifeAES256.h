//
//  QLifeAES256.h
//  AFNetworking
//
//  Created by admin on 2019/4/25.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface QLifeAES256 : NSObject

+ (id )objDecodeWithString:(NSString *)decodeStr password:(NSString *)password;

+ (NSString *)stringDecodeWithString:(NSString *)decodeStr password:(NSString *)password;

+ (NSData *)dataWithEncodeObj:(id)obj password:(NSString *)password;

+ (NSString *)stringWithEncodeObj:(id)obj password:(NSString *)password;

+ (NSData *)dataWithEncodeStirng:(NSString *)str password:(NSString *)password;

+ (NSString *)stringWithEncodeStirng:(NSString *)str password:(NSString *)password;

@end

NS_ASSUME_NONNULL_END
