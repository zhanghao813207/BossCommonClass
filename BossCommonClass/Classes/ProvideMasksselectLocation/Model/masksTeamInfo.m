//
//	masksTeamInfo.m
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "masksTeamInfo.h"

NSString *const kmasksTeamInfoIdField = @"_id";
NSString *const kmasksTeamInfoBizDistrictId = @"biz_district_id";
NSString *const kmasksTeamInfoBizDistrictName = @"biz_district_name";
NSString *const kmasksTeamInfoCityCode = @"city_code";
NSString *const kmasksTeamInfoCityName = @"city_name";
NSString *const kmasksTeamInfoCreatedAt = @"created_at";
NSString *const kmasksTeamInfoIndustryCode = @"industry_code";
NSString *const kmasksTeamInfoMerchantId = @"merchant_id";
NSString *const kmasksTeamInfoMerchantInfo = @"merchant_info";
NSString *const kmasksTeamInfoName = @"name";
NSString *const kmasksTeamInfoNickname = @"nickname";
NSString *const kmasksTeamInfoPlatformCode = @"platform_code";
NSString *const kmasksTeamInfoPlatformName = @"platform_name";
NSString *const kmasksTeamInfoState = @"state";
NSString *const kmasksTeamInfoSupplierId = @"supplier_id";
NSString *const kmasksTeamInfoSupplierName = @"supplier_name";
NSString *const kmasksTeamInfoUpdatedAt = @"updated_at";

