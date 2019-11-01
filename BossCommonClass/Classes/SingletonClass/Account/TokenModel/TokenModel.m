//
//  TokenModel.m
//  AFNetworking
//
//  Created by 张浩 on 2019/2/20.
//

#import "TokenModel.h"

NSString *const kRootClassAccessToken = @"access_token";
NSString *const kRootClassAccountId = @"account_id";
NSString *const kRootClassExpiredAt = @"expired_at";
NSString *const kRootClassRefreshToken = @"refresh_token";

@implementation TokenModel


-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if(![dictionary[kRootClassAccessToken] isKindOfClass:[NSNull class]]){
        self.access_token = dictionary[kRootClassAccessToken];
    }
    if(![dictionary[kRootClassAccountId] isKindOfClass:[NSNull class]]){
        self.account_id = dictionary[kRootClassAccountId];
    }
    if(![dictionary[kRootClassExpiredAt] isKindOfClass:[NSNull class]]){
        self.expiredAt = [dictionary[kRootClassExpiredAt] integerValue];
    }

    if(![dictionary[kRootClassRefreshToken] isKindOfClass:[NSNull class]]){
        self.refresh_token = dictionary[kRootClassRefreshToken];
    }
    return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
    NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
    if(self.access_token != nil){
        dictionary[kRootClassAccessToken] = self.access_token;
    }
    if(self.account_id != nil){
        dictionary[kRootClassAccountId] = self.account_id;
    }
    dictionary[kRootClassExpiredAt] = @(self.expiredAt);
    
    if(self.refresh_token != nil){
        dictionary[kRootClassRefreshToken] = self.refresh_token;
    }
    return dictionary;

}

/**
 * Implementation of NSCoding encoding method
 */
/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    if(self.access_token != nil){
        [aCoder encodeObject:self.access_token forKey:kRootClassAccessToken];
    }
    if(self.account_id != nil){
        [aCoder encodeObject:self.account_id forKey:kRootClassAccountId];
    }
    [aCoder encodeObject:@(self.expiredAt) forKey:kRootClassExpiredAt];
    if(self.refresh_token != nil){
        [aCoder encodeObject:self.refresh_token forKey:kRootClassRefreshToken];
    }

}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    self.access_token = [aDecoder decodeObjectForKey:kRootClassAccessToken];
    self.account_id = [aDecoder decodeObjectForKey:kRootClassAccountId];
    self.expiredAt = [[aDecoder decodeObjectForKey:kRootClassExpiredAt] integerValue];
    self.refresh_token = [aDecoder decodeObjectForKey:kRootClassRefreshToken];
    return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
    TokenModel *copy = [TokenModel new];

    copy.access_token = [self.access_token copy];
    copy.account_id = [self.account_id copy];
    copy.expiredAt = self.expiredAt;
    copy.refresh_token = [self.refresh_token copy];

    return copy;
}
- (void)setValue:(id)value forKey:(NSString *)key
{
    [super setValue:value forKey:key];
}

- (void)setValue:(id)value forUndefinedKey:(nonnull NSString *)key
{
    
}

- (BOOL)checkExpired
{
    NSDate *currentDate = [NSDate date];
    NSTimeInterval timeInterval =  currentDate.timeIntervalSince1970;
    NSTimeInterval expired_at = [_expired_at doubleValue];
    NSLog(@"timeInterval = %f expired_at = %f", timeInterval, expired_at);
    return timeInterval >= expired_at ? YES : NO;
}

/**
 模型转字典
 
 @return 字典
 */
- (NSDictionary *)decodeToDic
{
    NSDictionary *dic = @{
                          @"account_id":self.account_id ? : @"",
                            @"access_token":self.access_token ? : @"",
                            @"refresh_token":self.refresh_token ? : @"",
                            @"expired_at":self.expired_at ? : @"",
                           @"expiredAt":@(self.expiredAt)

                        };
    return dic;
}

@end
