//
//	ProxyInfo.m
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "ProxyInfo.h"

NSString *const kProxyInfoIdField = @"_id";
NSString *const kProxyInfoHeadImgUrl = @"head_img_url";
NSString *const kProxyInfoNickName = @"nick_name";
NSString *const kProxyInfoVendorAccountId = @"vendor_account_id";

@interface ProxyInfo ()
@end
@implementation ProxyInfo




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
    if ([dictionary isKindOfClass:[NSNull class]]) {
        return self;
    }
	if(![dictionary[kProxyInfoIdField] isKindOfClass:[NSNull class]]){
		self.idField = dictionary[kProxyInfoIdField];
	}	
	if(![dictionary[kProxyInfoHeadImgUrl] isKindOfClass:[NSNull class]]){
		self.headImgUrl = dictionary[kProxyInfoHeadImgUrl];
	}	
	if(![dictionary[kProxyInfoNickName] isKindOfClass:[NSNull class]]){
		self.nickName = dictionary[kProxyInfoNickName];
	}	
	if(![dictionary[kProxyInfoVendorAccountId] isKindOfClass:[NSNull class]]){
		self.vendorAccountId = dictionary[kProxyInfoVendorAccountId];
	}	
	return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	if(self.idField != nil){
		dictionary[kProxyInfoIdField] = self.idField;
	}
	if(self.headImgUrl != nil){
		dictionary[kProxyInfoHeadImgUrl] = self.headImgUrl;
	}
	if(self.nickName != nil){
		dictionary[kProxyInfoNickName] = self.nickName;
	}
	if(self.vendorAccountId != nil){
		dictionary[kProxyInfoVendorAccountId] = self.vendorAccountId;
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
	if(self.idField != nil){
		[aCoder encodeObject:self.idField forKey:kProxyInfoIdField];
	}
	if(self.headImgUrl != nil){
		[aCoder encodeObject:self.headImgUrl forKey:kProxyInfoHeadImgUrl];
	}
	if(self.nickName != nil){
		[aCoder encodeObject:self.nickName forKey:kProxyInfoNickName];
	}
	if(self.vendorAccountId != nil){
		[aCoder encodeObject:self.vendorAccountId forKey:kProxyInfoVendorAccountId];
	}

}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.idField = [aDecoder decodeObjectForKey:kProxyInfoIdField];
	self.headImgUrl = [aDecoder decodeObjectForKey:kProxyInfoHeadImgUrl];
	self.nickName = [aDecoder decodeObjectForKey:kProxyInfoNickName];
	self.vendorAccountId = [aDecoder decodeObjectForKey:kProxyInfoVendorAccountId];
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	ProxyInfo *copy = [ProxyInfo new];

	copy.idField = [self.idField copy];
	copy.headImgUrl = [self.headImgUrl copy];
	copy.nickName = [self.nickName copy];
	copy.vendorAccountId = [self.vendorAccountId copy];

	return copy;
}
@end
