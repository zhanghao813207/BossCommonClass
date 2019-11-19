//
//	findLatestModel.m
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "findLatestModel.h"

NSString *const kfindLatestModelIdField = @"_id";
NSString *const kfindLatestModelAccountId = @"account_id";
NSString *const kfindLatestModelBirthDate = @"birth_date";
NSString *const kfindLatestModelCreatedAt = @"created_at";
NSString *const kfindLatestModelCreatorId = @"creator_id";
NSString *const kfindLatestModelDoneAt = @"done_at";
NSString *const kfindLatestModelGenderId = @"gender_id";
NSString *const kfindLatestModelHandBustAssetId = @"hand_bust_asset_id";
NSString *const kfindLatestModelIdcardBackAssetId = @"idcard_back_asset_id";
NSString *const kfindLatestModelIdcardEndDate = @"idcard_end_date";
NSString *const kfindLatestModelIdcardFrontAssetId = @"idcard_front_asset_id";
NSString *const kfindLatestModelIdcardStartDate = @"idcard_start_date";
NSString *const kfindLatestModelIdcardType = @"idcard_type";
NSString *const kfindLatestModelIdentityCardId = @"identity_card_id";
NSString *const kfindLatestModelLastOperatorTeamId = @"last_operator_team_id";
NSString *const kfindLatestModelName = @"name";
NSString *const kfindLatestModelNational = @"national";
NSString *const kfindLatestModelOperatorId = @"operator_id";
NSString *const kfindLatestModelReason = @"reason";
NSString *const kfindLatestModelRejectedAt = @"rejected_at";
NSString *const kfindLatestModelState = @"state";
NSString *const kfindLatestModelType = @"type";
NSString *const kfindLatestModelUpdatedAt = @"updated_at";
NSString *const kfindLatestModelidcardeffectdays = @"idcard_effect_days";

@interface findLatestModel ()
@end
@implementation findLatestModel


- (SelectModifyOperationType)updateType{
    return self.type;
}
- (changeUserInfoCurrentstate)updatestate{
    return self.state;
}
- (NSString *)currentState{
    NSString * typeStr = @"";
    // 当修改姓名以及身份证号码时 会有审核过程
    if (self.type == fixName || self.type == fixIDNumber) {
        if (self.type == fixName){
            typeStr = @"姓名";
        } else if (self.type == fixIDNumber){
            typeStr = @"身份证号";
        }
        NSString *stateStr = @"";
        if (self.state == normalState){
            stateStr = @"待修改, 点击进入";
        } else if (self.state == auditState){
            stateStr = @"正在审核中...";
        } else if (self.state == rejectedState){
            stateStr = @"审核被驳回, 点击进入";
        }
        return [NSString stringWithFormat:@"您的%@%@",typeStr, stateStr];
    } else if (self.type == fixIDCardDate){
        
        return @"您的身份证即将过期, 点击进入";
        
    } else if (self.type == fixIDcard){
        
       return @"您是临时身份证, 点击进入";
    }
    /**
     * 不论当前任务是什么 所有审核通过都会显示 您的审核已通过，立即签约
     */
    if (self.state == throughState){
        return @"您的审核已通过，立即签约";
    }
    return @"";
}

