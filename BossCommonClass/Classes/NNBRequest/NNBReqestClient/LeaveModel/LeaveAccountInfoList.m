//
//	LeaveAccountInfoList.m
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "LeaveAccountInfoList.h"

NSString *const kLeaveAccountInfoListIdField = @"_id";
NSString *const kLeaveAccountInfoListGid = @"gid";
NSString *const kLeaveAccountInfoListName = @"name";
NSString *const kLeaveAccountInfoListPhone = @"phone";
NSString *const kLeaveAccountInfoListPositionName = @"position_name";
NSString *const kLeaveAccountInfoListStaffId = @"staff_id";
NSString *const kLeaveAccountInfoListState = @"state";

@interface LeaveAccountInfoList ()
@end
@implementation LeaveAccountInfoList




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[kLeaveAccountInfoListIdField] isKindOfClass:[NSNull class]]){
		self.idField = dictionary[kLeaveAccountInfoListIdField];
	}	
	if(![dictionary[kLeaveAccountInfoListGid] isKindOfClass:[NSNull class]]){
		self.gid = [dictionary[kLeaveAccountInfoListGid] integerValue];
	}

	if(![dictionary[kLeaveAccountInfoListName] isKindOfClass:[NSNull class]]){
		self.name = dictionary[kLeaveAccountInfoListName];
	}	
	if(![dictionary[kLeaveAccountInfoListPhone] isKindOfClass:[NSNull class]]){
		self.phone = dictionary[kLeaveAccountInfoListPhone];
	}	
	if(![dictionary[kLeaveAccountInfoListPositionName] isKindOfClass:[NSNull class]]){
		self.positionName = dictionary[kLeaveAccountInfoListPositionName];
	}	
	if(![dictionary[kLeaveAccountInfoListStaffId] isKindOfClass:[NSNull class]]){
		self.staffId = dictionary[kLeaveAccountInfoListStaffId];
	}	
	if(![dictionary[kLeaveAccountInfoListState] isKindOfClass:[NSNull class]]){
		self.state = [dictionary[kLeaveAccountInfoListState] integerValue];
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
		dictionary[kLeaveAccountInfoListIdField] = self.idField;
	}
	dictionary[kLeaveAccountInfoListGid] = @(self.gid);
	if(self.name != nil){
		dictionary[kLeaveAccountInfoListName] = self.name;
	}
	if(self.phone != nil){
		dictionary[kLeaveAccountInfoListPhone] = self.phone;
	}
	if(self.positionName != nil){
		dictionary[kLeaveAccountInfoListPositionName] = self.positionName;
	}
	if(self.staffId != nil){
		dictionary[kLeaveAccountInfoListStaffId] = self.staffId;
	}
	dictionary[kLeaveAccountInfoListState] = @(self.state);
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
		[aCoder encodeObject:self.idField forKey:kLeaveAccountInfoListIdField];
	}
	[aCoder encodeObject:@(self.gid) forKey:kLeaveAccountInfoListGid];	if(self.name != nil){
		[aCoder encodeObject:self.name forKey:kLeaveAccountInfoListName];
	}
	if(self.phone != nil){
		[aCoder encodeObject:self.phone forKey:kLeaveAccountInfoListPhone];
	}
	if(self.positionName != nil){
		[aCoder encodeObject:self.positionName forKey:kLeaveAccountInfoListPositionName];
	}
	if(self.staffId != nil){
		[aCoder encodeObject:self.staffId forKey:kLeaveAccountInfoListStaffId];
	}
	[aCoder encodeObject:@(self.state) forKey:kLeaveAccountInfoListState];
}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.idField = [aDecoder decodeObjectForKey:kLeaveAccountInfoListIdField];
	self.gid = [[aDecoder decodeObjectForKey:kLeaveAccountInfoListGid] integerValue];
	self.name = [aDecoder decodeObjectForKey:kLeaveAccountInfoListName];
	self.phone = [aDecoder decodeObjectForKey:kLeaveAccountInfoListPhone];
	self.positionName = [aDecoder decodeObjectForKey:kLeaveAccountInfoListPositionName];
	self.staffId = [aDecoder decodeObjectForKey:kLeaveAccountInfoListStaffId];
	self.state = [[aDecoder decodeObjectForKey:kLeaveAccountInfoListState] integerValue];
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	LeaveAccountInfoList *copy = [LeaveAccountInfoList new];

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