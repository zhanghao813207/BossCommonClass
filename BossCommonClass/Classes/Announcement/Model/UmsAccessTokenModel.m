//
//	UmsAccessTokenModel.m
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "UmsAccessTokenModel.h"
#import "NSDate+Extension.h"
#import "BossManagerAccount.h"
NSString *const kUmsAccessTokenModelAccessToken = @"access_token";
NSString *const kUmsAccessTokenModelAccountId = @"account_id";
NSString *const kUmsAccessTokenModelAppId = @"app_id";
NSString *const kUmsAccessTokenModelExpiredAt = @"expired_at";
NSString *const kUmsAccessTokenModelRefreshToken = @"refresh_token";
NSString *const kUmsAccessTokenModelAccessKey = @"access_key";
NSString *const kUmsAccessTokenModelSecretKey = @"secret_key";
NSString *const kUmsAccessTokenModelBossAccountIdKey = @"boss_account_id";

@interface UmsAccessTokenModel ()
@end
@implementation UmsAccessTokenModel


// token是否可用
-(BOOL)tokenAvailable{
    // 登录人不一致
    if (![self.bossAccountId isEqualToString:kCurrentBossManagerAccount.accountModel._id]) {
        return NO;
    }
    if(self.expiredAt && self.expiredAt != nil  && ![self.expiredAt isEqualToString:@""]){
        NSArray *arr = [self.expiredAt componentsSeparatedByString:@"T"];
        if (!arr || arr.count != 2){
            return NO;
        }
        return [NSDate numberOfDaysWithCompareDate:arr.firstObject withNumday:kTokenAvailibleBaseDays];
    }
    return NO;
}

/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
    self.bossAccountId = @"";
	if(![dictionary[kUmsAccessTokenModelAccessToken] isKindOfClass:[NSNull class]]){
		self.accessToken = dictionary[kUmsAccessTokenModelAccessToken];
	}	
	if(![dictionary[kUmsAccessTokenModelAccountId] isKindOfClass:[NSNull class]]){
		self.accountId = dictionary[kUmsAccessTokenModelAccountId];
	}	
	if(![dictionary[kUmsAccessTokenModelAppId] isKindOfClass:[NSNull class]]){
		self.appId = dictionary[kUmsAccessTokenModelAppId];
	}	
	if(![dictionary[kUmsAccessTokenModelExpiredAt] isKindOfClass:[NSNull class]]){
		self.expiredAt = dictionary[kUmsAccessTokenModelExpiredAt];
	}	
	if(![dictionary[kUmsAccessTokenModelRefreshToken] isKindOfClass:[NSNull class]]){
		self.refreshToken = dictionary[kUmsAccessTokenModelRefreshToken];
	}
    if(![dictionary[kUmsAccessTokenModelAccessKey] isKindOfClass:[NSNull class]]){
        self.accessKey = dictionary[kUmsAccessTokenModelAccessKey];
    }
    if(![dictionary[kUmsAccessTokenModelSecretKey] isKindOfClass:[NSNull class]]){
        self.secretKey = dictionary[kUmsAccessTokenModelSecretKey];
    }
	return self;
}

/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	if(self.accessToken != nil){
		dictionary[kUmsAccessTokenModelAccessToken] = self.accessToken;
	}
	if(self.accountId != nil){
		dictionary[kUmsAccessTokenModelAccountId] = self.accountId;
	}
	if(self.appId != nil){
		dictionary[kUmsAccessTokenModelAppId] = self.appId;
	}
	if(self.expiredAt != nil){
		dictionary[kUmsAccessTokenModelExpiredAt] = self.expiredAt;
	}
	if(self.refreshToken != nil){
		dictionary[kUmsAccessTokenModelRefreshToken] = self.refreshToken;
	}
    if(self.accessKey != nil){
        dictionary[kUmsAccessTokenModelAccessKey] = self.accessKey;
    }
    if(self.secretKey != nil){
        dictionary[kUmsAccessTokenModelSecretKey] = self.secretKey;
    }
    if(self.bossAccountId != nil){
        dictionary[kUmsAccessTokenModelBossAccountIdKey] = self.bossAccountId;
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
	if(self.accessToken != nil){
		[aCoder encodeObject:self.accessToken forKey:kUmsAccessTokenModelAccessToken];
	}
	if(self.accountId != nil){
		[aCoder encodeObject:self.accountId forKey:kUmsAccessTokenModelAccountId];
	}
	if(self.appId != nil){
		[aCoder encodeObject:self.appId forKey:kUmsAccessTokenModelAppId];
	}
	if(self.expiredAt != nil){
		[aCoder encodeObject:self.expiredAt forKey:kUmsAccessTokenModelExpiredAt];
	}
	if(self.refreshToken != nil){
		[aCoder encodeObject:self.refreshToken forKey:kUmsAccessTokenModelRefreshToken];
	}
    if(self.accessKey != nil){
        [aCoder encodeObject:self.accessKey forKey:kUmsAccessTokenModelAccessKey];
    }
    if(self.secretKey != nil){
        [aCoder encodeObject:self.secretKey forKey:kUmsAccessTokenModelSecretKey];
    }
    if(self.bossAccountId != nil){
        [aCoder encodeObject:self.bossAccountId forKey:kUmsAccessTokenModelBossAccountIdKey];
    }

}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.accessToken = [aDecoder decodeObjectForKey:kUmsAccessTokenModelAccessToken];
	self.accountId = [aDecoder decodeObjectForKey:kUmsAccessTokenModelAccountId];
    self.bossAccountId = [aDecoder decodeObjectForKey:kUmsAccessTokenModelBossAccountIdKey];
	self.appId = [aDecoder decodeObjectForKey:kUmsAccessTokenModelAppId];
	self.expiredAt = [aDecoder decodeObjectForKey:kUmsAccessTokenModelExpiredAt];
	self.refreshToken = [aDecoder decodeObjectForKey:kUmsAccessTokenModelRefreshToken];
    self.accessKey = [aDecoder decodeObjectForKey:kUmsAccessTokenModelAccessKey];
    self.secretKey = [aDecoder decodeObjectForKey:kUmsAccessTokenModelSecretKey];
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	UmsAccessTokenModel *copy = [UmsAccessTokenModel new];

	copy.accessToken = [self.accessToken copy];
	copy.accountId = [self.accountId copy];
	copy.appId = [self.appId copy];
	copy.expiredAt = [self.expiredAt copy];
	copy.refreshToken = [self.refreshToken copy];
    copy.accessKey = [self.accessKey copy];
    copy.secretKey = [self.secretKey copy];
    copy.bossAccountId = [self.bossAccountId copy];
	return copy;
}
@end
