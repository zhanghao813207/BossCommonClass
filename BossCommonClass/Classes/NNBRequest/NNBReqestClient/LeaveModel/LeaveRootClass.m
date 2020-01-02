//
//	LeaveRootClass.m
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "LeaveRootClass.h"
#import "BossEnumDefin.h"
NSString *const kLeaveRootClassIdField = @"_id";
NSString *const kLeaveRootClassActualApplyName = @"actual_apply_name";
NSString *const kLeaveRootClassApplicationOrderId = @"application_order_id";
NSString *const kLeaveRootClassApplicationOrderInfo = @"application_order_info";
NSString *const kLeaveRootClassApplyAccountId = @"apply_account_id";
NSString *const kLeaveRootClassApplyAccountInfo = @"apply_account_info";
NSString *const kLeaveRootClassAssetIds = @"asset_ids";
NSString *const kLeaveRootClassBizDistrictId = @"biz_district_id";
NSString *const kLeaveRootClassBizDistrictName = @"biz_district_name";
NSString *const kLeaveRootClassCityCode = @"city_code";
NSString *const kLeaveRootClassCityName = @"city_name";
NSString *const kLeaveRootClassCitySpelling = @"city_spelling";
NSString *const kLeaveRootClassClosedAt = @"closed_at";
NSString *const kLeaveRootClassCreatedAt = @"created_at";
NSString *const kLeaveRootClassDoneAt = @"done_at";
NSString *const kLeaveRootClassDuration = @"duration";
NSString *const kLeaveRootClassEndAt = @"end_at";
NSString *const kLeaveRootClassFileUrlList = @"file_url_list";
NSString *const kLeaveRootClassLeaveType = @"leave_type";
NSString *const kLeaveRootClassNote = @"note";
NSString *const kLeaveRootClassOperatorId = @"operator_id";
NSString *const kLeaveRootClassOperatorInfo = @"operator_info";
NSString *const kLeaveRootClassPhone = @"phone";
NSString *const kLeaveRootClassPlatformCode = @"platform_code";
NSString *const kLeaveRootClassPlatformName = @"platform_name";
NSString *const kLeaveRootClassReason = @"reason";
NSString *const kLeaveRootClassStartAt = @"start_at";
NSString *const kLeaveRootClassState = @"state";
NSString *const kLeaveRootClassSubmitAt = @"submit_at";
NSString *const kLeaveRootClassSupplierId = @"supplier_id";
NSString *const kLeaveRootClassUpdatedAt = @"updated_at";
NSString *const kLeaveRootClassWorkPlacement = @"work_placement";

