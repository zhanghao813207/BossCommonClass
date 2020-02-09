//
//	masksData.m
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "masksData.h"
#import "BossEnumDefin.h"

NSString *const kmasksDataIdField = @"_id";
NSString *const kmasksDataAccountId = @"account_id";
NSString *const kmasksDataCreatedAt = @"created_at";
NSString *const kmasksDataIsOwner = @"is_owner";
NSString *const kmasksDataNote = @"note";
NSString *const kmasksDataPermissionList = @"permission_list";
NSString *const kmasksDataQrcode = @"qrcode";
NSString *const kmasksDataQuitReason = @"quit_reason";
NSString *const kmasksDataRole = @"role";
NSString *const kmasksDataRoleInfo = @"role_info";
NSString *const kmasksDataSalaryOpen = @"salary_open";
NSString *const kmasksDataStaffId = @"staff_id";
NSString *const kmasksDataState = @"state";
NSString *const kmasksDataTeamId = @"team_id";
NSString *const kmasksDataTeamInfo = @"team_info";
NSString *const kmasksDataUpdatedAt = @"updated_at";

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
	if(![dictionary[kmasksDataAccountId] isKindOfClass:[NSNull class]]){
		self.accountId = dictionary[kmasksDataAccountId];
	}	
	if(![dictionary[kmasksDataCreatedAt] isKindOfClass:[NSNull class]]){
		self.createdAt = dictionary[kmasksDataCreatedAt];
	}	
	if(![dictionary[kmasksDataIsOwner] isKindOfClass:[NSNull class]]){
		self.isOwner = [dictionary[kmasksDataIsOwner] boolValue];
	}

	if(![dictionary[kmasksDataNote] isKindOfClass:[NSNull class]]){
		self.note = dictionary[kmasksDataNote];
	}	
	if(![dictionary[kmasksDataPermissionList] isKindOfClass:[NSNull class]]){
		self.permissionList = dictionary[kmasksDataPermissionList];
	}	
	if(![dictionary[kmasksDataQrcode] isKindOfClass:[NSNull class]]){
		self.qrcode = dictionary[kmasksDataQrcode];
	}	
	if(![dictionary[kmasksDataQuitReason] isKindOfClass:[NSNull class]]){
		self.quitReason = dictionary[kmasksDataQuitReason];
	}	
	if(![dictionary[kmasksDataRole] isKindOfClass:[NSNull class]]){
		self.role = [dictionary[kmasksDataRole] integerValue];
	}

	if(![dictionary[kmasksDataRoleInfo] isKindOfClass:[NSNull class]]){
		self.roleInfo = [[masksRoleInfo alloc] initWithDictionary:dictionary[kmasksDataRoleInfo]];
	}

	if(![dictionary[kmasksDataSalaryOpen] isKindOfClass:[NSNull class]]){
		self.salaryOpen = [dictionary[kmasksDataSalaryOpen] boolValue];
	}

	if(![dictionary[kmasksDataStaffId] isKindOfClass:[NSNull class]]){
		self.staffId = dictionary[kmasksDataStaffId];
	}	
	if(![dictionary[kmasksDataState] isKindOfClass:[NSNull class]]){
		self.state = [dictionary[kmasksDataState] integerValue];
        //        MasksCreateSuccess                 = 1,     // 未审核
        //        MasksReceive                       = 50,    // 待领取
        //        MasksRefused                       = -50,   // 被拒绝
        //        MasksReceiveSuccess                = 100,   // 领取完成
        if (self.state == MasksCreateSuccess){
            self.statusStr = @"已预约";
        }
        if (self.state == MasksReceive){
            self.statusStr = @"待领取";
        }
        if (self.state == MasksReceiveSuccess){
            self.statusStr = @"已领取";
        }
        if (self.state == MasksRefused){
            self.statusStr = @"被拒绝";
        }
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
	if(self.createdAt != nil){
		dictionary[kmasksDataCreatedAt] = self.createdAt;
	}
	dictionary[kmasksDataIsOwner] = @(self.isOwner);
	if(self.note != nil){
		dictionary[kmasksDataNote] = self.note;
	}
	if(self.permissionList != nil){
		dictionary[kmasksDataPermissionList] = self.permissionList;
	}
	if(self.qrcode != nil){
		dictionary[kmasksDataQrcode] = self.qrcode;
	}
	if(self.quitReason != nil){
		dictionary[kmasksDataQuitReason] = self.quitReason;
	}
	dictionary[kmasksDataRole] = @(self.role);
	if(self.roleInfo != nil){
		dictionary[kmasksDataRoleInfo] = [self.roleInfo toDictionary];
	}
	dictionary[kmasksDataSalaryOpen] = @(self.salaryOpen);
	if(self.staffId != nil){
		dictionary[kmasksDataStaffId] = self.staffId;
	}
	dictionary[kmasksDataState] = @(self.state);
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
	if(self.createdAt != nil){
		[aCoder encodeObject:self.createdAt forKey:kmasksDataCreatedAt];
	}
	[aCoder encodeObject:@(self.isOwner) forKey:kmasksDataIsOwner];	if(self.note != nil){
		[aCoder encodeObject:self.note forKey:kmasksDataNote];
	}
	if(self.permissionList != nil){
		[aCoder encodeObject:self.permissionList forKey:kmasksDataPermissionList];
	}
	if(self.qrcode != nil){
		[aCoder encodeObject:self.qrcode forKey:kmasksDataQrcode];
	}
	if(self.quitReason != nil){
		[aCoder encodeObject:self.quitReason forKey:kmasksDataQuitReason];
	}
	[aCoder encodeObject:@(self.role) forKey:kmasksDataRole];	if(self.roleInfo != nil){
		[aCoder encodeObject:self.roleInfo forKey:kmasksDataRoleInfo];
	}
	[aCoder encodeObject:@(self.salaryOpen) forKey:kmasksDataSalaryOpen];	if(self.staffId != nil){
		[aCoder encodeObject:self.staffId forKey:kmasksDataStaffId];
	}
	[aCoder encodeObject:@(self.state) forKey:kmasksDataState];	if(self.teamId != nil){
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
	self.createdAt = [aDecoder decodeObjectForKey:kmasksDataCreatedAt];
	self.isOwner = [[aDecoder decodeObjectForKey:kmasksDataIsOwner] boolValue];
	self.note = [aDecoder decodeObjectForKey:kmasksDataNote];
	self.permissionList = [aDecoder decodeObjectForKey:kmasksDataPermissionList];
	self.qrcode = [aDecoder decodeObjectForKey:kmasksDataQrcode];
	self.quitReason = [aDecoder decodeObjectForKey:kmasksDataQuitReason];
	self.role = [[aDecoder decodeObjectForKey:kmasksDataRole] integerValue];
	self.roleInfo = [aDecoder decodeObjectForKey:kmasksDataRoleInfo];
	self.salaryOpen = [[aDecoder decodeObjectForKey:kmasksDataSalaryOpen] boolValue];
	self.staffId = [aDecoder decodeObjectForKey:kmasksDataStaffId];
	self.state = [[aDecoder decodeObjectForKey:kmasksDataState] integerValue];
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
	copy.createdAt = [self.createdAt copy];
	copy.isOwner = self.isOwner;
	copy.note = [self.note copy];
	copy.permissionList = [self.permissionList copy];
	copy.qrcode = [self.qrcode copy];
	copy.quitReason = [self.quitReason copy];
	copy.role = self.role;
	copy.roleInfo = [self.roleInfo copy];
	copy.salaryOpen = self.salaryOpen;
	copy.staffId = [self.staffId copy];
	copy.state = self.state;
	copy.teamId = [self.teamId copy];
	copy.teamInfo = [self.teamInfo copy];
	copy.updatedAt = [self.updatedAt copy];

	return copy;
}
@end
