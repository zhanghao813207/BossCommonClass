//
//	masksData.m
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "masksData.h"
#import "BossEnumDefin.h"

NSString *const kmasksDataIdField = @"_id";
NSString *const kmasksDataAccountId = @"account_id";
NSString *const kmasksDataAccountInfo = @"account_info";
NSString *const kmasksDataApprovalAccountId = @"approval_account_id";
NSString *const kmasksDataApprovalAt = @"approval_at";
NSString *const kmasksDataBelongDate = @"belong_date";
NSString *const kmasksDataBizDistrictId = @"biz_district_id";
NSString *const kmasksDataCreatedAt = @"created_at";
NSString *const kmasksDataCustomId = @"custom_id";
NSString *const kmasksDataDistributeAccountId = @"distribute_account_id";
NSString *const kmasksDataRejectNote = @"reject_note";
NSString *const kmasksDataState = @"state";
NSString *const kmasksDataTakeAt = @"take_at";
NSString *const kmasksDataTeamId = @"team_id";
NSString *const kmasksDataTeamInfo = @"team_info";
NSString *const kmasksDataUpdatedAt = @"updated_at";
NSString *const kmasksqty = @"qty";
NSString *const kmaskcustomIdDifferent = @"custom_id_different";
NSString *const kmaskrealQtyTotal = @"real_qty_total";
NSString *const kmaskrealQty = @"real_qty";

