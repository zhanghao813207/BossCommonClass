//
//	BusinessExtraField.m
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "BusinessExtraField.h"

NSString *const kBusinessExtraFieldCityCode = @"city_code";
NSString *const kBusinessExtraFieldCityName = @"city_name";
NSString *const kBusinessExtraFieldPlatformCode = @"platform_code";
NSString *const kBusinessExtraFieldPlatformName = @"platform_name";
NSString *const kBusinessExtraFieldSupplierId = @"supplier_id";
NSString *const kBusinessExtraFieldSupplierName = @"supplier_name";

@interface BusinessExtraField ()
@end
@implementation BusinessExtraField




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
    
    if ([dictionary isKindOfClass:[NSNull class]]) {
        return self;
    }
	if(![dictionary[kBusinessExtraFieldCityCode] isKindOfClass:[NSNull class]]){
		self.cityCode = dictionary[kBusinessExtraFieldCityCode];
	}	
	if(![dictionary[kBusinessExtraFieldCityName] isKindOfClass:[NSNull class]]){
		self.cityName = dictionary[kBusinessExtraFieldCityName];
	}	
	if(![dictionary[kBusinessExtraFieldPlatformCode] isKindOfClass:[NSNull class]]){
		self.platformCode = dictionary[kBusinessExtraFieldPlatformCode];
	}	
	if(![dictionary[kBusinessExtraFieldPlatformName] isKindOfClass:[NSNull class]]){
		self.platformName = dictionary[kBusinessExtraFieldPlatformName];
	}	
	if(![dictionary[kBusinessExtraFieldSupplierId] isKindOfClass:[NSNull class]]){
		self.supplierId = dictionary[kBusinessExtraFieldSupplierId];
	}	
	if(![dictionary[kBusinessExtraFieldSupplierName] isKindOfClass:[NSNull class]]){
		self.supplierName = dictionary[kBusinessExtraFieldSupplierName];
	}	
	return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	if(self.cityCode != nil){
		dictionary[kBusinessExtraFieldCityCode] = self.cityCode;
	}
	if(self.cityName != nil){
		dictionary[kBusinessExtraFieldCityName] = self.cityName;
	}
	if(self.platformCode != nil){
		dictionary[kBusinessExtraFieldPlatformCode] = self.platformCode;
	}
	if(self.platformName != nil){
		dictionary[kBusinessExtraFieldPlatformName] = self.platformName;
	}
	if(self.supplierId != nil){
		dictionary[kBusinessExtraFieldSupplierId] = self.supplierId;
	}
	if(self.supplierName != nil){
		dictionary[kBusinessExtraFieldSupplierName] = self.supplierName;
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
	if(self.cityCode != nil){
		[aCoder encodeObject:self.cityCode forKey:kBusinessExtraFieldCityCode];
	}
	if(self.cityName != nil){
		[aCoder encodeObject:self.cityName forKey:kBusinessExtraFieldCityName];
	}
	if(self.platformCode != nil){
		[aCoder encodeObject:self.platformCode forKey:kBusinessExtraFieldPlatformCode];
	}
	if(self.platformName != nil){
		[aCoder encodeObject:self.platformName forKey:kBusinessExtraFieldPlatformName];
	}
	if(self.supplierId != nil){
		[aCoder encodeObject:self.supplierId forKey:kBusinessExtraFieldSupplierId];
	}
	if(self.supplierName != nil){
		[aCoder encodeObject:self.supplierName forKey:kBusinessExtraFieldSupplierName];
	}

}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.cityCode = [aDecoder decodeObjectForKey:kBusinessExtraFieldCityCode];
	self.cityName = [aDecoder decodeObjectForKey:kBusinessExtraFieldCityName];
	self.platformCode = [aDecoder decodeObjectForKey:kBusinessExtraFieldPlatformCode];
	self.platformName = [aDecoder decodeObjectForKey:kBusinessExtraFieldPlatformName];
	self.supplierId = [aDecoder decodeObjectForKey:kBusinessExtraFieldSupplierId];
	self.supplierName = [aDecoder decodeObjectForKey:kBusinessExtraFieldSupplierName];
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	BusinessExtraField *copy = [BusinessExtraField new];

	copy.cityCode = [self.cityCode copy];
	copy.cityName = [self.cityName copy];
	copy.platformCode = [self.platformCode copy];
	copy.platformName = [self.platformName copy];
	copy.supplierId = [self.supplierId copy];
	copy.supplierName = [self.supplierName copy];

	return copy;
}
@end
