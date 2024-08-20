//
//	SenderInfo.m
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "SenderInfo.h"

NSString *const kSenderInfoIdField = @"_id";
NSString *const kSenderInfoHeadImgUrl = @"head_img_url";
NSString *const kSenderInfoNickName = @"nick_name";
NSString *const kSenderInfoVendorAccountId = @"vendor_account_id";

@interface SenderInfo ()
@end
@implementation SenderInfo




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
    if ([dictionary isKindOfClass:[NSNull class]]) {
        return self;
    }
	if(![dictionary[kSenderInfoIdField] isKindOfClass:[NSNull class]]){
		self.idField = dictionary[kSenderInfoIdField];
	}	
	if(![dictionary[kSenderInfoHeadImgUrl] isKindOfClass:[NSNull class]]){
		self.headImgUrl = dictionary[kSenderInfoHeadImgUrl];
	}	
	if(![dictionary[kSenderInfoNickName] isKindOfClass:[NSNull class]]){
		self.nickName = dictionary[kSenderInfoNickName];
	}	
	if(![dictionary[kSenderInfoVendorAccountId] isKindOfClass:[NSNull class]]){
		self.vendorAccountId = dictionary[kSenderInfoVendorAccountId];
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
		dictionary[kSenderInfoIdField] = self.idField;
	}
	if(self.headImgUrl != nil){
		dictionary[kSenderInfoHeadImgUrl] = self.headImgUrl;
	}
	if(self.nickName != nil){
		dictionary[kSenderInfoNickName] = self.nickName;
	}
	if(self.vendorAccountId != nil){
		dictionary[kSenderInfoVendorAccountId] = self.vendorAccountId;
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
		[aCoder encodeObject:self.idField forKey:kSenderInfoIdField];
	}
	if(self.headImgUrl != nil){
		[aCoder encodeObject:self.headImgUrl forKey:kSenderInfoHeadImgUrl];
	}
	if(self.nickName != nil){
		[aCoder encodeObject:self.nickName forKey:kSenderInfoNickName];
	}
	if(self.vendorAccountId != nil){
		[aCoder encodeObject:self.vendorAccountId forKey:kSenderInfoVendorAccountId];
	}

}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.idField = [aDecoder decodeObjectForKey:kSenderInfoIdField];
	self.headImgUrl = [aDecoder decodeObjectForKey:kSenderInfoHeadImgUrl];
	self.nickName = [aDecoder decodeObjectForKey:kSenderInfoNickName];
	self.vendorAccountId = [aDecoder decodeObjectForKey:kSenderInfoVendorAccountId];
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	SenderInfo *copy = [SenderInfo new];

	copy.idField = [self.idField copy];
	copy.headImgUrl = [self.headImgUrl copy];
	copy.nickName = [self.nickName copy];
	copy.vendorAccountId = [self.vendorAccountId copy];

	return copy;
}
@end
