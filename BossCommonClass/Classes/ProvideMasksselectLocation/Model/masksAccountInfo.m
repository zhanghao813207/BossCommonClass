//
//	masksAccountInfo.m
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "masksAccountInfo.h"

NSString *const kmasksAccountInfoIdField = @"_id";
NSString *const kmasksAccountInfoCreatedAt = @"created_at";
NSString *const kmasksAccountInfoName = @"name";

@interface masksAccountInfo ()
@end
@implementation masksAccountInfo




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[kmasksAccountInfoIdField] isKindOfClass:[NSNull class]]){
		self.idField = dictionary[kmasksAccountInfoIdField];
	}	
	if(![dictionary[kmasksAccountInfoCreatedAt] isKindOfClass:[NSNull class]]){
		self.createdAt = dictionary[kmasksAccountInfoCreatedAt];
	}	
	if(![dictionary[kmasksAccountInfoName] isKindOfClass:[NSNull class]]){
		self.name = dictionary[kmasksAccountInfoName];
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
		dictionary[kmasksAccountInfoIdField] = self.idField;
	}
	if(self.createdAt != nil){
		dictionary[kmasksAccountInfoCreatedAt] = self.createdAt;
	}
	if(self.name != nil){
		dictionary[kmasksAccountInfoName] = self.name;
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
		[aCoder encodeObject:self.idField forKey:kmasksAccountInfoIdField];
	}
	if(self.createdAt != nil){
		[aCoder encodeObject:self.createdAt forKey:kmasksAccountInfoCreatedAt];
	}
	if(self.name != nil){
		[aCoder encodeObject:self.name forKey:kmasksAccountInfoName];
	}

}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.idField = [aDecoder decodeObjectForKey:kmasksAccountInfoIdField];
	self.createdAt = [aDecoder decodeObjectForKey:kmasksAccountInfoCreatedAt];
	self.name = [aDecoder decodeObjectForKey:kmasksAccountInfoName];
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	masksAccountInfo *copy = [masksAccountInfo new];

	copy.idField = [self.idField copy];
	copy.createdAt = [self.createdAt copy];
	copy.name = [self.name copy];

	return copy;
}
@end