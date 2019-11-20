//
//	WeChatModel.m
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "WeChatModel.h"

NSString *const kWeChatModelIdField = @"_id";
NSString *const kWeChatModelBindAt = @"bind_at";
NSString *const kWeChatModelCreatedAt = @"created_at";
NSString *const kWeChatModelGender = @"gender";
NSString *const kWeChatModelIconurl = @"iconurl";
NSString *const kWeChatModelNickName = @"nick_name";
NSString *const kWeChatModelOpenId = @"open_id";
NSString *const kWeChatModelState = @"state";
NSString *const kWeChatModelUnionId = @"union_id";
NSString *const kWeChatModelUpdatedAt = @"updated_at";

@interface WeChatModel ()
@end
@implementation WeChatModel

- (BOOL)isBindWeChat
{
    return self.state = 100;
}

/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[kWeChatModelIdField] isKindOfClass:[NSNull class]]){
		self.idField = dictionary[kWeChatModelIdField];
	}	
	if(![dictionary[kWeChatModelBindAt] isKindOfClass:[NSNull class]]){
		self.bindAt = dictionary[kWeChatModelBindAt];
	}	
	if(![dictionary[kWeChatModelCreatedAt] isKindOfClass:[NSNull class]]){
		self.createdAt = dictionary[kWeChatModelCreatedAt];
	}	
	if(![dictionary[kWeChatModelGender] isKindOfClass:[NSNull class]]){
		self.gender = [dictionary[kWeChatModelGender] integerValue];
	}

	if(![dictionary[kWeChatModelIconurl] isKindOfClass:[NSNull class]]){
		self.iconurl = dictionary[kWeChatModelIconurl];
	}	
	if(![dictionary[kWeChatModelNickName] isKindOfClass:[NSNull class]]){
		self.nickName = dictionary[kWeChatModelNickName];
	}	
	if(![dictionary[kWeChatModelOpenId] isKindOfClass:[NSNull class]]){
		self.openId = dictionary[kWeChatModelOpenId];
	}	
	if(![dictionary[kWeChatModelState] isKindOfClass:[NSNull class]]){
		self.state = [dictionary[kWeChatModelState] integerValue];
	}

	if(![dictionary[kWeChatModelUnionId] isKindOfClass:[NSNull class]]){
		self.unionId = dictionary[kWeChatModelUnionId];
	}	
	if(![dictionary[kWeChatModelUpdatedAt] isKindOfClass:[NSNull class]]){
		self.updatedAt = dictionary[kWeChatModelUpdatedAt];
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
		dictionary[kWeChatModelIdField] = self.idField;
	}
	if(self.bindAt != nil){
		dictionary[kWeChatModelBindAt] = self.bindAt;
	}
	if(self.createdAt != nil){
		dictionary[kWeChatModelCreatedAt] = self.createdAt;
	}
	dictionary[kWeChatModelGender] = @(self.gender);
	if(self.iconurl != nil){
		dictionary[kWeChatModelIconurl] = self.iconurl;
	}
	if(self.nickName != nil){
		dictionary[kWeChatModelNickName] = self.nickName;
	}
	if(self.openId != nil){
		dictionary[kWeChatModelOpenId] = self.openId;
	}
	dictionary[kWeChatModelState] = @(self.state);
	if(self.unionId != nil){
		dictionary[kWeChatModelUnionId] = self.unionId;
	}
	if(self.updatedAt != nil){
		dictionary[kWeChatModelUpdatedAt] = self.updatedAt;
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
		[aCoder encodeObject:self.idField forKey:kWeChatModelIdField];
	}
	if(self.bindAt != nil){
		[aCoder encodeObject:self.bindAt forKey:kWeChatModelBindAt];
	}
	if(self.createdAt != nil){
		[aCoder encodeObject:self.createdAt forKey:kWeChatModelCreatedAt];
	}
	[aCoder encodeObject:@(self.gender) forKey:kWeChatModelGender];	if(self.iconurl != nil){
		[aCoder encodeObject:self.iconurl forKey:kWeChatModelIconurl];
	}
	if(self.nickName != nil){
		[aCoder encodeObject:self.nickName forKey:kWeChatModelNickName];
	}
	if(self.openId != nil){
		[aCoder encodeObject:self.openId forKey:kWeChatModelOpenId];
	}
	[aCoder encodeObject:@(self.state) forKey:kWeChatModelState];	if(self.unionId != nil){
		[aCoder encodeObject:self.unionId forKey:kWeChatModelUnionId];
	}
	if(self.updatedAt != nil){
		[aCoder encodeObject:self.updatedAt forKey:kWeChatModelUpdatedAt];
	}

}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.idField = [aDecoder decodeObjectForKey:kWeChatModelIdField];
	self.bindAt = [aDecoder decodeObjectForKey:kWeChatModelBindAt];
	self.createdAt = [aDecoder decodeObjectForKey:kWeChatModelCreatedAt];
	self.gender = [[aDecoder decodeObjectForKey:kWeChatModelGender] integerValue];
	self.iconurl = [aDecoder decodeObjectForKey:kWeChatModelIconurl];
	self.nickName = [aDecoder decodeObjectForKey:kWeChatModelNickName];
	self.openId = [aDecoder decodeObjectForKey:kWeChatModelOpenId];
	self.state = [[aDecoder decodeObjectForKey:kWeChatModelState] integerValue];
	self.unionId = [aDecoder decodeObjectForKey:kWeChatModelUnionId];
	self.updatedAt = [aDecoder decodeObjectForKey:kWeChatModelUpdatedAt];
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	WeChatModel *copy = [WeChatModel new];

	copy.idField = [self.idField copy];
	copy.bindAt = [self.bindAt copy];
	copy.createdAt = [self.createdAt copy];
	copy.gender = self.gender;
	copy.iconurl = [self.iconurl copy];
	copy.nickName = [self.nickName copy];
	copy.openId = [self.openId copy];
	copy.state = self.state;
	copy.unionId = [self.unionId copy];
	copy.updatedAt = [self.updatedAt copy];

	return copy;
}
@end
