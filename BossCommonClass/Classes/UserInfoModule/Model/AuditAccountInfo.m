//
//	AuditAccountInfo.m
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "AuditAccountInfo.h"

NSString *const kAuditAccountInfoIdField = @"_id";
NSString *const kAuditAccountInfoCreatedAt = @"created_at";
NSString *const kAuditAccountInfoName = @"name";

@interface AuditAccountInfo ()
@end
@implementation AuditAccountInfo




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[kAuditAccountInfoIdField] isKindOfClass:[NSNull class]]){
		self.idField = dictionary[kAuditAccountInfoIdField];
	}	
	if(![dictionary[kAuditAccountInfoCreatedAt] isKindOfClass:[NSNull class]]){
		self.createdAt = dictionary[kAuditAccountInfoCreatedAt];
	}	
	if(![dictionary[kAuditAccountInfoName] isKindOfClass:[NSNull class]]){
		self.name = dictionary[kAuditAccountInfoName];
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
		dictionary[kAuditAccountInfoIdField] = self.idField;
	}
	if(self.createdAt != nil){
		dictionary[kAuditAccountInfoCreatedAt] = self.createdAt;
	}
	if(self.name != nil){
		dictionary[kAuditAccountInfoName] = self.name;
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
		[aCoder encodeObject:self.idField forKey:kAuditAccountInfoIdField];
	}
	if(self.createdAt != nil){
		[aCoder encodeObject:self.createdAt forKey:kAuditAccountInfoCreatedAt];
	}
	if(self.name != nil){
		[aCoder encodeObject:self.name forKey:kAuditAccountInfoName];
	}

}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.idField = [aDecoder decodeObjectForKey:kAuditAccountInfoIdField];
	self.createdAt = [aDecoder decodeObjectForKey:kAuditAccountInfoCreatedAt];
	self.name = [aDecoder decodeObjectForKey:kAuditAccountInfoName];
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	AuditAccountInfo *copy = [AuditAccountInfo new];

	copy.idField = [self.idField copy];
	copy.createdAt = [self.createdAt copy];
	copy.name = [self.name copy];

	return copy;
}
@end