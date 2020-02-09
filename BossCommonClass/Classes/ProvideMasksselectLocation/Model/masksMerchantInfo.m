//
//	masksMerchantInfo.m
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "masksMerchantInfo.h"

NSString *const kmasksMerchantInfoIdField = @"_id";
NSString *const kmasksMerchantInfoApiGateway = @"api_gateway";
NSString *const kmasksMerchantInfoCreatedAt = @"created_at";
NSString *const kmasksMerchantInfoMerchantCode = @"merchant_code";
NSString *const kmasksMerchantInfoName = @"name";
NSString *const kmasksMerchantInfoState = @"state";
NSString *const kmasksMerchantInfoUpdatedAt = @"updated_at";

@interface masksMerchantInfo ()
@end
@implementation masksMerchantInfo




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[kmasksMerchantInfoIdField] isKindOfClass:[NSNull class]]){
		self.idField = dictionary[kmasksMerchantInfoIdField];
	}	
	if(![dictionary[kmasksMerchantInfoApiGateway] isKindOfClass:[NSNull class]]){
		self.apiGateway = dictionary[kmasksMerchantInfoApiGateway];
	}	
	if(![dictionary[kmasksMerchantInfoCreatedAt] isKindOfClass:[NSNull class]]){
		self.createdAt = dictionary[kmasksMerchantInfoCreatedAt];
	}	
	if(![dictionary[kmasksMerchantInfoMerchantCode] isKindOfClass:[NSNull class]]){
		self.merchantCode = dictionary[kmasksMerchantInfoMerchantCode];
	}	
	if(![dictionary[kmasksMerchantInfoName] isKindOfClass:[NSNull class]]){
		self.name = dictionary[kmasksMerchantInfoName];
	}	
	if(![dictionary[kmasksMerchantInfoState] isKindOfClass:[NSNull class]]){
		self.state = [dictionary[kmasksMerchantInfoState] integerValue];
	}

	if(![dictionary[kmasksMerchantInfoUpdatedAt] isKindOfClass:[NSNull class]]){
		self.updatedAt = dictionary[kmasksMerchantInfoUpdatedAt];
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
		dictionary[kmasksMerchantInfoIdField] = self.idField;
	}
	if(self.apiGateway != nil){
		dictionary[kmasksMerchantInfoApiGateway] = self.apiGateway;
	}
	if(self.createdAt != nil){
		dictionary[kmasksMerchantInfoCreatedAt] = self.createdAt;
	}
	if(self.merchantCode != nil){
		dictionary[kmasksMerchantInfoMerchantCode] = self.merchantCode;
	}
	if(self.name != nil){
		dictionary[kmasksMerchantInfoName] = self.name;
	}
	dictionary[kmasksMerchantInfoState] = @(self.state);
	if(self.updatedAt != nil){
		dictionary[kmasksMerchantInfoUpdatedAt] = self.updatedAt;
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
		[aCoder encodeObject:self.idField forKey:kmasksMerchantInfoIdField];
	}
	if(self.apiGateway != nil){
		[aCoder encodeObject:self.apiGateway forKey:kmasksMerchantInfoApiGateway];
	}
	if(self.createdAt != nil){
		[aCoder encodeObject:self.createdAt forKey:kmasksMerchantInfoCreatedAt];
	}
	if(self.merchantCode != nil){
		[aCoder encodeObject:self.merchantCode forKey:kmasksMerchantInfoMerchantCode];
	}
	if(self.name != nil){
		[aCoder encodeObject:self.name forKey:kmasksMerchantInfoName];
	}
	[aCoder encodeObject:@(self.state) forKey:kmasksMerchantInfoState];	if(self.updatedAt != nil){
		[aCoder encodeObject:self.updatedAt forKey:kmasksMerchantInfoUpdatedAt];
	}

}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.idField = [aDecoder decodeObjectForKey:kmasksMerchantInfoIdField];
	self.apiGateway = [aDecoder decodeObjectForKey:kmasksMerchantInfoApiGateway];
	self.createdAt = [aDecoder decodeObjectForKey:kmasksMerchantInfoCreatedAt];
	self.merchantCode = [aDecoder decodeObjectForKey:kmasksMerchantInfoMerchantCode];
	self.name = [aDecoder decodeObjectForKey:kmasksMerchantInfoName];
	self.state = [[aDecoder decodeObjectForKey:kmasksMerchantInfoState] integerValue];
	self.updatedAt = [aDecoder decodeObjectForKey:kmasksMerchantInfoUpdatedAt];
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	masksMerchantInfo *copy = [masksMerchantInfo new];

	copy.idField = [self.idField copy];
	copy.apiGateway = [self.apiGateway copy];
	copy.createdAt = [self.createdAt copy];
	copy.merchantCode = [self.merchantCode copy];
	copy.name = [self.name copy];
	copy.state = self.state;
	copy.updatedAt = [self.updatedAt copy];

	return copy;
}
@end