//
//	OverTimeApplyAccountInfo.m
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "OverTimeApplyAccountInfo.h"

NSString *const kOverTimeApplyAccountInfoIdField = @"_id";
NSString *const kOverTimeApplyAccountInfoGid = @"gid";
NSString *const kOverTimeApplyAccountInfoName = @"name";
NSString *const kOverTimeApplyAccountInfoPhone = @"phone";
NSString *const kOverTimeApplyAccountInfoPositionName = @"position_name";
NSString *const kOverTimeApplyAccountInfoStaffId = @"staff_id";
NSString *const kOverTimeApplyAccountInfoState = @"state";

@interface OverTimeApplyAccountInfo ()
@end
@implementation OverTimeApplyAccountInfo




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[kOverTimeApplyAccountInfoIdField] isKindOfClass:[NSNull class]]){
		self.idField = dictionary[kOverTimeApplyAccountInfoIdField];
	}	
	if(![dictionary[kOverTimeApplyAccountInfoGid] isKindOfClass:[NSNull class]]){
		self.gid = [dictionary[kOverTimeApplyAccountInfoGid] integerValue];
	}

	if(![dictionary[kOverTimeApplyAccountInfoName] isKindOfClass:[NSNull class]]){
		self.name = dictionary[kOverTimeApplyAccountInfoName];
	}	
	if(![dictionary[kOverTimeApplyAccountInfoPhone] isKindOfClass:[NSNull class]]){
		self.phone = dictionary[kOverTimeApplyAccountInfoPhone];
	}	
	if(![dictionary[kOverTimeApplyAccountInfoPositionName] isKindOfClass:[NSNull class]]){
		self.positionName = dictionary[kOverTimeApplyAccountInfoPositionName];
	}	
	if(![dictionary[kOverTimeApplyAccountInfoStaffId] isKindOfClass:[NSNull class]]){
		self.staffId = dictionary[kOverTimeApplyAccountInfoStaffId];
	}	
	if(![dictionary[kOverTimeApplyAccountInfoState] isKindOfClass:[NSNull class]]){
		self.state = [dictionary[kOverTimeApplyAccountInfoState] integerValue];
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
		dictionary[kOverTimeApplyAccountInfoIdField] = self.idField;
	}
	dictionary[kOverTimeApplyAccountInfoGid] = @(self.gid);
	if(self.name != nil){
		dictionary[kOverTimeApplyAccountInfoName] = self.name;
	}
	if(self.phone != nil){
		dictionary[kOverTimeApplyAccountInfoPhone] = self.phone;
	}
	if(self.positionName != nil){
		dictionary[kOverTimeApplyAccountInfoPositionName] = self.positionName;
	}
	if(self.staffId != nil){
		dictionary[kOverTimeApplyAccountInfoStaffId] = self.staffId;
	}
	dictionary[kOverTimeApplyAccountInfoState] = @(self.state);
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
		[aCoder encodeObject:self.idField forKey:kOverTimeApplyAccountInfoIdField];
	}
	[aCoder encodeObject:@(self.gid) forKey:kOverTimeApplyAccountInfoGid];	if(self.name != nil){
		[aCoder encodeObject:self.name forKey:kOverTimeApplyAccountInfoName];
	}
	if(self.phone != nil){
		[aCoder encodeObject:self.phone forKey:kOverTimeApplyAccountInfoPhone];
	}
	if(self.positionName != nil){
		[aCoder encodeObject:self.positionName forKey:kOverTimeApplyAccountInfoPositionName];
	}
	if(self.staffId != nil){
		[aCoder encodeObject:self.staffId forKey:kOverTimeApplyAccountInfoStaffId];
	}
	[aCoder encodeObject:@(self.state) forKey:kOverTimeApplyAccountInfoState];
}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.idField = [aDecoder decodeObjectForKey:kOverTimeApplyAccountInfoIdField];
	self.gid = [[aDecoder decodeObjectForKey:kOverTimeApplyAccountInfoGid] integerValue];
	self.name = [aDecoder decodeObjectForKey:kOverTimeApplyAccountInfoName];
	self.phone = [aDecoder decodeObjectForKey:kOverTimeApplyAccountInfoPhone];
	self.positionName = [aDecoder decodeObjectForKey:kOverTimeApplyAccountInfoPositionName];
	self.staffId = [aDecoder decodeObjectForKey:kOverTimeApplyAccountInfoStaffId];
	self.state = [[aDecoder decodeObjectForKey:kOverTimeApplyAccountInfoState] integerValue];
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	OverTimeApplyAccountInfo *copy = [OverTimeApplyAccountInfo new];

	copy.idField = [self.idField copy];
	copy.gid = self.gid;
	copy.name = [self.name copy];
	copy.phone = [self.phone copy];
	copy.positionName = [self.positionName copy];
	copy.staffId = [self.staffId copy];
	copy.state = self.state;

	return copy;
}
@end