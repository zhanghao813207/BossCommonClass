//
//	BizDistrictTeam.m
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "BizDistrictTeam.h"

NSString *const kBizDistrictTeamIdField = @"_id";
NSString *const kBizDistrictTeamBusinessExtraField = @"business_extra_field";
NSString *const kBizDistrictTeamName = @"name";
NSString *const kBizDistrictTeamParentId = @"parent_id";
NSString *const kBizDistrictTeamType = @"type";
NSString *const kBizDistrictTeamVendorId = @"vendor_id";
NSString *const kBizDistrictTeamVendorTargetId = @"vendor_target_id";

@interface BizDistrictTeam ()
@end
@implementation BizDistrictTeam




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */
- (void)setParentIdArr:(NSMutableArray *)parentIdArr{
    NSLog(@"parentIdArr%@", parentIdArr);
}
-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
    
    if ([dictionary isKindOfClass:[NSNull class]]) {
        return self;
    }
    
	if(![dictionary[kBizDistrictTeamIdField] isKindOfClass:[NSNull class]]){
		self.idField = dictionary[kBizDistrictTeamIdField];
	}	
	if(![dictionary[kBizDistrictTeamBusinessExtraField] isKindOfClass:[NSNull class]]){
		self.businessExtraField = [[BusinessExtraField alloc] initWithDictionary:dictionary[kBizDistrictTeamBusinessExtraField]];
	}

	if(![dictionary[kBizDistrictTeamName] isKindOfClass:[NSNull class]]){
		self.name = dictionary[kBizDistrictTeamName];
	}	
	if(![dictionary[kBizDistrictTeamParentId] isKindOfClass:[NSNull class]]){
		self.parentId = dictionary[kBizDistrictTeamParentId];
	}	
	if(![dictionary[kBizDistrictTeamType] isKindOfClass:[NSNull class]]){
		self.type = [dictionary[kBizDistrictTeamType] integerValue];
	}

	if(![dictionary[kBizDistrictTeamVendorId] isKindOfClass:[NSNull class]]){
		self.vendorId = dictionary[kBizDistrictTeamVendorId];
	}	
	if(![dictionary[kBizDistrictTeamVendorTargetId] isKindOfClass:[NSNull class]]){
		self.vendorTargetId = dictionary[kBizDistrictTeamVendorTargetId];
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
		dictionary[kBizDistrictTeamIdField] = self.idField;
	}
	if(self.businessExtraField != nil){
		dictionary[kBizDistrictTeamBusinessExtraField] = [self.businessExtraField toDictionary];
	}
	if(self.name != nil){
		dictionary[kBizDistrictTeamName] = self.name;
	}
	if(self.parentId != nil){
		dictionary[kBizDistrictTeamParentId] = self.parentId;
	}
	dictionary[kBizDistrictTeamType] = @(self.type);
	if(self.vendorId != nil){
		dictionary[kBizDistrictTeamVendorId] = self.vendorId;
	}
	if(self.vendorTargetId != nil){
		dictionary[kBizDistrictTeamVendorTargetId] = self.vendorTargetId;
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
		[aCoder encodeObject:self.idField forKey:kBizDistrictTeamIdField];
	}
	if(self.businessExtraField != nil){
		[aCoder encodeObject:self.businessExtraField forKey:kBizDistrictTeamBusinessExtraField];
	}
	if(self.name != nil){
		[aCoder encodeObject:self.name forKey:kBizDistrictTeamName];
	}
	if(self.parentId != nil){
		[aCoder encodeObject:self.parentId forKey:kBizDistrictTeamParentId];
	}
	[aCoder encodeObject:@(self.type) forKey:kBizDistrictTeamType];	if(self.vendorId != nil){
		[aCoder encodeObject:self.vendorId forKey:kBizDistrictTeamVendorId];
	}
	if(self.vendorTargetId != nil){
		[aCoder encodeObject:self.vendorTargetId forKey:kBizDistrictTeamVendorTargetId];
	}

}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.idField = [aDecoder decodeObjectForKey:kBizDistrictTeamIdField];
	self.businessExtraField = [aDecoder decodeObjectForKey:kBizDistrictTeamBusinessExtraField];
	self.name = [aDecoder decodeObjectForKey:kBizDistrictTeamName];
	self.parentId = [aDecoder decodeObjectForKey:kBizDistrictTeamParentId];
	self.type = [[aDecoder decodeObjectForKey:kBizDistrictTeamType] integerValue];
	self.vendorId = [aDecoder decodeObjectForKey:kBizDistrictTeamVendorId];
	self.vendorTargetId = [aDecoder decodeObjectForKey:kBizDistrictTeamVendorTargetId];
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	BizDistrictTeam *copy = [BizDistrictTeam new];

	copy.idField = [self.idField copy];
	copy.businessExtraField = [self.businessExtraField copy];
	copy.name = [self.name copy];
	copy.parentId = [self.parentId copy];
	copy.type = self.type;
	copy.vendorId = [self.vendorId copy];
	copy.vendorTargetId = [self.vendorTargetId copy];

	return copy;
}
@end
