//
//	recordModel.m
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "recordModel.h"

NSString *const krecordModelIdField = @"_id";
NSString *const krecordModelAccountId = @"account_id";
NSString *const krecordModelCreatedAt = @"created_at";
NSString *const krecordModelIsPin = @"is_pin";
NSString *const krecordModelNickName = @"nick_name";
NSString *const krecordModelNoDisturb = @"no_disturb";
NSString *const krecordModelState = @"state";
NSString *const krecordModelTargetId = @"target_id";
NSString *const krecordModelTargetType = @"target_type";
NSString *const krecordModelUpdatedAt = @"updated_at";

@interface recordModel ()
@end
@implementation recordModel




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
    if ([dictionary isKindOfClass:[NSNull class]]) {
        return self;
    }
	if(![dictionary[krecordModelIdField] isKindOfClass:[NSNull class]]){
		self.idField = dictionary[krecordModelIdField];
	}	
	if(![dictionary[krecordModelAccountId] isKindOfClass:[NSNull class]]){
		self.accountId = dictionary[krecordModelAccountId];
	}	
	if(![dictionary[krecordModelCreatedAt] isKindOfClass:[NSNull class]]){
		self.createdAt = dictionary[krecordModelCreatedAt];
	}	
	if(![dictionary[krecordModelIsPin] isKindOfClass:[NSNull class]]){
		self.isPin = [dictionary[krecordModelIsPin] boolValue];
	}

	if(![dictionary[krecordModelNickName] isKindOfClass:[NSNull class]]){
		self.nickName = dictionary[krecordModelNickName];
	}	
	if(![dictionary[krecordModelNoDisturb] isKindOfClass:[NSNull class]]){
		self.noDisturb = [dictionary[krecordModelNoDisturb] boolValue];
	}

	if(![dictionary[krecordModelState] isKindOfClass:[NSNull class]]){
		self.state = [dictionary[krecordModelState] integerValue];
	}

	if(![dictionary[krecordModelTargetId] isKindOfClass:[NSNull class]]){
		self.targetId = dictionary[krecordModelTargetId];
	}	
	if(![dictionary[krecordModelTargetType] isKindOfClass:[NSNull class]]){
		self.targetType = [dictionary[krecordModelTargetType] integerValue];
	}

	if(![dictionary[krecordModelUpdatedAt] isKindOfClass:[NSNull class]]){
		self.updatedAt = dictionary[krecordModelUpdatedAt];
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
		dictionary[krecordModelIdField] = self.idField;
	}
	if(self.accountId != nil){
		dictionary[krecordModelAccountId] = self.accountId;
	}
	if(self.createdAt != nil){
		dictionary[krecordModelCreatedAt] = self.createdAt;
	}
	dictionary[krecordModelIsPin] = @(self.isPin);
	if(self.nickName != nil){
		dictionary[krecordModelNickName] = self.nickName;
	}
	dictionary[krecordModelNoDisturb] = @(self.noDisturb);
	dictionary[krecordModelState] = @(self.state);
	if(self.targetId != nil){
		dictionary[krecordModelTargetId] = self.targetId;
	}
	dictionary[krecordModelTargetType] = @(self.targetType);
	if(self.updatedAt != nil){
		dictionary[krecordModelUpdatedAt] = self.updatedAt;
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
		[aCoder encodeObject:self.idField forKey:krecordModelIdField];
	}
	if(self.accountId != nil){
		[aCoder encodeObject:self.accountId forKey:krecordModelAccountId];
	}
	if(self.createdAt != nil){
		[aCoder encodeObject:self.createdAt forKey:krecordModelCreatedAt];
	}
	[aCoder encodeObject:@(self.isPin) forKey:krecordModelIsPin];	if(self.nickName != nil){
		[aCoder encodeObject:self.nickName forKey:krecordModelNickName];
	}
	[aCoder encodeObject:@(self.noDisturb) forKey:krecordModelNoDisturb];	[aCoder encodeObject:@(self.state) forKey:krecordModelState];	if(self.targetId != nil){
		[aCoder encodeObject:self.targetId forKey:krecordModelTargetId];
	}
	[aCoder encodeObject:@(self.targetType) forKey:krecordModelTargetType];	if(self.updatedAt != nil){
		[aCoder encodeObject:self.updatedAt forKey:krecordModelUpdatedAt];
	}

}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.idField = [aDecoder decodeObjectForKey:krecordModelIdField];
	self.accountId = [aDecoder decodeObjectForKey:krecordModelAccountId];
	self.createdAt = [aDecoder decodeObjectForKey:krecordModelCreatedAt];
	self.isPin = [[aDecoder decodeObjectForKey:krecordModelIsPin] boolValue];
	self.nickName = [aDecoder decodeObjectForKey:krecordModelNickName];
	self.noDisturb = [[aDecoder decodeObjectForKey:krecordModelNoDisturb] boolValue];
	self.state = [[aDecoder decodeObjectForKey:krecordModelState] integerValue];
	self.targetId = [aDecoder decodeObjectForKey:krecordModelTargetId];
	self.targetType = [[aDecoder decodeObjectForKey:krecordModelTargetType] integerValue];
	self.updatedAt = [aDecoder decodeObjectForKey:krecordModelUpdatedAt];
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	recordModel *copy = [recordModel new];

	copy.idField = [self.idField copy];
	copy.accountId = [self.accountId copy];
	copy.createdAt = [self.createdAt copy];
	copy.isPin = self.isPin;
	copy.nickName = [self.nickName copy];
	copy.noDisturb = self.noDisturb;
	copy.state = self.state;
	copy.targetId = [self.targetId copy];
	copy.targetType = self.targetType;
	copy.updatedAt = [self.updatedAt copy];

	return copy;
}
@end
