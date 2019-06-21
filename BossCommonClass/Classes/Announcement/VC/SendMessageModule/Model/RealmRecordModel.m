//
//	RealmRecordModel.m
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "RealmRecordModel.h"
#import "realmMessageModel.h"

@interface RealmRecordModel ()
@end
@implementation RealmRecordModel




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	if(dictionary == nil || [dictionary isKindOfClass:[NSNull class]]){
		return nil;
	}
	self = [super init];

	if(![dictionary[@"realmMessageModel"] isKindOfClass:[NSNull class]]){
		self.realmMessageModel = [[realmMessageModel alloc] initWithDictionary:dictionary[@"realmMessageModel"]];
	}

	if(![dictionary[@"_id"] isKindOfClass:[NSNull class]]){
		self.idField = dictionary[@"_id"];
	}

	if(![dictionary[@"content"] isKindOfClass:[NSNull class]]){
		self.content = dictionary[@"content"];
	}

	if(![dictionary[@"created_at"] isKindOfClass:[NSNull class]]){
		self.createdAt = dictionary[@"created_at"];
	}

	if(![dictionary[@"extra_data"] isKindOfClass:[NSNull class]]){
		self.extraData = dictionary[@"extra_data"];
	}

	if(![dictionary[@"extra_type"] isKindOfClass:[NSNull class]]){
		self.extraType = dictionary[@"extra_type"];
	}

	if(![dictionary[@"group_id"] isKindOfClass:[NSNull class]]){
		self.groupId = dictionary[@"group_id"];
	}

	if(![dictionary[@"media_info_list"] isKindOfClass:[NSNull class]]){
		self.mediaInfoList = dictionary[@"media_info_list"];
	}

	if(![dictionary[@"message_mime_kind"] isKindOfClass:[NSNull class]]){
		self.messageMimeKind = [dictionary[@"message_mime_kind"] integerValue];
	}

	if(![dictionary[@"message_type"] isKindOfClass:[NSNull class]]){
		self.messageType = [dictionary[@"message_type"] integerValue];
	}

	if(![dictionary[@"proxy_id"] isKindOfClass:[NSNull class]]){
		self.proxyId = dictionary[@"proxy_id"];
	}

	if(![dictionary[@"sender_id"] isKindOfClass:[NSNull class]]){
		self.senderId = dictionary[@"sender_id"];
	}

	if(![dictionary[@"state"] isKindOfClass:[NSNull class]]){
		self.state = [dictionary[@"state"] integerValue];
	}

	if(![dictionary[@"title"] isKindOfClass:[NSNull class]]){
		self.title = dictionary[@"title"];
	}

	if(![dictionary[@"updated_at"] isKindOfClass:[NSNull class]]){
		self.updatedAt = dictionary[@"updated_at"];
	}

	return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	if(self.realmMessageModel != nil){
		dictionary[@"realmMessageModel"] = [self.realmMessageModel toDictionary];
	}
	if(self.idField != nil){
		dictionary[@"_id"] = self.idField;
	}
	if(self.content != nil){
		dictionary[@"content"] = self.content;
	}
	if(self.createdAt != nil){
		dictionary[@"created_at"] = self.createdAt;
	}
	if(self.extraData != nil){
		dictionary[@"extra_data"] = self.extraData;
	}
	if(self.extraType != nil){
		dictionary[@"extra_type"] = self.extraType;
	}
	if(self.groupId != nil){
		dictionary[@"group_id"] = self.groupId;
	}
	if(self.mediaInfoList != nil){
		dictionary[@"media_info_list"] = self.mediaInfoList;
	}
	dictionary[@"message_mime_kind"] = @(self.messageMimeKind);
	dictionary[@"message_type"] = @(self.messageType);
	if(self.proxyId != nil){
		dictionary[@"proxy_id"] = self.proxyId;
	}
	if(self.senderId != nil){
		dictionary[@"sender_id"] = self.senderId;
	}
	dictionary[@"state"] = @(self.state);
	if(self.title != nil){
		dictionary[@"title"] = self.title;
	}
	if(self.updatedAt != nil){
		dictionary[@"updated_at"] = self.updatedAt;
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
	if(self.realmMessageModel != nil){
		[aCoder encodeObject:self.realmMessageModel forKey:@"realmMessageModel"];
	}
	if(self.idField != nil){
		[aCoder encodeObject:self.idField forKey:@"_id"];
	}
	if(self.content != nil){
		[aCoder encodeObject:self.content forKey:@"content"];
	}
	if(self.createdAt != nil){
		[aCoder encodeObject:self.createdAt forKey:@"created_at"];
	}
	if(self.extraData != nil){
		[aCoder encodeObject:self.extraData forKey:@"extra_data"];
	}
	if(self.extraType != nil){
		[aCoder encodeObject:self.extraType forKey:@"extra_type"];
	}
	if(self.groupId != nil){
		[aCoder encodeObject:self.groupId forKey:@"group_id"];
	}
	if(self.mediaInfoList != nil){
		[aCoder encodeObject:self.mediaInfoList forKey:@"media_info_list"];
	}
	[aCoder encodeObject:@(self.messageMimeKind) forKey:@"message_mime_kind"];	[aCoder encodeObject:@(self.messageType) forKey:@"message_type"];	if(self.proxyId != nil){
		[aCoder encodeObject:self.proxyId forKey:@"proxy_id"];
	}
	if(self.senderId != nil){
		[aCoder encodeObject:self.senderId forKey:@"sender_id"];
	}
	[aCoder encodeObject:@(self.state) forKey:@"state"];	if(self.title != nil){
		[aCoder encodeObject:self.title forKey:@"title"];
	}
	if(self.updatedAt != nil){
		[aCoder encodeObject:self.updatedAt forKey:@"updated_at"];
	}

}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.realmMessageModel = [aDecoder decodeObjectForKey:@"realmMessageModel"];
	self.idField = [aDecoder decodeObjectForKey:@"_id"];
	self.content = [aDecoder decodeObjectForKey:@"content"];
	self.createdAt = [aDecoder decodeObjectForKey:@"created_at"];
	self.extraData = [aDecoder decodeObjectForKey:@"extra_data"];
	self.extraType = [aDecoder decodeObjectForKey:@"extra_type"];
	self.groupId = [aDecoder decodeObjectForKey:@"group_id"];
	self.mediaInfoList = [aDecoder decodeObjectForKey:@"media_info_list"];
	self.messageMimeKind = [[aDecoder decodeObjectForKey:@"message_mime_kind"] integerValue];
	self.messageType = [[aDecoder decodeObjectForKey:@"message_type"] integerValue];
	self.proxyId = [aDecoder decodeObjectForKey:@"proxy_id"];
	self.senderId = [aDecoder decodeObjectForKey:@"sender_id"];
	self.state = [[aDecoder decodeObjectForKey:@"state"] integerValue];
	self.title = [aDecoder decodeObjectForKey:@"title"];
	self.updatedAt = [aDecoder decodeObjectForKey:@"updated_at"];
	return self;

}
@end