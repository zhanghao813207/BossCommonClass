//
//	LeavePostList.m
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "LeavePostList.h"

NSString *const kLeavePostListIdField = @"_id";
NSString *const kLeavePostListAccountIds = @"account_ids";
NSString *const kLeavePostListAccountInfoList = @"account_info_list";
NSString *const kLeavePostListCreatedAt = @"created_at";
NSString *const kLeavePostListCreatorId = @"creator_id";
NSString *const kLeavePostListCreatorInfo = @"creator_info";
NSString *const kLeavePostListOperatorId = @"operator_id";
NSString *const kLeavePostListOperatorInfo = @"operator_info";
NSString *const kLeavePostListPostName = @"post_name";
NSString *const kLeavePostListState = @"state";
NSString *const kLeavePostListType = @"type";
NSString *const kLeavePostListUpdatedAt = @"updated_at";

@interface LeavePostList ()
@end
@implementation LeavePostList




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[kLeavePostListIdField] isKindOfClass:[NSNull class]]){
		self.idField = dictionary[kLeavePostListIdField];
	}	
	if(![dictionary[kLeavePostListAccountIds] isKindOfClass:[NSNull class]]){
		self.accountIds = dictionary[kLeavePostListAccountIds];
	}	
	if(dictionary[kLeavePostListAccountInfoList] != nil && [dictionary[kLeavePostListAccountInfoList] isKindOfClass:[NSArray class]]){
		NSArray * accountInfoListDictionaries = dictionary[kLeavePostListAccountInfoList];
		NSMutableArray * accountInfoListItems = [NSMutableArray array];
		for(NSDictionary * accountInfoListDictionary in accountInfoListDictionaries){
			LeaveAccountInfoList * accountInfoListItem = [[LeaveAccountInfoList alloc] initWithDictionary:accountInfoListDictionary];
			[accountInfoListItems addObject:accountInfoListItem];
		}
		self.accountInfoList = accountInfoListItems;
	}
	if(![dictionary[kLeavePostListCreatedAt] isKindOfClass:[NSNull class]]){
		self.createdAt = dictionary[kLeavePostListCreatedAt];
	}	
	if(![dictionary[kLeavePostListCreatorId] isKindOfClass:[NSNull class]]){
		self.creatorId = dictionary[kLeavePostListCreatorId];
	}	
	if(![dictionary[kLeavePostListCreatorInfo] isKindOfClass:[NSNull class]]){
		self.creatorInfo = [[LeaveAccountInfoList alloc] initWithDictionary:dictionary[kLeavePostListCreatorInfo]];
	}

	if(![dictionary[kLeavePostListOperatorId] isKindOfClass:[NSNull class]]){
		self.operatorId = dictionary[kLeavePostListOperatorId];
	}	
	if(![dictionary[kLeavePostListOperatorInfo] isKindOfClass:[NSNull class]]){
		self.operatorInfo = [[LeaveAccountInfoList alloc] initWithDictionary:dictionary[kLeavePostListOperatorInfo]];
	}

	if(![dictionary[kLeavePostListPostName] isKindOfClass:[NSNull class]]){
		self.postName = dictionary[kLeavePostListPostName];
	}	
	if(![dictionary[kLeavePostListState] isKindOfClass:[NSNull class]]){
		self.state = [dictionary[kLeavePostListState] integerValue];
	}

	if(![dictionary[kLeavePostListType] isKindOfClass:[NSNull class]]){
		self.type = dictionary[kLeavePostListType];
	}	
	if(![dictionary[kLeavePostListUpdatedAt] isKindOfClass:[NSNull class]]){
		self.updatedAt = dictionary[kLeavePostListUpdatedAt];
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
		dictionary[kLeavePostListIdField] = self.idField;
	}
	if(self.accountIds != nil){
		dictionary[kLeavePostListAccountIds] = self.accountIds;
	}
	if(self.accountInfoList != nil){
		NSMutableArray * dictionaryElements = [NSMutableArray array];
		for(LeaveAccountInfoList * accountInfoListElement in self.accountInfoList){
			[dictionaryElements addObject:[accountInfoListElement toDictionary]];
		}
		dictionary[kLeavePostListAccountInfoList] = dictionaryElements;
	}
	if(self.createdAt != nil){
		dictionary[kLeavePostListCreatedAt] = self.createdAt;
	}
	if(self.creatorId != nil){
		dictionary[kLeavePostListCreatorId] = self.creatorId;
	}
	if(self.creatorInfo != nil){
		dictionary[kLeavePostListCreatorInfo] = [self.creatorInfo toDictionary];
	}
	if(self.operatorId != nil){
		dictionary[kLeavePostListOperatorId] = self.operatorId;
	}
	if(self.operatorInfo != nil){
		dictionary[kLeavePostListOperatorInfo] = [self.operatorInfo toDictionary];
	}
	if(self.postName != nil){
		dictionary[kLeavePostListPostName] = self.postName;
	}
	dictionary[kLeavePostListState] = @(self.state);
	if(self.type != nil){
		dictionary[kLeavePostListType] = self.type;
	}
	if(self.updatedAt != nil){
		dictionary[kLeavePostListUpdatedAt] = self.updatedAt;
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
		[aCoder encodeObject:self.idField forKey:kLeavePostListIdField];
	}
	if(self.accountIds != nil){
		[aCoder encodeObject:self.accountIds forKey:kLeavePostListAccountIds];
	}
	if(self.accountInfoList != nil){
		[aCoder encodeObject:self.accountInfoList forKey:kLeavePostListAccountInfoList];
	}
	if(self.createdAt != nil){
		[aCoder encodeObject:self.createdAt forKey:kLeavePostListCreatedAt];
	}
	if(self.creatorId != nil){
		[aCoder encodeObject:self.creatorId forKey:kLeavePostListCreatorId];
	}
	if(self.creatorInfo != nil){
		[aCoder encodeObject:self.creatorInfo forKey:kLeavePostListCreatorInfo];
	}
	if(self.operatorId != nil){
		[aCoder encodeObject:self.operatorId forKey:kLeavePostListOperatorId];
	}
	if(self.operatorInfo != nil){
		[aCoder encodeObject:self.operatorInfo forKey:kLeavePostListOperatorInfo];
	}
	if(self.postName != nil){
		[aCoder encodeObject:self.postName forKey:kLeavePostListPostName];
	}
	[aCoder encodeObject:@(self.state) forKey:kLeavePostListState];	if(self.type != nil){
		[aCoder encodeObject:self.type forKey:kLeavePostListType];
	}
	if(self.updatedAt != nil){
		[aCoder encodeObject:self.updatedAt forKey:kLeavePostListUpdatedAt];
	}

}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.idField = [aDecoder decodeObjectForKey:kLeavePostListIdField];
	self.accountIds = [aDecoder decodeObjectForKey:kLeavePostListAccountIds];
	self.accountInfoList = [aDecoder decodeObjectForKey:kLeavePostListAccountInfoList];
	self.createdAt = [aDecoder decodeObjectForKey:kLeavePostListCreatedAt];
	self.creatorId = [aDecoder decodeObjectForKey:kLeavePostListCreatorId];
	self.creatorInfo = [aDecoder decodeObjectForKey:kLeavePostListCreatorInfo];
	self.operatorId = [aDecoder decodeObjectForKey:kLeavePostListOperatorId];
	self.operatorInfo = [aDecoder decodeObjectForKey:kLeavePostListOperatorInfo];
	self.postName = [aDecoder decodeObjectForKey:kLeavePostListPostName];
	self.state = [[aDecoder decodeObjectForKey:kLeavePostListState] integerValue];
	self.type = [aDecoder decodeObjectForKey:kLeavePostListType];
	self.updatedAt = [aDecoder decodeObjectForKey:kLeavePostListUpdatedAt];
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	LeavePostList *copy = [LeavePostList new];

	copy.idField = [self.idField copy];
	copy.accountIds = [self.accountIds copy];
	copy.accountInfoList = [self.accountInfoList copy];
	copy.createdAt = [self.createdAt copy];
	copy.creatorId = [self.creatorId copy];
	copy.creatorInfo = [self.creatorInfo copy];
	copy.operatorId = [self.operatorId copy];
	copy.operatorInfo = [self.operatorInfo copy];
	copy.postName = [self.postName copy];
	copy.state = self.state;
	copy.type = [self.type copy];
	copy.updatedAt = [self.updatedAt copy];

	return copy;
}
@end