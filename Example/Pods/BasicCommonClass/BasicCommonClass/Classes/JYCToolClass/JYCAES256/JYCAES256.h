//
//  JYCAES256.h
//  BasicCommonClass
//
//  Created by 贾远潮 on 2018/3/12.
//

#import <Foundation/Foundation.h>

@interface JYCAES256 : NSObject

+ (id )objDecodeWithString:(NSString *)decodeStr password:(NSString *)password;

+ (NSString *)stringDecodeWithString:(NSString *)decodeStr password:(NSString *)password;

@end
