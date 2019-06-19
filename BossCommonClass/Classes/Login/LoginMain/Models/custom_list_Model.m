//
//	custom_list_Model.m
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "custom_list_Model.h"

NSString *const kcustom_list_ModelIdField = @"_id";
NSString *const kcustom_list_ModelCustomId = @"custom_id";
NSString *const kcustom_list_ModelEndTime = @"end_time";
NSString *const kcustom_list_ModelStaffId = @"staff_id";
NSString *const kcustom_list_ModelStartTime = @"start_time";
NSString *const kcustom_list_ModelState = @"state";

@interface custom_list_Model ()
@end
@implementation custom_list_Model




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[kcustom_list_ModelIdField] isKindOfClass:[NSNull class]]){
		self.idField = dictionary[kcustom_list_ModelIdField];
	}	
	if(![dictionary[kcustom_list_ModelCustomId] isKindOfClass:[NSNull class]]){
		self.customId = dictionary[kcustom_list_ModelCustomId];
	}	
	if(![dictionary[kcustom_list_ModelEndTime] isKindOfClass:[NSNull class]]){
		self.endTime = dictionary[kcustom_list_ModelEndTime];
	}	
	if(![dictionary[kcustom_list_ModelStaffId] isKindOfClass:[NSNull class]]){
		self.staffId = dictionary[kcustom_list_ModelStaffId];
	}	
	if(![dictionary[kcustom_list_ModelStartTime] isKindOfClass:[NSNull class]]){
		self.startTime = dictionary[kcustom_list_ModelStartTime];
	}	
	if(![dictionary[kcustom_list_ModelState] isKindOfClass:[NSNull class]]){
		self.state = [dictionary[kcustom_list_ModelState] integerValue];
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
		dictionary[kcustom_list_ModelIdField] = self.idField;
	}
	if(self.customId != nil){
		dictionary[kcustom_list_ModelCustomId] = self.customId;
	}
	if(self.endTime != nil){
		dictionary[kcustom_list_ModelEndTime] = self.endTime;
	}
	if(self.staffId != nil){
		dictionary[kcustom_list_ModelStaffId] = self.staffId;
	}
	if(self.startTime != nil){
		dictionary[kcustom_list_ModelStartTime] = self.startTime;
	}
	dictionary[kcustom_list_ModelState] = @(self.state);
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
		[aCoder encodeObject:self.idField forKey:kcustom_list_ModelIdField];
	}
	if(self.customId != nil){
		[aCoder encodeObject:self.customId forKey:kcustom_list_ModelCustomId];
	}
	if(self.endTime != nil){
		[aCoder encodeObject:self.endTime forKey:kcustom_list_ModelEndTime];
	}
	if(self.staffId != nil){
		[aCoder encodeObject:self.staffId forKey:kcustom_list_ModelStaffId];
	}
	if(self.startTime != nil){
		[aCoder encodeObject:self.startTime forKey:kcustom_list_ModelStartTime];
	}
	[aCoder encodeObject:@(self.state) forKey:kcustom_list_ModelState];
}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.idField = [aDecoder decodeObjectForKey:kcustom_list_ModelIdField];
	self.customId = [aDecoder decodeObjectForKey:kcustom_list_ModelCustomId];
	self.endTime = [aDecoder decodeObjectForKey:kcustom_list_ModelEndTime];
	self.staffId = [aDecoder decodeObjectForKey:kcustom_list_ModelStaffId];
	self.startTime = [aDecoder decodeObjectForKey:kcustom_list_ModelStartTime];
	self.state = [[aDecoder decodeObjectForKey:kcustom_list_ModelState] integerValue];
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	custom_list_Model *copy = [custom_list_Model new];

	copy.idField = [self.idField copy];
	copy.customId = [self.customId copy];
	copy.endTime = [self.endTime copy];
	copy.staffId = [self.staffId copy];
	copy.startTime = [self.startTime copy];
	copy.state = self.state;

	return copy;
}
@end