@interface masksTeamInfo ()
@end
@implementation masksTeamInfo




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[kmasksTeamInfoIdField] isKindOfClass:[NSNull class]]){
		self.idField = dictionary[kmasksTeamInfoIdField];
	}	
	if(![dictionary[kmasksTeamInfoBizDistrictId] isKindOfClass:[NSNull class]]){
		self.bizDistrictId = dictionary[kmasksTeamInfoBizDistrictId];
	}	
	if(![dictionary[kmasksTeamInfoBizDistrictName] isKindOfClass:[NSNull class]]){
		self.bizDistrictName = dictionary[kmasksTeamInfoBizDistrictName];
	}	
	if(![dictionary[kmasksTeamInfoCityCode] isKindOfClass:[NSNull class]]){
		self.cityCode = dictionary[kmasksTeamInfoCityCode];
	}	
	if(![dictionary[kmasksTeamInfoCityName] isKindOfClass:[NSNull class]]){
		self.cityName = dictionary[kmasksTeamInfoCityName];
	}	
	if(![dictionary[kmasksTeamInfoCreatedAt] isKindOfClass:[NSNull class]]){
		self.createdAt = dictionary[kmasksTeamInfoCreatedAt];
	}	
	if(![dictionary[kmasksTeamInfoIndustryCode] isKindOfClass:[NSNull class]]){
		self.industryCode = [dictionary[kmasksTeamInfoIndustryCode] integerValue];
	}

	if(![dictionary[kmasksTeamInfoMerchantId] isKindOfClass:[NSNull class]]){
		self.merchantId = dictionary[kmasksTeamInfoMerchantId];
	}	
	if(![dictionary[kmasksTeamInfoMerchantInfo] isKindOfClass:[NSNull class]]){
		self.merchantInfo = [[masksMerchantInfo alloc] initWithDictionary:dictionary[kmasksTeamInfoMerchantInfo]];
	}

	if(![dictionary[kmasksTeamInfoName] isKindOfClass:[NSNull class]]){
		self.name = dictionary[kmasksTeamInfoName];
	}	
	if(![dictionary[kmasksTeamInfoNickname] isKindOfClass:[NSNull class]]){
		self.nickname = dictionary[kmasksTeamInfoNickname];
	}	
	if(![dictionary[kmasksTeamInfoPlatformCode] isKindOfClass:[NSNull class]]){
		self.platformCode = dictionary[kmasksTeamInfoPlatformCode];
	}	
	if(![dictionary[kmasksTeamInfoPlatformName] isKindOfClass:[NSNull class]]){
		self.platformName = dictionary[kmasksTeamInfoPlatformName];
	}	
	if(![dictionary[kmasksTeamInfoState] isKindOfClass:[NSNull class]]){
		self.state = [dictionary[kmasksTeamInfoState] integerValue];
	}

	if(![dictionary[kmasksTeamInfoSupplierId] isKindOfClass:[NSNull class]]){
		self.supplierId = dictionary[kmasksTeamInfoSupplierId];
	}	
	if(![dictionary[kmasksTeamInfoSupplierName] isKindOfClass:[NSNull class]]){
		self.supplierName = dictionary[kmasksTeamInfoSupplierName];
	}	
	if(![dictionary[kmasksTeamInfoUpdatedAt] isKindOfClass:[NSNull class]]){
		self.updatedAt = dictionary[kmasksTeamInfoUpdatedAt];
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
		dictionary[kmasksTeamInfoIdField] = self.idField;
	}
	if(self.bizDistrictId != nil){
		dictionary[kmasksTeamInfoBizDistrictId] = self.bizDistrictId;
	}
	if(self.bizDistrictName != nil){
		dictionary[kmasksTeamInfoBizDistrictName] = self.bizDistrictName;
	}
	if(self.cityCode != nil){
		dictionary[kmasksTeamInfoCityCode] = self.cityCode;
	}
	if(self.cityName != nil){
		dictionary[kmasksTeamInfoCityName] = self.cityName;
	}
	if(self.createdAt != nil){
		dictionary[kmasksTeamInfoCreatedAt] = self.createdAt;
	}
	dictionary[kmasksTeamInfoIndustryCode] = @(self.industryCode);
	if(self.merchantId != nil){
		dictionary[kmasksTeamInfoMerchantId] = self.merchantId;
	}
	if(self.merchantInfo != nil){
		dictionary[kmasksTeamInfoMerchantInfo] = [self.merchantInfo toDictionary];
	}
	if(self.name != nil){
		dictionary[kmasksTeamInfoName] = self.name;
	}
	if(self.nickname != nil){
		dictionary[kmasksTeamInfoNickname] = self.nickname;
	}
	if(self.platformCode != nil){
		dictionary[kmasksTeamInfoPlatformCode] = self.platformCode;
	}
	if(self.platformName != nil){
		dictionary[kmasksTeamInfoPlatformName] = self.platformName;
	}
	dictionary[kmasksTeamInfoState] = @(self.state);
	if(self.supplierId != nil){
		dictionary[kmasksTeamInfoSupplierId] = self.supplierId;
	}
	if(self.supplierName != nil){
		dictionary[kmasksTeamInfoSupplierName] = self.supplierName;
	}
	if(self.updatedAt != nil){
		dictionary[kmasksTeamInfoUpdatedAt] = self.updatedAt;
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
		[aCoder encodeObject:self.idField forKey:kmasksTeamInfoIdField];
	}
	if(self.bizDistrictId != nil){
		[aCoder encodeObject:self.bizDistrictId forKey:kmasksTeamInfoBizDistrictId];
	}
	if(self.bizDistrictName != nil){
		[aCoder encodeObject:self.bizDistrictName forKey:kmasksTeamInfoBizDistrictName];
	}
	if(self.cityCode != nil){
		[aCoder encodeObject:self.cityCode forKey:kmasksTeamInfoCityCode];
	}
	if(self.cityName != nil){
		[aCoder encodeObject:self.cityName forKey:kmasksTeamInfoCityName];
	}
	if(self.createdAt != nil){
		[aCoder encodeObject:self.createdAt forKey:kmasksTeamInfoCreatedAt];
	}
	[aCoder encodeObject:@(self.industryCode) forKey:kmasksTeamInfoIndustryCode];	if(self.merchantId != nil){
		[aCoder encodeObject:self.merchantId forKey:kmasksTeamInfoMerchantId];
	}
	if(self.merchantInfo != nil){
		[aCoder encodeObject:self.merchantInfo forKey:kmasksTeamInfoMerchantInfo];
	}
	if(self.name != nil){
		[aCoder encodeObject:self.name forKey:kmasksTeamInfoName];
	}
	if(self.nickname != nil){
		[aCoder encodeObject:self.nickname forKey:kmasksTeamInfoNickname];
	}
	if(self.platformCode != nil){
		[aCoder encodeObject:self.platformCode forKey:kmasksTeamInfoPlatformCode];
	}
	if(self.platformName != nil){
		[aCoder encodeObject:self.platformName forKey:kmasksTeamInfoPlatformName];
	}
	[aCoder encodeObject:@(self.state) forKey:kmasksTeamInfoState];	if(self.supplierId != nil){
		[aCoder encodeObject:self.supplierId forKey:kmasksTeamInfoSupplierId];
	}
	if(self.supplierName != nil){
		[aCoder encodeObject:self.supplierName forKey:kmasksTeamInfoSupplierName];
	}
	if(self.updatedAt != nil){
		[aCoder encodeObject:self.updatedAt forKey:kmasksTeamInfoUpdatedAt];
	}

}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.idField = [aDecoder decodeObjectForKey:kmasksTeamInfoIdField];
	self.bizDistrictId = [aDecoder decodeObjectForKey:kmasksTeamInfoBizDistrictId];
	self.bizDistrictName = [aDecoder decodeObjectForKey:kmasksTeamInfoBizDistrictName];
	self.cityCode = [aDecoder decodeObjectForKey:kmasksTeamInfoCityCode];
	self.cityName = [aDecoder decodeObjectForKey:kmasksTeamInfoCityName];
	self.createdAt = [aDecoder decodeObjectForKey:kmasksTeamInfoCreatedAt];
	self.industryCode = [[aDecoder decodeObjectForKey:kmasksTeamInfoIndustryCode] integerValue];
	self.merchantId = [aDecoder decodeObjectForKey:kmasksTeamInfoMerchantId];
	self.merchantInfo = [aDecoder decodeObjectForKey:kmasksTeamInfoMerchantInfo];
	self.name = [aDecoder decodeObjectForKey:kmasksTeamInfoName];
	self.nickname = [aDecoder decodeObjectForKey:kmasksTeamInfoNickname];
	self.platformCode = [aDecoder decodeObjectForKey:kmasksTeamInfoPlatformCode];
	self.platformName = [aDecoder decodeObjectForKey:kmasksTeamInfoPlatformName];
	self.state = [[aDecoder decodeObjectForKey:kmasksTeamInfoState] integerValue];
	self.supplierId = [aDecoder decodeObjectForKey:kmasksTeamInfoSupplierId];
	self.supplierName = [aDecoder decodeObjectForKey:kmasksTeamInfoSupplierName];
	self.updatedAt = [aDecoder decodeObjectForKey:kmasksTeamInfoUpdatedAt];
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	masksTeamInfo *copy = [masksTeamInfo new];

	copy.idField = [self.idField copy];
	copy.bizDistrictId = [self.bizDistrictId copy];
	copy.bizDistrictName = [self.bizDistrictName copy];
	copy.cityCode = [self.cityCode copy];
	copy.cityName = [self.cityName copy];
	copy.createdAt = [self.createdAt copy];
	copy.industryCode = self.industryCode;
	copy.merchantId = [self.merchantId copy];
	copy.merchantInfo = [self.merchantInfo copy];
	copy.name = [self.name copy];
	copy.nickname = [self.nickname copy];
	copy.platformCode = [self.platformCode copy];
	copy.platformName = [self.platformName copy];
	copy.state = self.state;
	copy.supplierId = [self.supplierId copy];
	copy.supplierName = [self.supplierName copy];
	copy.updatedAt = [self.updatedAt copy];

	return copy;
}
@end