/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[kfindLatestModelIdField] isKindOfClass:[NSNull class]]){
		self.idField = dictionary[kfindLatestModelIdField];
	}	
	if(![dictionary[kfindLatestModelAccountId] isKindOfClass:[NSNull class]]){
		self.accountId = dictionary[kfindLatestModelAccountId];
	}	
	if(![dictionary[kfindLatestModelBirthDate] isKindOfClass:[NSNull class]]){
		self.birthDate = dictionary[kfindLatestModelBirthDate];
	}	
	if(![dictionary[kfindLatestModelCreatedAt] isKindOfClass:[NSNull class]]){
		self.createdAt = dictionary[kfindLatestModelCreatedAt];
	}	
	if(![dictionary[kfindLatestModelCreatorId] isKindOfClass:[NSNull class]]){
		self.creatorId = dictionary[kfindLatestModelCreatorId];
	}	
	if(![dictionary[kfindLatestModelDoneAt] isKindOfClass:[NSNull class]]){
		self.doneAt = dictionary[kfindLatestModelDoneAt];
	}	
	if(![dictionary[kfindLatestModelGenderId] isKindOfClass:[NSNull class]]){
		self.genderId = dictionary[kfindLatestModelGenderId];
	}	
	if(![dictionary[kfindLatestModelHandBustAssetId] isKindOfClass:[NSNull class]]){
		self.handBustAssetId = dictionary[kfindLatestModelHandBustAssetId];
	}	
	if(![dictionary[kfindLatestModelIdcardBackAssetId] isKindOfClass:[NSNull class]]){
		self.idcardBackAssetId = dictionary[kfindLatestModelIdcardBackAssetId];
	}	
	if(![dictionary[kfindLatestModelIdcardEndDate] isKindOfClass:[NSNull class]]){
		self.idcardEndDate = dictionary[kfindLatestModelIdcardEndDate];
	}	
	if(![dictionary[kfindLatestModelIdcardFrontAssetId] isKindOfClass:[NSNull class]]){
		self.idcardFrontAssetId = dictionary[kfindLatestModelIdcardFrontAssetId];
	}	
	if(![dictionary[kfindLatestModelIdcardStartDate] isKindOfClass:[NSNull class]]){
		self.idcardStartDate = dictionary[kfindLatestModelIdcardStartDate];
	}	
	if(![dictionary[kfindLatestModelIdcardType] isKindOfClass:[NSNull class]]){
		self.idcardType = dictionary[kfindLatestModelIdcardType];
	}	
	if(![dictionary[kfindLatestModelIdentityCardId] isKindOfClass:[NSNull class]]){
		self.identityCardId = dictionary[kfindLatestModelIdentityCardId];
	}	
	if(![dictionary[kfindLatestModelLastOperatorTeamId] isKindOfClass:[NSNull class]]){
		self.lastOperatorTeamId = dictionary[kfindLatestModelLastOperatorTeamId];
	}	
	if(![dictionary[kfindLatestModelName] isKindOfClass:[NSNull class]]){
		self.name = dictionary[kfindLatestModelName];
	}	
	if(![dictionary[kfindLatestModelNational] isKindOfClass:[NSNull class]]){
		self.national = dictionary[kfindLatestModelNational];
	}	
	if(![dictionary[kfindLatestModelOperatorId] isKindOfClass:[NSNull class]]){
		self.operatorId = dictionary[kfindLatestModelOperatorId];
	}	
	if(![dictionary[kfindLatestModelReason] isKindOfClass:[NSNull class]]){
		self.reason = dictionary[kfindLatestModelReason];
	}	
	if(![dictionary[kfindLatestModelRejectedAt] isKindOfClass:[NSNull class]]){
		self.rejectedAt = dictionary[kfindLatestModelRejectedAt];
	}	
	if(![dictionary[kfindLatestModelState] isKindOfClass:[NSNull class]]){
		self.state = [dictionary[kfindLatestModelState] integerValue];
	}

	if(![dictionary[kfindLatestModelType] isKindOfClass:[NSNull class]]){
		self.type = [dictionary[kfindLatestModelType] integerValue];
	}

	if(![dictionary[kfindLatestModelUpdatedAt] isKindOfClass:[NSNull class]]){
		self.updatedAt = dictionary[kfindLatestModelUpdatedAt];
	}
    
    if(![dictionary[kfindLatestModelidcardeffectdays] isKindOfClass:[NSNull class]]){
        self.dcardeffectdays = [dictionary[kfindLatestModelidcardeffectdays] integerValue];
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
		dictionary[kfindLatestModelIdField] = self.idField;
	}
	if(self.accountId != nil){
		dictionary[kfindLatestModelAccountId] = self.accountId;
	}
	if(self.birthDate != nil){
		dictionary[kfindLatestModelBirthDate] = self.birthDate;
	}
	if(self.createdAt != nil){
		dictionary[kfindLatestModelCreatedAt] = self.createdAt;
	}
	if(self.creatorId != nil){
		dictionary[kfindLatestModelCreatorId] = self.creatorId;
	}
	if(self.doneAt != nil){
		dictionary[kfindLatestModelDoneAt] = self.doneAt;
	}
	if(self.genderId != nil){
		dictionary[kfindLatestModelGenderId] = self.genderId;
	}
	if(self.handBustAssetId != nil){
		dictionary[kfindLatestModelHandBustAssetId] = self.handBustAssetId;
	}
	if(self.idcardBackAssetId != nil){
		dictionary[kfindLatestModelIdcardBackAssetId] = self.idcardBackAssetId;
	}
	if(self.idcardEndDate != nil){
		dictionary[kfindLatestModelIdcardEndDate] = self.idcardEndDate;
	}
	if(self.idcardFrontAssetId != nil){
		dictionary[kfindLatestModelIdcardFrontAssetId] = self.idcardFrontAssetId;
	}
	if(self.idcardStartDate != nil){
		dictionary[kfindLatestModelIdcardStartDate] = self.idcardStartDate;
	}
	if(self.idcardType != nil){
		dictionary[kfindLatestModelIdcardType] = self.idcardType;
	}
	if(self.identityCardId != nil){
		dictionary[kfindLatestModelIdentityCardId] = self.identityCardId;
	}
	if(self.lastOperatorTeamId != nil){
		dictionary[kfindLatestModelLastOperatorTeamId] = self.lastOperatorTeamId;
	}
	if(self.name != nil){
		dictionary[kfindLatestModelName] = self.name;
	}
	if(self.national != nil){
		dictionary[kfindLatestModelNational] = self.national;
	}
	if(self.operatorId != nil){
		dictionary[kfindLatestModelOperatorId] = self.operatorId;
	}
	if(self.reason != nil){
		dictionary[kfindLatestModelReason] = self.reason;
	}
	if(self.rejectedAt != nil){
		dictionary[kfindLatestModelRejectedAt] = self.rejectedAt;
	}
	dictionary[kfindLatestModelState] = @(self.state);
	dictionary[kfindLatestModelType] = @(self.type);
	if(self.updatedAt != nil){
		dictionary[kfindLatestModelUpdatedAt] = self.updatedAt;
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
		[aCoder encodeObject:self.idField forKey:kfindLatestModelIdField];
	}
	if(self.accountId != nil){
		[aCoder encodeObject:self.accountId forKey:kfindLatestModelAccountId];
	}
	if(self.birthDate != nil){
		[aCoder encodeObject:self.birthDate forKey:kfindLatestModelBirthDate];
	}
	if(self.createdAt != nil){
		[aCoder encodeObject:self.createdAt forKey:kfindLatestModelCreatedAt];
	}
	if(self.creatorId != nil){
		[aCoder encodeObject:self.creatorId forKey:kfindLatestModelCreatorId];
	}
	if(self.doneAt != nil){
		[aCoder encodeObject:self.doneAt forKey:kfindLatestModelDoneAt];
	}
	if(self.genderId != nil){
		[aCoder encodeObject:self.genderId forKey:kfindLatestModelGenderId];
	}
	if(self.handBustAssetId != nil){
		[aCoder encodeObject:self.handBustAssetId forKey:kfindLatestModelHandBustAssetId];
	}
	if(self.idcardBackAssetId != nil){
		[aCoder encodeObject:self.idcardBackAssetId forKey:kfindLatestModelIdcardBackAssetId];
	}
	if(self.idcardEndDate != nil){
		[aCoder encodeObject:self.idcardEndDate forKey:kfindLatestModelIdcardEndDate];
	}
	if(self.idcardFrontAssetId != nil){
		[aCoder encodeObject:self.idcardFrontAssetId forKey:kfindLatestModelIdcardFrontAssetId];
	}
	if(self.idcardStartDate != nil){
		[aCoder encodeObject:self.idcardStartDate forKey:kfindLatestModelIdcardStartDate];
	}
	if(self.idcardType != nil){
		[aCoder encodeObject:self.idcardType forKey:kfindLatestModelIdcardType];
	}
	if(self.identityCardId != nil){
		[aCoder encodeObject:self.identityCardId forKey:kfindLatestModelIdentityCardId];
	}
	if(self.lastOperatorTeamId != nil){
		[aCoder encodeObject:self.lastOperatorTeamId forKey:kfindLatestModelLastOperatorTeamId];
	}
	if(self.name != nil){
		[aCoder encodeObject:self.name forKey:kfindLatestModelName];
	}
	if(self.national != nil){
		[aCoder encodeObject:self.national forKey:kfindLatestModelNational];
	}
	if(self.operatorId != nil){
		[aCoder encodeObject:self.operatorId forKey:kfindLatestModelOperatorId];
	}
	if(self.reason != nil){
		[aCoder encodeObject:self.reason forKey:kfindLatestModelReason];
	}
	if(self.rejectedAt != nil){
		[aCoder encodeObject:self.rejectedAt forKey:kfindLatestModelRejectedAt];
	}
	[aCoder encodeObject:@(self.state) forKey:kfindLatestModelState];	[aCoder encodeObject:@(self.type) forKey:kfindLatestModelType];	if(self.updatedAt != nil){
		[aCoder encodeObject:self.updatedAt forKey:kfindLatestModelUpdatedAt];
	}

}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.idField = [aDecoder decodeObjectForKey:kfindLatestModelIdField];
	self.accountId = [aDecoder decodeObjectForKey:kfindLatestModelAccountId];
	self.birthDate = [aDecoder decodeObjectForKey:kfindLatestModelBirthDate];
	self.createdAt = [aDecoder decodeObjectForKey:kfindLatestModelCreatedAt];
	self.creatorId = [aDecoder decodeObjectForKey:kfindLatestModelCreatorId];
	self.doneAt = [aDecoder decodeObjectForKey:kfindLatestModelDoneAt];
	self.genderId = [aDecoder decodeObjectForKey:kfindLatestModelGenderId];
	self.handBustAssetId = [aDecoder decodeObjectForKey:kfindLatestModelHandBustAssetId];
	self.idcardBackAssetId = [aDecoder decodeObjectForKey:kfindLatestModelIdcardBackAssetId];
	self.idcardEndDate = [aDecoder decodeObjectForKey:kfindLatestModelIdcardEndDate];
	self.idcardFrontAssetId = [aDecoder decodeObjectForKey:kfindLatestModelIdcardFrontAssetId];
	self.idcardStartDate = [aDecoder decodeObjectForKey:kfindLatestModelIdcardStartDate];
	self.idcardType = [aDecoder decodeObjectForKey:kfindLatestModelIdcardType];
	self.identityCardId = [aDecoder decodeObjectForKey:kfindLatestModelIdentityCardId];
	self.lastOperatorTeamId = [aDecoder decodeObjectForKey:kfindLatestModelLastOperatorTeamId];
	self.name = [aDecoder decodeObjectForKey:kfindLatestModelName];
	self.national = [aDecoder decodeObjectForKey:kfindLatestModelNational];
	self.operatorId = [aDecoder decodeObjectForKey:kfindLatestModelOperatorId];
	self.reason = [aDecoder decodeObjectForKey:kfindLatestModelReason];
	self.rejectedAt = [aDecoder decodeObjectForKey:kfindLatestModelRejectedAt];
	self.state = [[aDecoder decodeObjectForKey:kfindLatestModelState] integerValue];
	self.type = [[aDecoder decodeObjectForKey:kfindLatestModelType] integerValue];
	self.updatedAt = [aDecoder decodeObjectForKey:kfindLatestModelUpdatedAt];
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	findLatestModel *copy = [findLatestModel new];

	copy.idField = [self.idField copy];
	copy.accountId = [self.accountId copy];
	copy.birthDate = [self.birthDate copy];
	copy.createdAt = [self.createdAt copy];
	copy.creatorId = [self.creatorId copy];
	copy.doneAt = [self.doneAt copy];
	copy.genderId = [self.genderId copy];
	copy.handBustAssetId = [self.handBustAssetId copy];
	copy.idcardBackAssetId = [self.idcardBackAssetId copy];
	copy.idcardEndDate = [self.idcardEndDate copy];
	copy.idcardFrontAssetId = [self.idcardFrontAssetId copy];
	copy.idcardStartDate = [self.idcardStartDate copy];
	copy.idcardType = [self.idcardType copy];
	copy.identityCardId = [self.identityCardId copy];
	copy.lastOperatorTeamId = [self.lastOperatorTeamId copy];
	copy.name = [self.name copy];
	copy.national = [self.national copy];
	copy.operatorId = [self.operatorId copy];
	copy.reason = [self.reason copy];
	copy.rejectedAt = [self.rejectedAt copy];
	copy.state = self.state;
	copy.type = self.type;
	copy.updatedAt = [self.updatedAt copy];

	return copy;
}
@end
