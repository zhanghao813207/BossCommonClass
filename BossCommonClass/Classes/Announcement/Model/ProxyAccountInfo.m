//
//	ProxyAccountInfo.m
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "ProxyAccountInfo.h"

NSString *const kProxyAccountInfoIdField = @"_id";
NSString *const kProxyAccountInfoHeadImgUrl = @"head_img_url";
NSString *const kProxyAccountInfoNickName = @"nick_name";
NSString *const kProxyAccountInfoVendorAccountId = @"vendor_account_id";

@interface ProxyAccountInfo ()
@end
@implementation ProxyAccountInfo




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
    if ([dictionary isKindOfClass:[NSNull class]]) {
        return self;
    }
	if(![dictionary[kProxyAccountInfoIdField] isKindOfClass:[NSNull class]]){
		self.idField = dictionary[kProxyAccountInfoIdField];
	}	
	if(![dictionary[kProxyAccountInfoHeadImgUrl] isKindOfClass:[NSNull class]]){
		self.headImgUrl = dictionary[kProxyAccountInfoHeadImgUrl];
	}	
	if(![dictionary[kProxyAccountInfoNickName] isKindOfClass:[NSNull class]]){
		self.nickName = dictionary[kProxyAccountInfoNickName];
	}	
	if(![dictionary[kProxyAccountInfoVendorAccountId] isKindOfClass:[NSNull class]]){
		self.vendorAccountId = dictionary[kProxyAccountInfoVendorAccountId];
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
		dictionary[kProxyAccountInfoIdField] = self.idField;
	}
	if(self.headImgUrl != nil){
		dictionary[kProxyAccountInfoHeadImgUrl] = self.headImgUrl;
	}
	if(self.nickName != nil){
		dictionary[kProxyAccountInfoNickName] = self.nickName;
	}
	if(self.vendorAccountId != nil){
		dictionary[kProxyAccountInfoVendorAccountId] = self.vendorAccountId;
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
		[aCoder encodeObject:self.idField forKey:kProxyAccountInfoIdField];
	}
	if(self.headImgUrl != nil){
		[aCoder encodeObject:self.headImgUrl forKey:kProxyAccountInfoHeadImgUrl];
	}
	if(self.nickName != nil){
		[aCoder encodeObject:self.nickName forKey:kProxyAccountInfoNickName];
	}
	if(self.vendorAccountId != nil){
		[aCoder encodeObject:self.vendorAccountId forKey:kProxyAccountInfoVendorAccountId];
	}

}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.idField = [aDecoder decodeObjectForKey:kProxyAccountInfoIdField];
	self.headImgUrl = [aDecoder decodeObjectForKey:kProxyAccountInfoHeadImgUrl];
	self.nickName = [aDecoder decodeObjectForKey:kProxyAccountInfoNickName];
	self.vendorAccountId = [aDecoder decodeObjectForKey:kProxyAccountInfoVendorAccountId];
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	ProxyAccountInfo *copy = [ProxyAccountInfo new];

	copy.idField = [self.idField copy];
	copy.headImgUrl = [self.headImgUrl copy];
	copy.nickName = [self.nickName copy];
	copy.vendorAccountId = [self.vendorAccountId copy];

	return copy;
}
@end
