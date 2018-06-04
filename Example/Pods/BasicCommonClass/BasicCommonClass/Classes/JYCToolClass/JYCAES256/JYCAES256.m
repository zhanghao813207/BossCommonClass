//
//  JYCAES256.m
//  BasicCommonClass
//
//  Created by 贾远潮 on 2018/3/12.
//

#import "JYCAES256.h"
#import <CommonCrypto/CommonCryptor.h>
#import <CommonCrypto/CommonDigest.h>

@implementation JYCAES256

static NSData *GetHashForHash(NSData *hash, NSData *passwordSalt) {
    unsigned char md[CC_MD5_DIGEST_LENGTH];
    
    NSMutableData *hashMaterial = [NSMutableData dataWithData:hash];
    [hashMaterial appendData:passwordSalt];
    CC_MD5([hashMaterial bytes], (CC_LONG)[hashMaterial length], md);
    return [NSData dataWithBytes:md length:sizeof(md)];
}

NSData *byteToKey(NSString *password, NSData *salt) {
    
    NSMutableData *passwordSalt = [[password dataUsingEncoding:NSUTF8StringEncoding] mutableCopy];
    [passwordSalt appendData:salt];
    
    NSData *hash1 = GetHashForHash(nil, passwordSalt);
    
    NSData *temp = hash1;
    
    temp = GetHashForHash(temp, passwordSalt);
    
    NSMutableData *hash1_m = [hash1 mutableCopy];
    [hash1_m appendData:temp];
    
    temp = GetHashForHash(temp, passwordSalt);
    
    [hash1_m appendData:temp];
    
    return [hash1_m copy];
}

+ (id )objDecodeWithString:(NSString *)decodeStr password:(NSString *)password {
    
    NSData *data = [JYCAES256 dateWithDecodeString:decodeStr password:password];
    return [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
}

+ (NSData *)dateWithDecodeString:(NSString *)decodeStr password:(NSString *)password {
    
    NSData *decodeData = [decodeStr dataUsingEncoding:NSUTF8StringEncoding];
    decodeData = [[NSData alloc] initWithBase64EncodedData:decodeData options:NSDataBase64DecodingIgnoreUnknownCharacters];
    
    NSData *salt = [decodeData subdataWithRange:NSMakeRange(0, 8)];
    NSData *key = byteToKey(password, salt);
    NSData *iv = [key subdataWithRange:NSMakeRange(32, 16)];
    key = [key subdataWithRange:NSMakeRange(0, 32)];
    
    decodeData = [decodeData subdataWithRange:NSMakeRange(8, decodeData.length - 8)];
    
    NSData *data = [JYCAES256 decode:decodeData iv:iv key:key];
    return data;
}

+ (NSString *)stringDecodeWithString:(NSString *)decodeStr password:(NSString *)password {
    
    NSData *data = [JYCAES256 dateWithDecodeString:decodeStr password:password];
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

+ (NSData *)decode:(NSData *)data iv:(NSData *)iv key:(NSData *)key {
    
    NSUInteger dataLength = data.length;
    
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    
    void *buffer = malloc(bufferSize);
    
    size_t numBytesDecrypted = 0;
    
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt,
                                          kCCAlgorithmAES128,
                                          kCCOptionPKCS7Padding,
                                          key.bytes,
                                          kCCKeySizeAES256,
                                          
                                          iv.bytes,/* 初始化向量(可选) */
                                          
                                          data.bytes, dataLength,/* 输入 */
                                          
                                          buffer, bufferSize,/* 输出 */
                                          
                                          &numBytesDecrypted);
    
    if (cryptStatus == kCCSuccess) {
        
        return [NSData dataWithBytesNoCopy:buffer length:numBytesDecrypted];
        
    }
    
    free(buffer);
    
    return nil;
}


@end
