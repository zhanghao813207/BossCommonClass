//
//	AuditListModel.m
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "AuditListModel.h"

NSString *const kAuditListModelIdField = @"_id";
NSString *const kAuditListModelAccountInfo = @"account_info";
NSString *const kAuditListModelBirthDate = @"birth_date";
NSString *const kAuditListModelCreatedAt = @"created_at";
NSString *const kAuditListModelGenderId = @"gender_id";
NSString *const kAuditListModelHandBustUrl = @"hand_bust_url";
NSString *const kAuditListModelIdcardEndDate = @"idcard_end_date";
NSString *const kAuditListModelIdcardStartDate = @"idcard_start_date";
NSString *const kAuditListModelIdcardType = @"idcard_type";
NSString *const kAuditListModelIdentityCardBackUrl = @"identity_card_back_url";
NSString *const kAuditListModelIdentityCardFrontUrl = @"identity_card_front_url";
NSString *const kAuditListModelIdentityCardId = @"identity_card_id";
NSString *const kAuditListModelName = @"name";
NSString *const kAuditListModelNational = @"national";
NSString *const kAuditListModelReason = @"reason";
NSString *const kAuditListModelState = @"state";
NSString *const kAuditListModelType = @"type";
NSString *const kAuditListModelUpdatedAt = @"updated_at";

