//
//	masksRoleInfo.m
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "masksRoleInfo.h"

NSString *const kmasksRoleInfoIdField = @"_id";
NSString *const kmasksRoleInfoName = @"name";
NSString *const kmasksRoleInfoPermissionIds = @"permission_ids";
NSString *const kmasksRoleInfoRole = @"role";
NSString *const kmasksRoleInfoState = @"state";

@interface masksRoleInfo ()
@end
@implementation masksRoleInfo




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[kmasksRoleInfoIdField] isKindOfClass:[NSNull class]]){
		self.idField = dictionary[kmasksRoleInfoIdField];
	}	
	if(![dictionary[kmasksRoleInfoName] isKindOfClass:[NSNull class]]){
		self.name = dictionary[kmasksRoleInfoName];
	}	
	if(![dictionary[kmasksRoleInfoPermissionIds] isKindOfClass:[NSNull class]]){
		self.permissionIds = dictionary[kmasksRoleInfoPermissionIds];
	}	
	if(![dictionary[kmasksRoleInfoRole] isKindOfClass:[NSNull class]]){
		self.role = [dictionary[kmasksRoleInfoRole] integerValue];
	}

	if(![dictionary[kmasksRoleInfoState] isKindOfClass:[NSNull class]]){
		self.state = [dictionary[kmasksRoleInfoState] integerValue];
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
		dictionary[kmasksRoleInfoIdField] = self.idField;
	}
	if(self.name != nil){
		dictionary[kmasksRoleInfoName] = self.name;
	}
	if(self.permissionIds != nil){
		dictionary[kmasksRoleInfoPermissionIds] = self.permissionIds;
	}
	dictionary[kmasksRoleInfoRole] = @(self.role);
	dictionary[kmasksRoleInfoState] = @(self.state);
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
		[aCoder encodeObject:self.idField forKey:kmasksRoleInfoIdField];
	}
	if(self.name != nil){
		[aCoder encodeObject:self.name forKey:kmasksRoleInfoName];
	}
	if(self.permissionIds != nil){
		[aCoder encodeObject:self.permissionIds forKey:kmasksRoleInfoPermissionIds];
	}
	[aCoder encodeObject:@(self.role) forKey:kmasksRoleInfoRole];	[aCoder encodeObject:@(self.state) forKey:kmasksRoleInfoState];
}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.idField = [aDecoder decodeObjectForKey:kmasksRoleInfoIdField];
	self.name = [aDecoder decodeObjectForKey:kmasksRoleInfoName];
	self.permissionIds = [aDecoder decodeObjectForKey:kmasksRoleInfoPermissionIds];
	self.role = [[aDecoder decodeObjectForKey:kmasksRoleInfoRole] integerValue];
	self.state = [[aDecoder decodeObjectForKey:kmasksRoleInfoState] integerValue];
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	masksRoleInfo *copy = [masksRoleInfo new];

	copy.idField = [self.idField copy];
	copy.name = [self.name copy];
	copy.permissionIds = [self.permissionIds copy];
	copy.role = self.role;
	copy.state = self.state;

	return copy;
}
@end