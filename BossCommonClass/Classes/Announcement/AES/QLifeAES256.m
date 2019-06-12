//
//  QLifeAES256.m
//  AFNetworking
//
//  Created by admin on 2019/4/25.
//

#import "QLifeAES256.h"
#import <CommonCrypto/CommonCryptor.h>
#import <CommonCrypto/CommonDigest.h>

@implementation QLifeAES256


+ (id )objDecodeWithString:(NSString *)decodeStr password:(NSString *)password {

    NSData *data = [QLifeAES256 dateWithDecodeString:decodeStr password:password];
    return [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
}

+ (NSData *)dateWithDecodeString:(NSString *)decodeStr password:(NSString *)password {

    NSData *decodeData = [decodeStr dataUsingEncoding:NSUTF8StringEncoding];
    decodeData = [[NSData alloc] initWithBase64EncodedData:decodeData options:NSDataBase64DecodingIgnoreUnknownCharacters];

    NSData *salt = [decodeData subdataWithRange:NSMakeRange(0, 8)];
    NSData *key = QH_byteToKey(password, salt);
    NSData *iv = [key subdataWithRange:NSMakeRange(32, 16)];
    key = [key subdataWithRange:NSMakeRange(0, 32)];

    decodeData = [decodeData subdataWithRange:NSMakeRange(8, decodeData.length - 8)];

    NSData *data = [QLifeAES256 decode:decodeData iv:iv key:key];
    return data;
}

+ (NSString *)stringDecodeWithString:(NSString *)decodeStr password:(NSString *)password {

    NSData *data = [QLifeAES256 dateWithDecodeString:decodeStr password:password];
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

static NSData *QH_GetHashForHash(NSData *hash, NSData *passwordSalt) {
    unsigned char md[CC_MD5_DIGEST_LENGTH];

    NSMutableData *hashMaterial = [NSMutableData dataWithData:hash];
    [hashMaterial appendData:passwordSalt];
    CC_MD5([hashMaterial bytes], (CC_LONG)[hashMaterial length], md);
    return [NSData dataWithBytes:md length:sizeof(md)];
}

NSData *QH_byteToKey(NSString *password, NSData *salt) {
    
    NSMutableData *passwordSalt = [[password dataUsingEncoding:NSUTF8StringEncoding] mutableCopy];
    [passwordSalt appendData:salt];
    
    NSData *hash1 = QH_GetHashForHash(nil, passwordSalt);
    
    NSData *temp = hash1;
    
    temp = QH_GetHashForHash(temp, passwordSalt);
    
    NSMutableData *hash1_m = [hash1 mutableCopy];
    [hash1_m appendData:temp];
    
    temp = QH_GetHashForHash(temp, passwordSalt);
    
    [hash1_m appendData:temp];
    
    return [hash1_m copy];
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

static int RN_SecRandomCopyBytes(void *rnd, size_t count, uint8_t *bytes) {
    static int kSecRandomFD;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        kSecRandomFD = open("/dev/random", O_RDONLY);
    });
    
    if (kSecRandomFD < 0)
        return -1;
    while (count) {
        ssize_t bytes_read = read(kSecRandomFD, bytes, count);
        if (bytes_read == -1) {
            if (errno == EINTR)
                continue;
            return -1;
        }
        if (bytes_read == 0) {
            return -1;
        }
        bytes += bytes_read;
        count -= bytes_read;
    }
    
    return 0;
}

+ (NSData *)encode:(NSData *)data iv:(NSData *)iv key:(NSData *)key {
    
    NSUInteger dataLength = data.length;
    
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    
    void *buffer = malloc(bufferSize);
    
    size_t numBytesDecrypted = 0;
    
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt,
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


+ (NSData *)dataWithEncodeObj:(id)obj password:(NSString *)password {
    NSData *encodeData = [NSJSONSerialization dataWithJSONObject:obj options:NSJSONWritingPrettyPrinted error:nil];
    
    NSData *salt = [self randomDataOfLength:8];
    NSData *key = QH_byteToKey(password, salt);
    NSData *iv = [key subdataWithRange:NSMakeRange(32, 16)];
    key = [key subdataWithRange:NSMakeRange(0, 32)];
    
    NSData *data = [QLifeAES256 encode:encodeData iv:iv key:key];
    
    NSMutableData *decodeData = [salt mutableCopy];
    [decodeData appendData:data];
    
    NSString *string = [decodeData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    return [string dataUsingEncoding:NSUTF8StringEncoding];
}

+ (NSString *)stringWithEncodeObj:(id)obj password:(NSString *)password {
    NSData *encodeData = [NSJSONSerialization dataWithJSONObject:obj options:NSJSONWritingPrettyPrinted error:nil];
    
    NSData *salt = [self randomDataOfLength:8];
    NSData *key = QH_byteToKey(password, salt);
    NSData *iv = [key subdataWithRange:NSMakeRange(32, 16)];
    key = [key subdataWithRange:NSMakeRange(0, 32)];
    
    NSData *data = [QLifeAES256 encode:encodeData iv:iv key:key];
    
    NSMutableData *decodeData = [salt mutableCopy];
    [decodeData appendData:data];
    
    NSString *string = [decodeData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    return string;
}

+ (NSData *)randomDataOfLength:(size_t)length
{
    NSMutableData *data = [NSMutableData dataWithLength:length];
    
    int result;
    if (SecRandomCopyBytes != NULL) {
        result = SecRandomCopyBytes(NULL, length, data.mutableBytes);
    }
    else {
        result = RN_SecRandomCopyBytes(NULL, length, data.mutableBytes);
    }
    NSAssert(result == 0, @"Unable to generate random bytes: %d", errno);
    
    return data;
}

+ (NSData *)dataWithEncodeStirng:(NSString *)str password:(NSString *)password {
    NSData *encodeData = [str dataUsingEncoding:NSUTF8StringEncoding];
    
    NSData *salt = [self randomDataOfLength:8];
    NSData *key = QH_byteToKey(password, salt);
    NSData *iv = [key subdataWithRange:NSMakeRange(32, 16)];
    key = [key subdataWithRange:NSMakeRange(0, 32)];
    
    NSData *data = [QLifeAES256 encode:encodeData iv:iv key:key];
    
    NSMutableData *decodeData = [salt mutableCopy];
    [decodeData appendData:data];
    
    NSString *string = [decodeData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    return [string dataUsingEncoding:NSUTF8StringEncoding];
}

+ (NSString *)stringWithEncodeStirng:(NSString *)str password:(NSString *)password {
    NSData *encodeData = [str dataUsingEncoding:NSUTF8StringEncoding];
    
    NSData *salt = [self randomDataOfLength:8];
    NSData *key = QH_byteToKey(password, salt);
    NSData *iv = [key subdataWithRange:NSMakeRange(32, 16)];
    key = [key subdataWithRange:NSMakeRange(0, 32)];
    
    NSData *data = [QLifeAES256 encode:encodeData iv:iv key:key];
    
    NSMutableData *decodeData = [salt mutableCopy];
    [decodeData appendData:data];
    
    NSString *string = [decodeData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    return string;
}


@end
