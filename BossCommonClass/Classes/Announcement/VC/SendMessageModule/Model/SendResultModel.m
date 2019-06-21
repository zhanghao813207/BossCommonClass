//
//	SendResultModel.m
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "SendResultModel.h"

NSString *const kSendResultModelIdField = @"_id";
NSString *const kSendResultModelContent = @"content";
NSString *const kSendResultModelCreatedAt = @"created_at";
NSString *const kSendResultModelExtraData = @"extra_data";
NSString *const kSendResultModelExtraType = @"extra_type";
NSString *const kSendResultModelGroupId = @"group_id";
NSString *const kSendResultModelMediaInfoList = @"media_info_list";
NSString *const kSendResultModelMessageMimeKind = @"message_mime_kind";
NSString *const kSendResultModelMessageType = @"message_type";
NSString *const kSendResultModelProxyId = @"proxy_id";
NSString *const kSendResultModelSenderId = @"sender_id";
NSString *const kSendResultModelState = @"state";
NSString *const kSendResultModelTitle = @"title";
NSString *const kSendResultModelUpdatedAt = @"updated_at";

@interface SendResultModel ()
@end
@implementation SendResultModel




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[kSendResultModelIdField] isKindOfClass:[NSNull class]]){
		self.idField = dictionary[kSendResultModelIdField];
	}	
	if(![dictionary[kSendResultModelContent] isKindOfClass:[NSNull class]]){
		self.content = dictionary[kSendResultModelContent];
	}	
	if(![dictionary[kSendResultModelCreatedAt] isKindOfClass:[NSNull class]]){
		self.createdAt = dictionary[kSendResultModelCreatedAt];
	}	
	if(![dictionary[kSendResultModelExtraData] isKindOfClass:[NSNull class]]){
		self.extraData = dictionary[kSendResultModelExtraData];
	}	
	if(![dictionary[kSendResultModelExtraType] isKindOfClass:[NSNull class]]){
		self.extraType = dictionary[kSendResultModelExtraType];
	}	
	if(![dictionary[kSendResultModelGroupId] isKindOfClass:[NSNull class]]){
		self.groupId = dictionary[kSendResultModelGroupId];
	}	
	if(![dictionary[kSendResultModelMediaInfoList] isKindOfClass:[NSNull class]]){
		self.mediaInfoList = dictionary[kSendResultModelMediaInfoList];
	}	
	if(![dictionary[kSendResultModelMessageMimeKind] isKindOfClass:[NSNull class]]){
		self.messageMimeKind = [dictionary[kSendResultModelMessageMimeKind] integerValue];
	}

	if(![dictionary[kSendResultModelMessageType] isKindOfClass:[NSNull class]]){
		self.messageType = [dictionary[kSendResultModelMessageType] integerValue];
	}

	if(![dictionary[kSendResultModelProxyId] isKindOfClass:[NSNull class]]){
		self.proxyId = dictionary[kSendResultModelProxyId];
	}	
	if(![dictionary[kSendResultModelSenderId] isKindOfClass:[NSNull class]]){
		self.senderId = dictionary[kSendResultModelSenderId];
	}	
	if(![dictionary[kSendResultModelState] isKindOfClass:[NSNull class]]){
		self.state = [dictionary[kSendResultModelState] integerValue];
	}

	if(![dictionary[kSendResultModelTitle] isKindOfClass:[NSNull class]]){
		self.title = dictionary[kSendResultModelTitle];
	}	
	if(![dictionary[kSendResultModelUpdatedAt] isKindOfClass:[NSNull class]]){
		self.updatedAt = dictionary[kSendResultModelUpdatedAt];
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
		dictionary[kSendResultModelIdField] = self.idField;
	}
	if(self.content != nil){
		dictionary[kSendResultModelContent] = self.content;
	}
	if(self.createdAt != nil){
		dictionary[kSendResultModelCreatedAt] = self.createdAt;
	}
	if(self.extraData != nil){
		dictionary[kSendResultModelExtraData] = self.extraData;
	}
	if(self.extraType != nil){
		dictionary[kSendResultModelExtraType] = self.extraType;
	}
	if(self.groupId != nil){
		dictionary[kSendResultModelGroupId] = self.groupId;
	}
	if(self.mediaInfoList != nil){
		dictionary[kSendResultModelMediaInfoList] = self.mediaInfoList;
	}
	dictionary[kSendResultModelMessageMimeKind] = @(self.messageMimeKind);
	dictionary[kSendResultModelMessageType] = @(self.messageType);
	if(self.proxyId != nil){
		dictionary[kSendResultModelProxyId] = self.proxyId;
	}
	if(self.senderId != nil){
		dictionary[kSendResultModelSenderId] = self.senderId;
	}
	dictionary[kSendResultModelState] = @(self.state);
	if(self.title != nil){
		dictionary[kSendResultModelTitle] = self.title;
	}
	if(self.updatedAt != nil){
		dictionary[kSendResultModelUpdatedAt] = self.updatedAt;
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
		[aCoder encodeObject:self.idField forKey:kSendResultModelIdField];
	}
	if(self.content != nil){
		[aCoder encodeObject:self.content forKey:kSendResultModelContent];
	}
	if(self.createdAt != nil){
		[aCoder encodeObject:self.createdAt forKey:kSendResultModelCreatedAt];
	}
	if(self.extraData != nil){
		[aCoder encodeObject:self.extraData forKey:kSendResultModelExtraData];
	}
	if(self.extraType != nil){
		[aCoder encodeObject:self.extraType forKey:kSendResultModelExtraType];
	}
	if(self.groupId != nil){
		[aCoder encodeObject:self.groupId forKey:kSendResultModelGroupId];
	}
	if(self.mediaInfoList != nil){
		[aCoder encodeObject:self.mediaInfoList forKey:kSendResultModelMediaInfoList];
	}
	[aCoder encodeObject:@(self.messageMimeKind) forKey:kSendResultModelMessageMimeKind];	[aCoder encodeObject:@(self.messageType) forKey:kSendResultModelMessageType];	if(self.proxyId != nil){
		[aCoder encodeObject:self.proxyId forKey:kSendResultModelProxyId];
	}
	if(self.senderId != nil){
		[aCoder encodeObject:self.senderId forKey:kSendResultModelSenderId];
	}
	[aCoder encodeObject:@(self.state) forKey:kSendResultModelState];	if(self.title != nil){
		[aCoder encodeObject:self.title forKey:kSendResultModelTitle];
	}
	if(self.updatedAt != nil){
		[aCoder encodeObject:self.updatedAt forKey:kSendResultModelUpdatedAt];
	}

}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.idField = [aDecoder decodeObjectForKey:kSendResultModelIdField];
	self.content = [aDecoder decodeObjectForKey:kSendResultModelContent];
	self.createdAt = [aDecoder decodeObjectForKey:kSendResultModelCreatedAt];
	self.extraData = [aDecoder decodeObjectForKey:kSendResultModelExtraData];
	self.extraType = [aDecoder decodeObjectForKey:kSendResultModelExtraType];
	self.groupId = [aDecoder decodeObjectForKey:kSendResultModelGroupId];
	self.mediaInfoList = [aDecoder decodeObjectForKey:kSendResultModelMediaInfoList];
	self.messageMimeKind = [[aDecoder decodeObjectForKey:kSendResultModelMessageMimeKind] integerValue];
	self.messageType = [[aDecoder decodeObjectForKey:kSendResultModelMessageType] integerValue];
	self.proxyId = [aDecoder decodeObjectForKey:kSendResultModelProxyId];
	self.senderId = [aDecoder decodeObjectForKey:kSendResultModelSenderId];
	self.state = [[aDecoder decodeObjectForKey:kSendResultModelState] integerValue];
	self.title = [aDecoder decodeObjectForKey:kSendResultModelTitle];
	self.updatedAt = [aDecoder decodeObjectForKey:kSendResultModelUpdatedAt];
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	SendResultModel *copy = [SendResultModel new];

	copy.idField = [self.idField copy];
	copy.content = [self.content copy];
	copy.createdAt = [self.createdAt copy];
	copy.extraData = [self.extraData copy];
	copy.extraType = [self.extraType copy];
	copy.groupId = [self.groupId copy];
	copy.mediaInfoList = [self.mediaInfoList copy];
	copy.messageMimeKind = self.messageMimeKind;
	copy.messageType = self.messageType;
	copy.proxyId = [self.proxyId copy];
	copy.senderId = [self.senderId copy];
	copy.state = self.state;
	copy.title = [self.title copy];
	copy.updatedAt = [self.updatedAt copy];

	return copy;
}
@end