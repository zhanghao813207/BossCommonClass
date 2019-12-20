//
//	OverTimeRootClass.m
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "OverTimeRootClass.h"

NSString *const kOverTimeRootClassIdField = @"_id";
NSString *const kOverTimeRootClassActualApplyName = @"actual_apply_name";
NSString *const kOverTimeRootClassApplicationOrderId = @"application_order_id";
NSString *const kOverTimeRootClassApplyAccountId = @"apply_account_id";
NSString *const kOverTimeRootClassApplyAccountInfo = @"apply_account_info";
NSString *const kOverTimeRootClassAssetIds = @"asset_ids";
NSString *const kOverTimeRootClassBizDistrictId = @"biz_district_id";
NSString *const kOverTimeRootClassBizDistrictName = @"biz_district_name";
NSString *const kOverTimeRootClassCityCode = @"city_code";
NSString *const kOverTimeRootClassCityName = @"city_name";
NSString *const kOverTimeRootClassCitySpelling = @"city_spelling";
NSString *const kOverTimeRootClassClosedAt = @"closed_at";
NSString *const kOverTimeRootClassCreatedAt = @"created_at";
NSString *const kOverTimeRootClassDoneAt = @"done_at";
NSString *const kOverTimeRootClassDuration = @"duration";
NSString *const kOverTimeRootClassEndAt = @"end_at";
NSString *const kOverTimeRootClassFileUrlList = @"file_url_list";
NSString *const kOverTimeRootClassInfoAddress = @"info_address";
NSString *const kOverTimeRootClassNote = @"note";
NSString *const kOverTimeRootClassOperatorId = @"operator_id";
NSString *const kOverTimeRootClassOperatorInfo = @"operator_info";
NSString *const kOverTimeRootClassPlatformCode = @"platform_code";
NSString *const kOverTimeRootClassPlatformName = @"platform_name";
NSString *const kOverTimeRootClassReason = @"reason";
NSString *const kOverTimeRootClassStartAt = @"start_at";
NSString *const kOverTimeRootClassState = @"state";
NSString *const kOverTimeRootClassSubmitAt = @"submit_at";
NSString *const kOverTimeRootClassSupplierId = @"supplier_id";
NSString *const kOverTimeRootClassTags = @"tags";
NSString *const kOverTimeRootClassUpdatedAt = @"updated_at";
NSString *const kOverTimeRootClassWorkingHours = @"working_hours";

