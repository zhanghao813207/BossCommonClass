//
//	Address.m
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "Address.h"

NSString *const kAddressArea = @"area";
NSString *const kAddressAreaName = @"area_name";
NSString *const kAddressCity = @"city";
NSString *const kAddressCityName = @"city_name";
NSString *const kAddressDetailedAddress = @"detailed_address";
NSString *const kAddressProvince = @"province";
NSString *const kAddressProvinceName = @"province_name";

@interface Address ()
@end
@implementation Address

/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[kAddressArea] isKindOfClass:[NSNull class]]){
		self.area = [dictionary[kAddressArea] integerValue];
	}

	if(![dictionary[kAddressAreaName] isKindOfClass:[NSNull class]]){
		self.areaName = dictionary[kAddressAreaName];
	}	
	if(![dictionary[kAddressCity] isKindOfClass:[NSNull class]]){
		self.city = [dictionary[kAddressCity] integerValue];
	}

	if(![dictionary[kAddressCityName] isKindOfClass:[NSNull class]]){
		self.cityName = dictionary[kAddressCityName];
	}	
	if(![dictionary[kAddressDetailedAddress] isKindOfClass:[NSNull class]]){
		self.detailedAddress = dictionary[kAddressDetailedAddress];
	}	
	if(![dictionary[kAddressProvince] isKindOfClass:[NSNull class]]){
		self.province = [dictionary[kAddressProvince] integerValue];
	}

	if(![dictionary[kAddressProvinceName] isKindOfClass:[NSNull class]]){
		self.provinceName = dictionary[kAddressProvinceName];
	}	
	return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	dictionary[kAddressArea] = @(self.area);
	if(self.areaName != nil){
		dictionary[kAddressAreaName] = self.areaName;
	}
	dictionary[kAddressCity] = @(self.city);
	if(self.cityName != nil){
		dictionary[kAddressCityName] = self.cityName;
	}
	if(self.detailedAddress != nil){
		dictionary[kAddressDetailedAddress] = self.detailedAddress;
	}
	dictionary[kAddressProvince] = @(self.province);
	if(self.provinceName != nil){
		dictionary[kAddressProvinceName] = self.provinceName;
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
	[aCoder encodeObject:@(self.area) forKey:kAddressArea];	if(self.areaName != nil){
		[aCoder encodeObject:self.areaName forKey:kAddressAreaName];
	}
	[aCoder encodeObject:@(self.city) forKey:kAddressCity];	if(self.cityName != nil){
		[aCoder encodeObject:self.cityName forKey:kAddressCityName];
	}
	if(self.detailedAddress != nil){
		[aCoder encodeObject:self.detailedAddress forKey:kAddressDetailedAddress];
	}
	[aCoder encodeObject:@(self.province) forKey:kAddressProvince];	if(self.provinceName != nil){
		[aCoder encodeObject:self.provinceName forKey:kAddressProvinceName];
	}

}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.area = [[aDecoder decodeObjectForKey:kAddressArea] integerValue];
	self.areaName = [aDecoder decodeObjectForKey:kAddressAreaName];
	self.city = [[aDecoder decodeObjectForKey:kAddressCity] integerValue];
	self.cityName = [aDecoder decodeObjectForKey:kAddressCityName];
	self.detailedAddress = [aDecoder decodeObjectForKey:kAddressDetailedAddress];
	self.province = [[aDecoder decodeObjectForKey:kAddressProvince] integerValue];
	self.provinceName = [aDecoder decodeObjectForKey:kAddressProvinceName];
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	Address *copy = [Address new];

	copy.area = self.area;
	copy.areaName = [self.areaName copy];
	copy.city = self.city;
	copy.cityName = [self.cityName copy];
	copy.detailedAddress = [self.detailedAddress copy];
	copy.province = self.province;
	copy.provinceName = [self.provinceName copy];

	return copy;
}


#pragma mark - setter/getter

- (NSString *)addressToAreaStr {
    NSString *addressStr = @"";
    if(!self.provinceName){
        return addressStr;
    }
    addressStr = [NSString stringWithFormat:@"%@%@",addressStr,self.provinceName];
    if(!self.cityName){
        return addressStr;
    }
    addressStr = [NSString stringWithFormat:@"%@%@",addressStr,self.cityName];
    if(!self.areaName){
        return addressStr;
    }
    addressStr = [NSString stringWithFormat:@"%@%@",addressStr,self.areaName];
    return addressStr;
}

- (NSString *)addressStr {
    if(!self.detailedAddress || self.detailedAddress.length == 0){
        return self.addressToAreaStr;
    }
    return [NSString stringWithFormat:@"%@%@", self.addressToAreaStr, self.detailedAddress];
}
@end