@interface AuditListModel ()
@end
@implementation AuditListModel




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[kAuditListModelIdField] isKindOfClass:[NSNull class]]){
		self.idField = dictionary[kAuditListModelIdField];
	}	
	if(![dictionary[kAuditListModelAccountInfo] isKindOfClass:[NSNull class]]){
		self.accountInfo = [[AuditAccountInfo alloc] initWithDictionary:dictionary[kAuditListModelAccountInfo]];
	}

	if(![dictionary[kAuditListModelBirthDate] isKindOfClass:[NSNull class]]){
		self.birthDate = dictionary[kAuditListModelBirthDate];
	}	
	if(![dictionary[kAuditListModelCreatedAt] isKindOfClass:[NSNull class]]){
		self.createdAt = dictionary[kAuditListModelCreatedAt];
	}	
	if(![dictionary[kAuditListModelGenderId] isKindOfClass:[NSNull class]]){
		self.genderId = dictionary[kAuditListModelGenderId];
	}	
	if(![dictionary[kAuditListModelHandBustUrl] isKindOfClass:[NSNull class]]){
		self.handBustUrl = dictionary[kAuditListModelHandBustUrl];
	}	
	if(![dictionary[kAuditListModelIdcardEndDate] isKindOfClass:[NSNull class]]){
		self.idcardEndDate = dictionary[kAuditListModelIdcardEndDate];
	}	
	if(![dictionary[kAuditListModelIdcardStartDate] isKindOfClass:[NSNull class]]){
		self.idcardStartDate = dictionary[kAuditListModelIdcardStartDate];
	}	
	if(![dictionary[kAuditListModelIdcardType] isKindOfClass:[NSNull class]]){
		self.idcardType = dictionary[kAuditListModelIdcardType];
	}	
	if(![dictionary[kAuditListModelIdentityCardBackUrl] isKindOfClass:[NSNull class]]){
		self.identityCardBackUrl = dictionary[kAuditListModelIdentityCardBackUrl];
	}	
	if(![dictionary[kAuditListModelIdentityCardFrontUrl] isKindOfClass:[NSNull class]]){
		self.identityCardFrontUrl = dictionary[kAuditListModelIdentityCardFrontUrl];
	}	
	if(![dictionary[kAuditListModelIdentityCardId] isKindOfClass:[NSNull class]]){
		self.identityCardId = dictionary[kAuditListModelIdentityCardId];
	}	
	if(![dictionary[kAuditListModelName] isKindOfClass:[NSNull class]]){
		self.name = dictionary[kAuditListModelName];
	}	
	if(![dictionary[kAuditListModelNational] isKindOfClass:[NSNull class]]){
		self.national = dictionary[kAuditListModelNational];
	}	
	if(![dictionary[kAuditListModelReason] isKindOfClass:[NSNull class]]){
		self.reason = dictionary[kAuditListModelReason];
	}	
	if(![dictionary[kAuditListModelState] isKindOfClass:[NSNull class]]){
		self.state = [dictionary[kAuditListModelState] integerValue];
	}

	if(![dictionary[kAuditListModelType] isKindOfClass:[NSNull class]]){
		self.type = [dictionary[kAuditListModelType] integerValue];
	}

	if(![dictionary[kAuditListModelUpdatedAt] isKindOfClass:[NSNull class]]){
		self.updatedAt = dictionary[kAuditListModelUpdatedAt];
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
		dictionary[kAuditListModelIdField] = self.idField;
	}
	if(self.accountInfo != nil){
		dictionary[kAuditListModelAccountInfo] = [self.accountInfo toDictionary];
	}
	if(self.birthDate != nil){
		dictionary[kAuditListModelBirthDate] = self.birthDate;
	}
	if(self.createdAt != nil){
		dictionary[kAuditListModelCreatedAt] = self.createdAt;
	}
	if(self.genderId != nil){
		dictionary[kAuditListModelGenderId] = self.genderId;
	}
	if(self.handBustUrl != nil){
		dictionary[kAuditListModelHandBustUrl] = self.handBustUrl;
	}
	if(self.idcardEndDate != nil){
		dictionary[kAuditListModelIdcardEndDate] = self.idcardEndDate;
	}
	if(self.idcardStartDate != nil){
		dictionary[kAuditListModelIdcardStartDate] = self.idcardStartDate;
	}
	if(self.idcardType != nil){
		dictionary[kAuditListModelIdcardType] = self.idcardType;
	}
	if(self.identityCardBackUrl != nil){
		dictionary[kAuditListModelIdentityCardBackUrl] = self.identityCardBackUrl;
	}
	if(self.identityCardFrontUrl != nil){
		dictionary[kAuditListModelIdentityCardFrontUrl] = self.identityCardFrontUrl;
	}
	if(self.identityCardId != nil){
		dictionary[kAuditListModelIdentityCardId] = self.identityCardId;
	}
	if(self.name != nil){
		dictionary[kAuditListModelName] = self.name;
	}
	if(self.national != nil){
		dictionary[kAuditListModelNational] = self.national;
	}
	if(self.reason != nil){
		dictionary[kAuditListModelReason] = self.reason;
	}
	dictionary[kAuditListModelState] = @(self.state);
	dictionary[kAuditListModelType] = @(self.type);
	if(self.updatedAt != nil){
		dictionary[kAuditListModelUpdatedAt] = self.updatedAt;
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
		[aCoder encodeObject:self.idField forKey:kAuditListModelIdField];
	}
	if(self.accountInfo != nil){
		[aCoder encodeObject:self.accountInfo forKey:kAuditListModelAccountInfo];
	}
	if(self.birthDate != nil){
		[aCoder encodeObject:self.birthDate forKey:kAuditListModelBirthDate];
	}
	if(self.createdAt != nil){
		[aCoder encodeObject:self.createdAt forKey:kAuditListModelCreatedAt];
	}
	if(self.genderId != nil){
		[aCoder encodeObject:self.genderId forKey:kAuditListModelGenderId];
	}
	if(self.handBustUrl != nil){
		[aCoder encodeObject:self.handBustUrl forKey:kAuditListModelHandBustUrl];
	}
	if(self.idcardEndDate != nil){
		[aCoder encodeObject:self.idcardEndDate forKey:kAuditListModelIdcardEndDate];
	}
	if(self.idcardStartDate != nil){
		[aCoder encodeObject:self.idcardStartDate forKey:kAuditListModelIdcardStartDate];
	}
	if(self.idcardType != nil){
		[aCoder encodeObject:self.idcardType forKey:kAuditListModelIdcardType];
	}
	if(self.identityCardBackUrl != nil){
		[aCoder encodeObject:self.identityCardBackUrl forKey:kAuditListModelIdentityCardBackUrl];
	}
	if(self.identityCardFrontUrl != nil){
		[aCoder encodeObject:self.identityCardFrontUrl forKey:kAuditListModelIdentityCardFrontUrl];
	}
	if(self.identityCardId != nil){
		[aCoder encodeObject:self.identityCardId forKey:kAuditListModelIdentityCardId];
	}
	if(self.name != nil){
		[aCoder encodeObject:self.name forKey:kAuditListModelName];
	}
	if(self.national != nil){
		[aCoder encodeObject:self.national forKey:kAuditListModelNational];
	}
	if(self.reason != nil){
		[aCoder encodeObject:self.reason forKey:kAuditListModelReason];
	}
	[aCoder encodeObject:@(self.state) forKey:kAuditListModelState];	[aCoder encodeObject:@(self.type) forKey:kAuditListModelType];	if(self.updatedAt != nil){
		[aCoder encodeObject:self.updatedAt forKey:kAuditListModelUpdatedAt];
	}

}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.idField = [aDecoder decodeObjectForKey:kAuditListModelIdField];
	self.accountInfo = [aDecoder decodeObjectForKey:kAuditListModelAccountInfo];
	self.birthDate = [aDecoder decodeObjectForKey:kAuditListModelBirthDate];
	self.createdAt = [aDecoder decodeObjectForKey:kAuditListModelCreatedAt];
	self.genderId = [aDecoder decodeObjectForKey:kAuditListModelGenderId];
	self.handBustUrl = [aDecoder decodeObjectForKey:kAuditListModelHandBustUrl];
	self.idcardEndDate = [aDecoder decodeObjectForKey:kAuditListModelIdcardEndDate];
	self.idcardStartDate = [aDecoder decodeObjectForKey:kAuditListModelIdcardStartDate];
	self.idcardType = [aDecoder decodeObjectForKey:kAuditListModelIdcardType];
	self.identityCardBackUrl = [aDecoder decodeObjectForKey:kAuditListModelIdentityCardBackUrl];
	self.identityCardFrontUrl = [aDecoder decodeObjectForKey:kAuditListModelIdentityCardFrontUrl];
	self.identityCardId = [aDecoder decodeObjectForKey:kAuditListModelIdentityCardId];
	self.name = [aDecoder decodeObjectForKey:kAuditListModelName];
	self.national = [aDecoder decodeObjectForKey:kAuditListModelNational];
	self.reason = [aDecoder decodeObjectForKey:kAuditListModelReason];
	self.state = [[aDecoder decodeObjectForKey:kAuditListModelState] integerValue];
	self.type = [[aDecoder decodeObjectForKey:kAuditListModelType] integerValue];
	self.updatedAt = [aDecoder decodeObjectForKey:kAuditListModelUpdatedAt];
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	AuditListModel *copy = [AuditListModel new];

	copy.idField = [self.idField copy];
	copy.accountInfo = [self.accountInfo copy];
	copy.birthDate = [self.birthDate copy];
	copy.createdAt = [self.createdAt copy];
	copy.genderId = [self.genderId copy];
	copy.handBustUrl = [self.handBustUrl copy];
	copy.idcardEndDate = [self.idcardEndDate copy];
	copy.idcardStartDate = [self.idcardStartDate copy];
	copy.idcardType = [self.idcardType copy];
	copy.identityCardBackUrl = [self.identityCardBackUrl copy];
	copy.identityCardFrontUrl = [self.identityCardFrontUrl copy];
	copy.identityCardId = [self.identityCardId copy];
	copy.name = [self.name copy];
	copy.national = [self.national copy];
	copy.reason = [self.reason copy];
	copy.state = self.state;
	copy.type = self.type;
	copy.updatedAt = [self.updatedAt copy];

	return copy;
}
@end