@interface masksData ()
@end
@implementation masksData




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[kmasksDataIdField] isKindOfClass:[NSNull class]]){
		self.idField = dictionary[kmasksDataIdField];
	}
    if(![dictionary[kmaskrealQty] isKindOfClass:[NSNull class]]){
        self.realqty = [dictionary[kmaskrealQty] stringValue];
    }
    if(![dictionary[kmaskrealQtyTotal] isKindOfClass:[NSNull class]]){
        self.realqtyTotal = [dictionary[kmaskrealQtyTotal] stringValue];
    }
    if(![dictionary[kmaskcustomIdDifferent] isKindOfClass:[NSNull class]]){
        self.customIdDifferent = [dictionary[kmaskcustomIdDifferent] boolValue];
    }
    if(![dictionary[kmasksqty] isKindOfClass:[NSNull class]]){
        self.qty = [dictionary[kmasksqty] stringValue];
    }
	if(![dictionary[kmasksDataAccountId] isKindOfClass:[NSNull class]]){
		self.accountId = dictionary[kmasksDataAccountId];
	}	
	if(![dictionary[kmasksDataAccountInfo] isKindOfClass:[NSNull class]]){
		self.accountInfo = [[masksAccountInfo alloc] initWithDictionary:dictionary[kmasksDataAccountInfo]];
	}

	if(![dictionary[kmasksDataApprovalAccountId] isKindOfClass:[NSNull class]]){
		self.approvalAccountId = dictionary[kmasksDataApprovalAccountId];
	}	
	if(![dictionary[kmasksDataApprovalAt] isKindOfClass:[NSNull class]]){
		self.approvalAt = dictionary[kmasksDataApprovalAt];
	}	
	if(![dictionary[kmasksDataBelongDate] isKindOfClass:[NSNull class]]){
		self.belongDate = [dictionary[kmasksDataBelongDate] integerValue];
        NSString * date = [NSString stringWithFormat:@"%ld", self.belongDate];
        if (date.length == 8){
            // 20200210
            NSString *dayAndMonth = [date substringFromIndex:4];
            self.yearStr = [date substringToIndex:4];
            self.dayStr = [dayAndMonth substringFromIndex:2];
            NSString *month_z = [dayAndMonth substringToIndex:2];
            self.monthStr = [NSString stringWithFormat:@"%@", [month_z substringFromIndex:1]];
        }
	}

	if(![dictionary[kmasksDataBizDistrictId] isKindOfClass:[NSNull class]]){
		self.bizDistrictId = dictionary[kmasksDataBizDistrictId];
	}	
	if(![dictionary[kmasksDataCreatedAt] isKindOfClass:[NSNull class]]){
		self.createdAt = dictionary[kmasksDataCreatedAt];
	}	
	if(![dictionary[kmasksDataCustomId] isKindOfClass:[NSNull class]]){
		self.customId = dictionary[kmasksDataCustomId];
	}	
	if(![dictionary[kmasksDataDistributeAccountId] isKindOfClass:[NSNull class]]){
		self.distributeAccountId = dictionary[kmasksDataDistributeAccountId];
	}	
	if(![dictionary[kmasksDataRejectNote] isKindOfClass:[NSNull class]]){
		self.rejectNote = dictionary[kmasksDataRejectNote];
	}	
	if(![dictionary[kmasksDataState] isKindOfClass:[NSNull class]]){
		self.state = [dictionary[kmasksDataState] integerValue];
        
        //        MasksCreateSuccess                 = 1,     // 未审核
        //        MasksReceive                       = 50,    // 待领取
        //        MasksRefused                       = -50,   // 被拒绝
        //        MasksReceiveSuccess                = 100,   // 领取完成
        if (self.state == MasksCreateSuccess){
            self.statusStr = [NSString stringWithFormat:@"%@%@个", @"已预约",self.qty];
        }
        if (self.state == MasksReceive){
            self.statusStr = [NSString stringWithFormat:@"%@%@个", @"待领取",self.qty];
        }
        if (self.state == MasksReceiveSuccess){
            // 新字段
            self.statusStr = [NSString stringWithFormat:@"%@%@个", @"已领取",self.realqty];
        }
        if (self.state == MasksRefused){
            self.statusStr = [NSString stringWithFormat:@"%@%@个", @"被拒绝",self.qty];
        }
	}

	if(![dictionary[kmasksDataTakeAt] isKindOfClass:[NSNull class]]){
		self.takeAt = dictionary[kmasksDataTakeAt];
	}	
	if(![dictionary[kmasksDataTeamId] isKindOfClass:[NSNull class]]){
		self.teamId = dictionary[kmasksDataTeamId];
	}	
	if(![dictionary[kmasksDataTeamInfo] isKindOfClass:[NSNull class]]){
		self.teamInfo = [[masksTeamInfo alloc] initWithDictionary:dictionary[kmasksDataTeamInfo]];
	}

	if(![dictionary[kmasksDataUpdatedAt] isKindOfClass:[NSNull class]]){
		self.updatedAt = dictionary[kmasksDataUpdatedAt];
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
		dictionary[kmasksDataIdField] = self.idField;
	}
	if(self.accountId != nil){
		dictionary[kmasksDataAccountId] = self.accountId;
	}
	if(self.accountInfo != nil){
		dictionary[kmasksDataAccountInfo] = [self.accountInfo toDictionary];
	}
	if(self.approvalAccountId != nil){
		dictionary[kmasksDataApprovalAccountId] = self.approvalAccountId;
	}
	if(self.approvalAt != nil){
		dictionary[kmasksDataApprovalAt] = self.approvalAt;
	}
	dictionary[kmasksDataBelongDate] = @(self.belongDate);
	if(self.bizDistrictId != nil){
		dictionary[kmasksDataBizDistrictId] = self.bizDistrictId;
	}
	if(self.createdAt != nil){
		dictionary[kmasksDataCreatedAt] = self.createdAt;
	}
	if(self.customId != nil){
		dictionary[kmasksDataCustomId] = self.customId;
	}
	if(self.distributeAccountId != nil){
		dictionary[kmasksDataDistributeAccountId] = self.distributeAccountId;
	}
	if(self.rejectNote != nil){
		dictionary[kmasksDataRejectNote] = self.rejectNote;
	}
	dictionary[kmasksDataState] = @(self.state);
	if(self.takeAt != nil){
		dictionary[kmasksDataTakeAt] = self.takeAt;
	}
	if(self.teamId != nil){
		dictionary[kmasksDataTeamId] = self.teamId;
	}
	if(self.teamInfo != nil){
		dictionary[kmasksDataTeamInfo] = [self.teamInfo toDictionary];
	}
	if(self.updatedAt != nil){
		dictionary[kmasksDataUpdatedAt] = self.updatedAt;
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
		[aCoder encodeObject:self.idField forKey:kmasksDataIdField];
	}
	if(self.accountId != nil){
		[aCoder encodeObject:self.accountId forKey:kmasksDataAccountId];
	}
	if(self.accountInfo != nil){
		[aCoder encodeObject:self.accountInfo forKey:kmasksDataAccountInfo];
	}
	if(self.approvalAccountId != nil){
		[aCoder encodeObject:self.approvalAccountId forKey:kmasksDataApprovalAccountId];
	}
	if(self.approvalAt != nil){
		[aCoder encodeObject:self.approvalAt forKey:kmasksDataApprovalAt];
	}
	[aCoder encodeObject:@(self.belongDate) forKey:kmasksDataBelongDate];	if(self.bizDistrictId != nil){
		[aCoder encodeObject:self.bizDistrictId forKey:kmasksDataBizDistrictId];
	}
	if(self.createdAt != nil){
		[aCoder encodeObject:self.createdAt forKey:kmasksDataCreatedAt];
	}
	if(self.customId != nil){
		[aCoder encodeObject:self.customId forKey:kmasksDataCustomId];
	}
	if(self.distributeAccountId != nil){
		[aCoder encodeObject:self.distributeAccountId forKey:kmasksDataDistributeAccountId];
	}
	if(self.rejectNote != nil){
		[aCoder encodeObject:self.rejectNote forKey:kmasksDataRejectNote];
	}
	[aCoder encodeObject:@(self.state) forKey:kmasksDataState];	if(self.takeAt != nil){
		[aCoder encodeObject:self.takeAt forKey:kmasksDataTakeAt];
	}
	if(self.teamId != nil){
		[aCoder encodeObject:self.teamId forKey:kmasksDataTeamId];
	}
	if(self.teamInfo != nil){
		[aCoder encodeObject:self.teamInfo forKey:kmasksDataTeamInfo];
	}
	if(self.updatedAt != nil){
		[aCoder encodeObject:self.updatedAt forKey:kmasksDataUpdatedAt];
	}

}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.idField = [aDecoder decodeObjectForKey:kmasksDataIdField];
	self.accountId = [aDecoder decodeObjectForKey:kmasksDataAccountId];
	self.accountInfo = [aDecoder decodeObjectForKey:kmasksDataAccountInfo];
	self.approvalAccountId = [aDecoder decodeObjectForKey:kmasksDataApprovalAccountId];
	self.approvalAt = [aDecoder decodeObjectForKey:kmasksDataApprovalAt];
	self.belongDate = [[aDecoder decodeObjectForKey:kmasksDataBelongDate] integerValue];
	self.bizDistrictId = [aDecoder decodeObjectForKey:kmasksDataBizDistrictId];
	self.createdAt = [aDecoder decodeObjectForKey:kmasksDataCreatedAt];
	self.customId = [aDecoder decodeObjectForKey:kmasksDataCustomId];
	self.distributeAccountId = [aDecoder decodeObjectForKey:kmasksDataDistributeAccountId];
	self.rejectNote = [aDecoder decodeObjectForKey:kmasksDataRejectNote];
	self.state = [[aDecoder decodeObjectForKey:kmasksDataState] integerValue];
	self.takeAt = [aDecoder decodeObjectForKey:kmasksDataTakeAt];
	self.teamId = [aDecoder decodeObjectForKey:kmasksDataTeamId];
	self.teamInfo = [aDecoder decodeObjectForKey:kmasksDataTeamInfo];
	self.updatedAt = [aDecoder decodeObjectForKey:kmasksDataUpdatedAt];
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	masksData *copy = [masksData new];

	copy.idField = [self.idField copy];
	copy.accountId = [self.accountId copy];
	copy.accountInfo = [self.accountInfo copy];
	copy.approvalAccountId = [self.approvalAccountId copy];
	copy.approvalAt = [self.approvalAt copy];
	copy.belongDate = self.belongDate;
	copy.bizDistrictId = [self.bizDistrictId copy];
	copy.createdAt = [self.createdAt copy];
	copy.customId = [self.customId copy];
	copy.distributeAccountId = [self.distributeAccountId copy];
	copy.rejectNote = [self.rejectNote copy];
	copy.state = self.state;
	copy.takeAt = [self.takeAt copy];
	copy.teamId = [self.teamId copy];
	copy.teamInfo = [self.teamInfo copy];
	copy.updatedAt = [self.updatedAt copy];

	return copy;
}
@end