@interface LeaveRootClass ()
@end
@implementation LeaveRootClass




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if(![dictionary[kLeaveRootClassIdField] isKindOfClass:[NSNull class]]){
        self.idField = dictionary[kLeaveRootClassIdField];
    }
    if(![dictionary[kLeaveRootClassActualApplyName] isKindOfClass:[NSNull class]]){
        self.actualApplyName = dictionary[kLeaveRootClassActualApplyName];
    }
    if(![dictionary[kLeaveRootClassApplicationOrderId] isKindOfClass:[NSNull class]]){
        self.applicationOrderId = dictionary[kLeaveRootClassApplicationOrderId];
    }
    if(![dictionary[kLeaveRootClassApplicationOrderInfo] isKindOfClass:[NSNull class]]){
        self.applicationOrderInfo = [[LeaveApplicationOrderInfo alloc] initWithDictionary:dictionary[kLeaveRootClassApplicationOrderInfo]];
    }
    
    if(![dictionary[kLeaveRootClassApplyAccountId] isKindOfClass:[NSNull class]]){
        self.applyAccountId = dictionary[kLeaveRootClassApplyAccountId];
    }
    if(![dictionary[kLeaveRootClassApplyAccountInfo] isKindOfClass:[NSNull class]]){
        self.applyAccountInfo = [[LeaveAccountInfoList alloc] initWithDictionary:dictionary[kLeaveRootClassApplyAccountInfo]];
    }
    
    if(![dictionary[kLeaveRootClassAssetIds] isKindOfClass:[NSNull class]]){
        self.assetIds = dictionary[kLeaveRootClassAssetIds];
    }
    if(![dictionary[kLeaveRootClassBizDistrictId] isKindOfClass:[NSNull class]]){
        self.bizDistrictId = dictionary[kLeaveRootClassBizDistrictId];
    }
    if(![dictionary[kLeaveRootClassBizDistrictName] isKindOfClass:[NSNull class]]){
        self.bizDistrictName = dictionary[kLeaveRootClassBizDistrictName];
    }
    if(![dictionary[kLeaveRootClassCityCode] isKindOfClass:[NSNull class]]){
        self.cityCode = dictionary[kLeaveRootClassCityCode];
    }
    if(![dictionary[kLeaveRootClassCityName] isKindOfClass:[NSNull class]]){
        self.cityName = dictionary[kLeaveRootClassCityName];
    }
    if(![dictionary[kLeaveRootClassCitySpelling] isKindOfClass:[NSNull class]]){
        self.citySpelling = dictionary[kLeaveRootClassCitySpelling];
    }
    if(![dictionary[kLeaveRootClassClosedAt] isKindOfClass:[NSNull class]]){
        self.closedAt = dictionary[kLeaveRootClassClosedAt];
    }
    if(![dictionary[kLeaveRootClassCreatedAt] isKindOfClass:[NSNull class]]){
        self.createdAt = dictionary[kLeaveRootClassCreatedAt];
    }
    if(![dictionary[kLeaveRootClassDoneAt] isKindOfClass:[NSNull class]]){
        self.doneAt = dictionary[kLeaveRootClassDoneAt];
    }
    if(![dictionary[kLeaveRootClassDuration] isKindOfClass:[NSNull class]]){
        self.duration = [dictionary[kLeaveRootClassDuration] floatValue];
    }
    
    if(![dictionary[kLeaveRootClassEndAt] isKindOfClass:[NSNull class]]){
        self.endAt = dictionary[kLeaveRootClassEndAt];
    }
    if(![dictionary[kLeaveRootClassFileUrlList] isKindOfClass:[NSNull class]]){
        self.fileUrlList = dictionary[kLeaveRootClassFileUrlList];
    }
    if(![dictionary[kLeaveRootClassLeaveType] isKindOfClass:[NSNull class]]){
        self.leaveType = [dictionary[kLeaveRootClassLeaveType] integerValue];
    }
    
    if(![dictionary[kLeaveRootClassNote] isKindOfClass:[NSNull class]]){
        self.note = dictionary[kLeaveRootClassNote];
    }
    if(![dictionary[kLeaveRootClassOperatorId] isKindOfClass:[NSNull class]]){
        self.operatorId = dictionary[kLeaveRootClassOperatorId];
    }
    if(![dictionary[kLeaveRootClassOperatorInfo] isKindOfClass:[NSNull class]]){
        self.operatorInfo = [[LeaveAccountInfoList alloc] initWithDictionary:dictionary[kLeaveRootClassOperatorInfo]];
    }
    
    if(![dictionary[kLeaveRootClassPhone] isKindOfClass:[NSNull class]]){
        self.phone = dictionary[kLeaveRootClassPhone];
    }
    if(![dictionary[kLeaveRootClassPlatformCode] isKindOfClass:[NSNull class]]){
        self.platformCode = dictionary[kLeaveRootClassPlatformCode];
    }
    if(![dictionary[kLeaveRootClassPlatformName] isKindOfClass:[NSNull class]]){
        self.platformName = dictionary[kLeaveRootClassPlatformName];
    }
    if(![dictionary[kLeaveRootClassReason] isKindOfClass:[NSNull class]]){
        self.reason = dictionary[kLeaveRootClassReason];
    }
    if(![dictionary[kLeaveRootClassStartAt] isKindOfClass:[NSNull class]]){
        self.startAt = dictionary[kLeaveRootClassStartAt];
    }
    if(![dictionary[kLeaveRootClassState] isKindOfClass:[NSNull class]]){
        self.state = [dictionary[kLeaveRootClassState] integerValue];
    }
    
    if(![dictionary[kLeaveRootClassSubmitAt] isKindOfClass:[NSNull class]]){
        self.submitAt = dictionary[kLeaveRootClassSubmitAt];
    }
    if(![dictionary[kLeaveRootClassSupplierId] isKindOfClass:[NSNull class]]){
        self.supplierId = dictionary[kLeaveRootClassSupplierId];
    }
    if(![dictionary[kLeaveRootClassUpdatedAt] isKindOfClass:[NSNull class]]){
        self.updatedAt = dictionary[kLeaveRootClassUpdatedAt];
    }
    if(![dictionary[kLeaveRootClassWorkPlacement] isKindOfClass:[NSNull class]]){
        self.workPlacement = dictionary[kLeaveRootClassWorkPlacement];
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
        dictionary[kLeaveRootClassIdField] = self.idField;
    }
    if(self.actualApplyName != nil){
        dictionary[kLeaveRootClassActualApplyName] = self.actualApplyName;
    }
    if(self.applicationOrderId != nil){
        dictionary[kLeaveRootClassApplicationOrderId] = self.applicationOrderId;
    }
    if(self.applicationOrderInfo != nil){
        dictionary[kLeaveRootClassApplicationOrderInfo] = [self.applicationOrderInfo toDictionary];
    }
    if(self.applyAccountId != nil){
        dictionary[kLeaveRootClassApplyAccountId] = self.applyAccountId;
    }
    if(self.applyAccountInfo != nil){
        dictionary[kLeaveRootClassApplyAccountInfo] = [self.applyAccountInfo toDictionary];
    }
    if(self.assetIds != nil){
        dictionary[kLeaveRootClassAssetIds] = self.assetIds;
    }
    if(self.bizDistrictId != nil){
        dictionary[kLeaveRootClassBizDistrictId] = self.bizDistrictId;
    }
    if(self.bizDistrictName != nil){
        dictionary[kLeaveRootClassBizDistrictName] = self.bizDistrictName;
    }
    if(self.cityCode != nil){
        dictionary[kLeaveRootClassCityCode] = self.cityCode;
    }
    if(self.cityName != nil){
        dictionary[kLeaveRootClassCityName] = self.cityName;
    }
    if(self.citySpelling != nil){
        dictionary[kLeaveRootClassCitySpelling] = self.citySpelling;
    }
    if(self.closedAt != nil){
        dictionary[kLeaveRootClassClosedAt] = self.closedAt;
    }
    if(self.createdAt != nil){
        dictionary[kLeaveRootClassCreatedAt] = self.createdAt;
    }
    if(self.doneAt != nil){
        dictionary[kLeaveRootClassDoneAt] = self.doneAt;
    }
    dictionary[kLeaveRootClassDuration] = @(self.duration);
    if(self.endAt != nil){
        dictionary[kLeaveRootClassEndAt] = self.endAt;
    }
    if(self.fileUrlList != nil){
        dictionary[kLeaveRootClassFileUrlList] = self.fileUrlList;
    }
    dictionary[kLeaveRootClassLeaveType] = @(self.leaveType);
    if(self.note != nil){
        dictionary[kLeaveRootClassNote] = self.note;
    }
    if(self.operatorId != nil){
        dictionary[kLeaveRootClassOperatorId] = self.operatorId;
    }
    if(self.operatorInfo != nil){
        dictionary[kLeaveRootClassOperatorInfo] = [self.operatorInfo toDictionary];
    }
    if(self.phone != nil){
        dictionary[kLeaveRootClassPhone] = self.phone;
    }
    if(self.platformCode != nil){
        dictionary[kLeaveRootClassPlatformCode] = self.platformCode;
    }
    if(self.platformName != nil){
        dictionary[kLeaveRootClassPlatformName] = self.platformName;
    }
    if(self.reason != nil){
        dictionary[kLeaveRootClassReason] = self.reason;
    }
    if(self.startAt != nil){
        dictionary[kLeaveRootClassStartAt] = self.startAt;
    }
    dictionary[kLeaveRootClassState] = @(self.state);
    if(self.submitAt != nil){
        dictionary[kLeaveRootClassSubmitAt] = self.submitAt;
    }
    if(self.supplierId != nil){
        dictionary[kLeaveRootClassSupplierId] = self.supplierId;
    }
    if(self.updatedAt != nil){
        dictionary[kLeaveRootClassUpdatedAt] = self.updatedAt;
    }
    if(self.workPlacement != nil){
        dictionary[kLeaveRootClassWorkPlacement] = self.workPlacement;
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
        [aCoder encodeObject:self.idField forKey:kLeaveRootClassIdField];
    }
    if(self.actualApplyName != nil){
        [aCoder encodeObject:self.actualApplyName forKey:kLeaveRootClassActualApplyName];
    }
    if(self.applicationOrderId != nil){
        [aCoder encodeObject:self.applicationOrderId forKey:kLeaveRootClassApplicationOrderId];
    }
    if(self.applicationOrderInfo != nil){
        [aCoder encodeObject:self.applicationOrderInfo forKey:kLeaveRootClassApplicationOrderInfo];
    }
    if(self.applyAccountId != nil){
        [aCoder encodeObject:self.applyAccountId forKey:kLeaveRootClassApplyAccountId];
    }
    if(self.applyAccountInfo != nil){
        [aCoder encodeObject:self.applyAccountInfo forKey:kLeaveRootClassApplyAccountInfo];
    }
    if(self.assetIds != nil){
        [aCoder encodeObject:self.assetIds forKey:kLeaveRootClassAssetIds];
    }
    if(self.bizDistrictId != nil){
        [aCoder encodeObject:self.bizDistrictId forKey:kLeaveRootClassBizDistrictId];
    }
    if(self.bizDistrictName != nil){
        [aCoder encodeObject:self.bizDistrictName forKey:kLeaveRootClassBizDistrictName];
    }
    if(self.cityCode != nil){
        [aCoder encodeObject:self.cityCode forKey:kLeaveRootClassCityCode];
    }
    if(self.cityName != nil){
        [aCoder encodeObject:self.cityName forKey:kLeaveRootClassCityName];
    }
    if(self.citySpelling != nil){
        [aCoder encodeObject:self.citySpelling forKey:kLeaveRootClassCitySpelling];
    }
    if(self.closedAt != nil){
        [aCoder encodeObject:self.closedAt forKey:kLeaveRootClassClosedAt];
    }
    if(self.createdAt != nil){
        [aCoder encodeObject:self.createdAt forKey:kLeaveRootClassCreatedAt];
    }
    if(self.doneAt != nil){
        [aCoder encodeObject:self.doneAt forKey:kLeaveRootClassDoneAt];
    }
    [aCoder encodeObject:@(self.duration) forKey:kLeaveRootClassDuration];	if(self.endAt != nil){
        [aCoder encodeObject:self.endAt forKey:kLeaveRootClassEndAt];
    }
    if(self.fileUrlList != nil){
        [aCoder encodeObject:self.fileUrlList forKey:kLeaveRootClassFileUrlList];
    }
    [aCoder encodeObject:@(self.leaveType) forKey:kLeaveRootClassLeaveType];	if(self.note != nil){
        [aCoder encodeObject:self.note forKey:kLeaveRootClassNote];
    }
    if(self.operatorId != nil){
        [aCoder encodeObject:self.operatorId forKey:kLeaveRootClassOperatorId];
    }
    if(self.operatorInfo != nil){
        [aCoder encodeObject:self.operatorInfo forKey:kLeaveRootClassOperatorInfo];
    }
    if(self.phone != nil){
        [aCoder encodeObject:self.phone forKey:kLeaveRootClassPhone];
    }
    if(self.platformCode != nil){
        [aCoder encodeObject:self.platformCode forKey:kLeaveRootClassPlatformCode];
    }
    if(self.platformName != nil){
        [aCoder encodeObject:self.platformName forKey:kLeaveRootClassPlatformName];
    }
    if(self.reason != nil){
        [aCoder encodeObject:self.reason forKey:kLeaveRootClassReason];
    }
    if(self.startAt != nil){
        [aCoder encodeObject:self.startAt forKey:kLeaveRootClassStartAt];
    }
    [aCoder encodeObject:@(self.state) forKey:kLeaveRootClassState];	if(self.submitAt != nil){
        [aCoder encodeObject:self.submitAt forKey:kLeaveRootClassSubmitAt];
    }
    if(self.supplierId != nil){
        [aCoder encodeObject:self.supplierId forKey:kLeaveRootClassSupplierId];
    }
    if(self.updatedAt != nil){
        [aCoder encodeObject:self.updatedAt forKey:kLeaveRootClassUpdatedAt];
    }
    if(self.workPlacement != nil){
        [aCoder encodeObject:self.workPlacement forKey:kLeaveRootClassWorkPlacement];
    }
    
}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    self.idField = [aDecoder decodeObjectForKey:kLeaveRootClassIdField];
    self.actualApplyName = [aDecoder decodeObjectForKey:kLeaveRootClassActualApplyName];
    self.applicationOrderId = [aDecoder decodeObjectForKey:kLeaveRootClassApplicationOrderId];
    self.applicationOrderInfo = [aDecoder decodeObjectForKey:kLeaveRootClassApplicationOrderInfo];
    self.applyAccountId = [aDecoder decodeObjectForKey:kLeaveRootClassApplyAccountId];
    self.applyAccountInfo = [aDecoder decodeObjectForKey:kLeaveRootClassApplyAccountInfo];
    self.assetIds = [aDecoder decodeObjectForKey:kLeaveRootClassAssetIds];
    self.bizDistrictId = [aDecoder decodeObjectForKey:kLeaveRootClassBizDistrictId];
    self.bizDistrictName = [aDecoder decodeObjectForKey:kLeaveRootClassBizDistrictName];
    self.cityCode = [aDecoder decodeObjectForKey:kLeaveRootClassCityCode];
    self.cityName = [aDecoder decodeObjectForKey:kLeaveRootClassCityName];
    self.citySpelling = [aDecoder decodeObjectForKey:kLeaveRootClassCitySpelling];
    self.closedAt = [aDecoder decodeObjectForKey:kLeaveRootClassClosedAt];
    self.createdAt = [aDecoder decodeObjectForKey:kLeaveRootClassCreatedAt];
    self.doneAt = [aDecoder decodeObjectForKey:kLeaveRootClassDoneAt];
    self.duration = [[aDecoder decodeObjectForKey:kLeaveRootClassDuration] floatValue];
    self.endAt = [aDecoder decodeObjectForKey:kLeaveRootClassEndAt];
    self.fileUrlList = [aDecoder decodeObjectForKey:kLeaveRootClassFileUrlList];
    self.leaveType = [[aDecoder decodeObjectForKey:kLeaveRootClassLeaveType] integerValue];
    self.note = [aDecoder decodeObjectForKey:kLeaveRootClassNote];
    self.operatorId = [aDecoder decodeObjectForKey:kLeaveRootClassOperatorId];
    self.operatorInfo = [aDecoder decodeObjectForKey:kLeaveRootClassOperatorInfo];
    self.phone = [aDecoder decodeObjectForKey:kLeaveRootClassPhone];
    self.platformCode = [aDecoder decodeObjectForKey:kLeaveRootClassPlatformCode];
    self.platformName = [aDecoder decodeObjectForKey:kLeaveRootClassPlatformName];
    self.reason = [aDecoder decodeObjectForKey:kLeaveRootClassReason];
    self.startAt = [aDecoder decodeObjectForKey:kLeaveRootClassStartAt];
    self.state = [[aDecoder decodeObjectForKey:kLeaveRootClassState] integerValue];
    self.submitAt = [aDecoder decodeObjectForKey:kLeaveRootClassSubmitAt];
    self.supplierId = [aDecoder decodeObjectForKey:kLeaveRootClassSupplierId];
    self.updatedAt = [aDecoder decodeObjectForKey:kLeaveRootClassUpdatedAt];
    self.workPlacement = [aDecoder decodeObjectForKey:kLeaveRootClassWorkPlacement];
    return self;
    
}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
    LeaveRootClass *copy = [LeaveRootClass new];
    
    copy.idField = [self.idField copy];
    copy.actualApplyName = [self.actualApplyName copy];
    copy.applicationOrderId = [self.applicationOrderId copy];
    copy.applicationOrderInfo = [self.applicationOrderInfo copy];
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
    copy.leaveType = self.leaveType;
    copy.note = [self.note copy];
    copy.operatorId = [self.operatorId copy];
    copy.operatorInfo = [self.operatorInfo copy];
    copy.phone = [self.phone copy];
    copy.platformCode = [self.platformCode copy];
    copy.platformName = [self.platformName copy];
    copy.reason = [self.reason copy];
    copy.startAt = [self.startAt copy];
    copy.state = self.state;
    copy.submitAt = [self.submitAt copy];
    copy.supplierId = [self.supplierId copy];
    copy.updatedAt = [self.updatedAt copy];
    copy.workPlacement = [self.workPlacement copy];
    
    return copy;
}

- (NSString *)belongStr{
    NSString *belongStr = [NSString stringWithFormat:@"%@-%@", self.platformName, self.cityName];
    if(self.bizDistrictName && self.bizDistrictName.length > 0){
        belongStr = [NSString stringWithFormat:@"%@-%@", belongStr, self.bizDistrictName];
    }
    return belongStr;
}

- (NSString *)leaveTypeString {
    
    switch (self.leaveType) {
        case LeaveTypePersonal:
            return @"事假";
            break;
        case LeaveTypeSick:
            return @"病假";
            break;
        case LeaveTypeAnnual:
            return @"年假";
            break;
        case LeaveTypeMarriage:
            return @"婚假";
            break;
        case LeaveTypeMaternity:
            return @"产假";
            break;
        case LeaveTypePaternity:
            return @"陪产假";
            break;
        case LeaveTypeFuneral:
            return @"丧假";
            break;
            
        default:
            return @"";
            break;
    }
    
}

@end