@interface OverTimeRootClass ()
@end
@implementation OverTimeRootClass




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[kOverTimeRootClassIdField] isKindOfClass:[NSNull class]]){
		self.idField = dictionary[kOverTimeRootClassIdField];
	}	
	if(![dictionary[kOverTimeRootClassActualApplyName] isKindOfClass:[NSNull class]]){
		self.actualApplyName = dictionary[kOverTimeRootClassActualApplyName];
	}	
	if(![dictionary[kOverTimeRootClassApplicationOrderId] isKindOfClass:[NSNull class]]){
		self.applicationOrderId = dictionary[kOverTimeRootClassApplicationOrderId];
	}	
	if(![dictionary[kOverTimeRootClassApplyAccountId] isKindOfClass:[NSNull class]]){
		self.applyAccountId = dictionary[kOverTimeRootClassApplyAccountId];
	}	
	if(![dictionary[kOverTimeRootClassApplyAccountInfo] isKindOfClass:[NSNull class]]){
		self.applyAccountInfo = [[OverTimeApplyAccountInfo alloc] initWithDictionary:dictionary[kOverTimeRootClassApplyAccountInfo]];
	}

	if(![dictionary[kOverTimeRootClassAssetIds] isKindOfClass:[NSNull class]]){
		self.assetIds = dictionary[kOverTimeRootClassAssetIds];
	}	
	if(![dictionary[kOverTimeRootClassBizDistrictId] isKindOfClass:[NSNull class]]){
		self.bizDistrictId = dictionary[kOverTimeRootClassBizDistrictId];
	}	
	if(![dictionary[kOverTimeRootClassBizDistrictName] isKindOfClass:[NSNull class]]){
		self.bizDistrictName = dictionary[kOverTimeRootClassBizDistrictName];
	}	
	if(![dictionary[kOverTimeRootClassCityCode] isKindOfClass:[NSNull class]]){
		self.cityCode = dictionary[kOverTimeRootClassCityCode];
	}	
	if(![dictionary[kOverTimeRootClassCityName] isKindOfClass:[NSNull class]]){
		self.cityName = dictionary[kOverTimeRootClassCityName];
	}	
	if(![dictionary[kOverTimeRootClassCitySpelling] isKindOfClass:[NSNull class]]){
		self.citySpelling = dictionary[kOverTimeRootClassCitySpelling];
	}	
	if(![dictionary[kOverTimeRootClassClosedAt] isKindOfClass:[NSNull class]]){
		self.closedAt = dictionary[kOverTimeRootClassClosedAt];
	}	
	if(![dictionary[kOverTimeRootClassCreatedAt] isKindOfClass:[NSNull class]]){
		self.createdAt = dictionary[kOverTimeRootClassCreatedAt];
	}	
	if(![dictionary[kOverTimeRootClassDoneAt] isKindOfClass:[NSNull class]]){
		self.doneAt = dictionary[kOverTimeRootClassDoneAt];
	}	
	if(![dictionary[kOverTimeRootClassDuration] isKindOfClass:[NSNull class]]){
		self.duration = [dictionary[kOverTimeRootClassDuration] floatValue];
	}

	if(![dictionary[kOverTimeRootClassEndAt] isKindOfClass:[NSNull class]]){
		self.endAt = dictionary[kOverTimeRootClassEndAt];
	}	
	if(![dictionary[kOverTimeRootClassFileUrlList] isKindOfClass:[NSNull class]]){
		self.fileUrlList = dictionary[kOverTimeRootClassFileUrlList];
	}	
	if(![dictionary[kOverTimeRootClassInfoAddress] isKindOfClass:[NSNull class]]){
		self.infoAddress = dictionary[kOverTimeRootClassInfoAddress];
	}	
	if(![dictionary[kOverTimeRootClassNote] isKindOfClass:[NSNull class]]){
		self.note = dictionary[kOverTimeRootClassNote];
	}	
	if(![dictionary[kOverTimeRootClassOperatorId] isKindOfClass:[NSNull class]]){
		self.operatorId = dictionary[kOverTimeRootClassOperatorId];
	}	
	if(![dictionary[kOverTimeRootClassOperatorInfo] isKindOfClass:[NSNull class]]){
		self.operatorInfo = [[OverTimeApplyAccountInfo alloc] initWithDictionary:dictionary[kOverTimeRootClassOperatorInfo]];
	}

	if(![dictionary[kOverTimeRootClassPlatformCode] isKindOfClass:[NSNull class]]){
		self.platformCode = dictionary[kOverTimeRootClassPlatformCode];
	}	
	if(![dictionary[kOverTimeRootClassPlatformName] isKindOfClass:[NSNull class]]){
		self.platformName = dictionary[kOverTimeRootClassPlatformName];
	}	
	if(![dictionary[kOverTimeRootClassReason] isKindOfClass:[NSNull class]]){
		self.reason = dictionary[kOverTimeRootClassReason];
	}	
	if(![dictionary[kOverTimeRootClassStartAt] isKindOfClass:[NSNull class]]){
		self.startAt = dictionary[kOverTimeRootClassStartAt];
	}	
	if(![dictionary[kOverTimeRootClassState] isKindOfClass:[NSNull class]]){
		self.state = [dictionary[kOverTimeRootClassState] integerValue];
	}

	if(![dictionary[kOverTimeRootClassSubmitAt] isKindOfClass:[NSNull class]]){
		self.submitAt = dictionary[kOverTimeRootClassSubmitAt];
	}	
	if(![dictionary[kOverTimeRootClassSupplierId] isKindOfClass:[NSNull class]]){
		self.supplierId = dictionary[kOverTimeRootClassSupplierId];
	}	
	if(![dictionary[kOverTimeRootClassTags] isKindOfClass:[NSNull class]]){
		self.tags = dictionary[kOverTimeRootClassTags];
	}	
	if(![dictionary[kOverTimeRootClassUpdatedAt] isKindOfClass:[NSNull class]]){
		self.updatedAt = dictionary[kOverTimeRootClassUpdatedAt];
	}	
	if(![dictionary[kOverTimeRootClassWorkingHours] isKindOfClass:[NSNull class]]){
		self.workingHours = [dictionary[kOverTimeRootClassWorkingHours] floatValue];
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
		dictionary[kOverTimeRootClassIdField] = self.idField;
	}
	if(self.actualApplyName != nil){
		dictionary[kOverTimeRootClassActualApplyName] = self.actualApplyName;
	}
	if(self.applicationOrderId != nil){
		dictionary[kOverTimeRootClassApplicationOrderId] = self.applicationOrderId;
	}
	if(self.applyAccountId != nil){
		dictionary[kOverTimeRootClassApplyAccountId] = self.applyAccountId;
	}
	if(self.applyAccountInfo != nil){
		dictionary[kOverTimeRootClassApplyAccountInfo] = [self.applyAccountInfo toDictionary];
	}
	if(self.assetIds != nil){
		dictionary[kOverTimeRootClassAssetIds] = self.assetIds;
	}
	if(self.bizDistrictId != nil){
		dictionary[kOverTimeRootClassBizDistrictId] = self.bizDistrictId;
	}
	if(self.bizDistrictName != nil){
		dictionary[kOverTimeRootClassBizDistrictName] = self.bizDistrictName;
	}
	if(self.cityCode != nil){
		dictionary[kOverTimeRootClassCityCode] = self.cityCode;
	}
	if(self.cityName != nil){
		dictionary[kOverTimeRootClassCityName] = self.cityName;
	}
	if(self.citySpelling != nil){
		dictionary[kOverTimeRootClassCitySpelling] = self.citySpelling;
	}
	if(self.closedAt != nil){
		dictionary[kOverTimeRootClassClosedAt] = self.closedAt;
	}
	if(self.createdAt != nil){
		dictionary[kOverTimeRootClassCreatedAt] = self.createdAt;
	}
	if(self.doneAt != nil){
		dictionary[kOverTimeRootClassDoneAt] = self.doneAt;
	}
	dictionary[kOverTimeRootClassDuration] = @(self.duration);
	if(self.endAt != nil){
		dictionary[kOverTimeRootClassEndAt] = self.endAt;
	}
	if(self.fileUrlList != nil){
		dictionary[kOverTimeRootClassFileUrlList] = self.fileUrlList;
	}
	if(self.infoAddress != nil){
		dictionary[kOverTimeRootClassInfoAddress] = self.infoAddress;
	}
	if(self.note != nil){
		dictionary[kOverTimeRootClassNote] = self.note;
	}
	if(self.operatorId != nil){
		dictionary[kOverTimeRootClassOperatorId] = self.operatorId;
	}
	if(self.operatorInfo != nil){
		dictionary[kOverTimeRootClassOperatorInfo] = [self.operatorInfo toDictionary];
	}
	if(self.platformCode != nil){
		dictionary[kOverTimeRootClassPlatformCode] = self.platformCode;
	}
	if(self.platformName != nil){
		dictionary[kOverTimeRootClassPlatformName] = self.platformName;
	}
	if(self.reason != nil){
		dictionary[kOverTimeRootClassReason] = self.reason;
	}
	if(self.startAt != nil){
		dictionary[kOverTimeRootClassStartAt] = self.startAt;
	}
	dictionary[kOverTimeRootClassState] = @(self.state);
	if(self.submitAt != nil){
		dictionary[kOverTimeRootClassSubmitAt] = self.submitAt;
	}
	if(self.supplierId != nil){
		dictionary[kOverTimeRootClassSupplierId] = self.supplierId;
	}
	if(self.tags != nil){
		dictionary[kOverTimeRootClassTags] = self.tags;
	}
	if(self.updatedAt != nil){
		dictionary[kOverTimeRootClassUpdatedAt] = self.updatedAt;
	}
	dictionary[kOverTimeRootClassWorkingHours] = @(self.workingHours);
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
		[aCoder encodeObject:self.idField forKey:kOverTimeRootClassIdField];
	}
	if(self.actualApplyName != nil){
		[aCoder encodeObject:self.actualApplyName forKey:kOverTimeRootClassActualApplyName];
	}
	if(self.applicationOrderId != nil){
		[aCoder encodeObject:self.applicationOrderId forKey:kOverTimeRootClassApplicationOrderId];
	}
	if(self.applyAccountId != nil){
		[aCoder encodeObject:self.applyAccountId forKey:kOverTimeRootClassApplyAccountId];
	}
	if(self.applyAccountInfo != nil){
		[aCoder encodeObject:self.applyAccountInfo forKey:kOverTimeRootClassApplyAccountInfo];
	}
	if(self.assetIds != nil){
		[aCoder encodeObject:self.assetIds forKey:kOverTimeRootClassAssetIds];
	}
	if(self.bizDistrictId != nil){
		[aCoder encodeObject:self.bizDistrictId forKey:kOverTimeRootClassBizDistrictId];
	}
	if(self.bizDistrictName != nil){
		[aCoder encodeObject:self.bizDistrictName forKey:kOverTimeRootClassBizDistrictName];
	}
	if(self.cityCode != nil){
		[aCoder encodeObject:self.cityCode forKey:kOverTimeRootClassCityCode];
	}
	if(self.cityName != nil){
		[aCoder encodeObject:self.cityName forKey:kOverTimeRootClassCityName];
	}
	if(self.citySpelling != nil){
		[aCoder encodeObject:self.citySpelling forKey:kOverTimeRootClassCitySpelling];
	}
	if(self.closedAt != nil){
		[aCoder encodeObject:self.closedAt forKey:kOverTimeRootClassClosedAt];
	}
	if(self.createdAt != nil){
		[aCoder encodeObject:self.createdAt forKey:kOverTimeRootClassCreatedAt];
	}
	if(self.doneAt != nil){
		[aCoder encodeObject:self.doneAt forKey:kOverTimeRootClassDoneAt];
	}
	[aCoder encodeObject:@(self.duration) forKey:kOverTimeRootClassDuration];	if(self.endAt != nil){
		[aCoder encodeObject:self.endAt forKey:kOverTimeRootClassEndAt];
	}
	if(self.fileUrlList != nil){
		[aCoder encodeObject:self.fileUrlList forKey:kOverTimeRootClassFileUrlList];
	}
	if(self.infoAddress != nil){
		[aCoder encodeObject:self.infoAddress forKey:kOverTimeRootClassInfoAddress];
	}
	if(self.note != nil){
		[aCoder encodeObject:self.note forKey:kOverTimeRootClassNote];
	}
	if(self.operatorId != nil){
		[aCoder encodeObject:self.operatorId forKey:kOverTimeRootClassOperatorId];
	}
	if(self.operatorInfo != nil){
		[aCoder encodeObject:self.operatorInfo forKey:kOverTimeRootClassOperatorInfo];
	}
	if(self.platformCode != nil){
		[aCoder encodeObject:self.platformCode forKey:kOverTimeRootClassPlatformCode];
	}
	if(self.platformName != nil){
		[aCoder encodeObject:self.platformName forKey:kOverTimeRootClassPlatformName];
	}
	if(self.reason != nil){
		[aCoder encodeObject:self.reason forKey:kOverTimeRootClassReason];
	}
	if(self.startAt != nil){
		[aCoder encodeObject:self.startAt forKey:kOverTimeRootClassStartAt];
	}
	[aCoder encodeObject:@(self.state) forKey:kOverTimeRootClassState];	if(self.submitAt != nil){
		[aCoder encodeObject:self.submitAt forKey:kOverTimeRootClassSubmitAt];
	}
	if(self.supplierId != nil){
		[aCoder encodeObject:self.supplierId forKey:kOverTimeRootClassSupplierId];
	}
	if(self.tags != nil){
		[aCoder encodeObject:self.tags forKey:kOverTimeRootClassTags];
	}
	if(self.updatedAt != nil){
		[aCoder encodeObject:self.updatedAt forKey:kOverTimeRootClassUpdatedAt];
	}
	[aCoder encodeObject:@(self.workingHours) forKey:kOverTimeRootClassWorkingHours];
}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.idField = [aDecoder decodeObjectForKey:kOverTimeRootClassIdField];
	self.actualApplyName = [aDecoder decodeObjectForKey:kOverTimeRootClassActualApplyName];
	self.applicationOrderId = [aDecoder decodeObjectForKey:kOverTimeRootClassApplicationOrderId];
	self.applyAccountId = [aDecoder decodeObjectForKey:kOverTimeRootClassApplyAccountId];
	self.applyAccountInfo = [aDecoder decodeObjectForKey:kOverTimeRootClassApplyAccountInfo];
	self.assetIds = [aDecoder decodeObjectForKey:kOverTimeRootClassAssetIds];
	self.bizDistrictId = [aDecoder decodeObjectForKey:kOverTimeRootClassBizDistrictId];
	self.bizDistrictName = [aDecoder decodeObjectForKey:kOverTimeRootClassBizDistrictName];
	self.cityCode = [aDecoder decodeObjectForKey:kOverTimeRootClassCityCode];
	self.cityName = [aDecoder decodeObjectForKey:kOverTimeRootClassCityName];
	self.citySpelling = [aDecoder decodeObjectForKey:kOverTimeRootClassCitySpelling];
	self.closedAt = [aDecoder decodeObjectForKey:kOverTimeRootClassClosedAt];
	self.createdAt = [aDecoder decodeObjectForKey:kOverTimeRootClassCreatedAt];
	self.doneAt = [aDecoder decodeObjectForKey:kOverTimeRootClassDoneAt];
	self.duration = [[aDecoder decodeObjectForKey:kOverTimeRootClassDuration] floatValue];
	self.endAt = [aDecoder decodeObjectForKey:kOverTimeRootClassEndAt];
	self.fileUrlList = [aDecoder decodeObjectForKey:kOverTimeRootClassFileUrlList];
	self.infoAddress = [aDecoder decodeObjectForKey:kOverTimeRootClassInfoAddress];
	self.note = [aDecoder decodeObjectForKey:kOverTimeRootClassNote];
	self.operatorId = [aDecoder decodeObjectForKey:kOverTimeRootClassOperatorId];
	self.operatorInfo = [aDecoder decodeObjectForKey:kOverTimeRootClassOperatorInfo];
	self.platformCode = [aDecoder decodeObjectForKey:kOverTimeRootClassPlatformCode];
	self.platformName = [aDecoder decodeObjectForKey:kOverTimeRootClassPlatformName];
	self.reason = [aDecoder decodeObjectForKey:kOverTimeRootClassReason];
	self.startAt = [aDecoder decodeObjectForKey:kOverTimeRootClassStartAt];
	self.state = [[aDecoder decodeObjectForKey:kOverTimeRootClassState] integerValue];
	self.submitAt = [aDecoder decodeObjectForKey:kOverTimeRootClassSubmitAt];
	self.supplierId = [aDecoder decodeObjectForKey:kOverTimeRootClassSupplierId];
	self.tags = [aDecoder decodeObjectForKey:kOverTimeRootClassTags];
	self.updatedAt = [aDecoder decodeObjectForKey:kOverTimeRootClassUpdatedAt];
	self.workingHours = [[aDecoder decodeObjectForKey:kOverTimeRootClassWorkingHours] floatValue];
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	OverTimeRootClass *copy = [OverTimeRootClass new];

	copy.idField = [self.idField copy];
	copy.actualApplyName = [self.actualApplyName copy];
	copy.applicationOrderId = [self.applicationOrderId copy];
	copy.applyAccountId = [self.applyAccountId copy];
	copy.applyAccountInfo = [self.applyAccountInfo copy];
	copy.assetIds = [self.assetIds copy];
	copy.bizDistrictId = [self.bizDistrictId copy];
	copy.bizDistrictName = [self.bizDistrictName copy];
	copy.cityCode = [self.cityCode copy];
	copy.cityName = [self.cityName copy];
	copy.citySpelling = [self.citySpelling copy];
	copy.closedAt = [self.closedAt copy];
	copy.createdAt = [self.createdAt copy];
	copy.doneAt = [self.doneAt copy];
	copy.duration = self.duration;
	copy.endAt = [self.endAt copy];
	copy.fileUrlList = [self.fileUrlList copy];
	copy.infoAddress = [self.infoAddress copy];
	copy.note = [self.note copy];
	copy.operatorId = [self.operatorId copy];
	copy.operatorInfo = [self.operatorInfo copy];
	copy.platformCode = [self.platformCode copy];
	copy.platformName = [self.platformName copy];
	copy.reason = [self.reason copy];
	copy.startAt = [self.startAt copy];
	copy.state = self.state;
	copy.submitAt = [self.submitAt copy];
	copy.supplierId = [self.supplierId copy];
	copy.tags = [self.tags copy];
	copy.updatedAt = [self.updatedAt copy];
	copy.workingHours = self.workingHours;

	return copy;
}

- (NSString *)belongStr{
    NSString *belongStr = [NSString stringWithFormat:@"%@-%@", self.platformName, self.cityName];
    if(self.bizDistrictName && self.bizDistrictName.length > 0){
        belongStr = [NSString stringWithFormat:@"%@-%@", belongStr, self.bizDistrictName];
    }
    return belongStr;
}
@end
