//
//    OwnerTeamList.m
//    Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport




#import "TeamListModel.h"

NSString *const kOwnerTeamListIdField = @"_id";
NSString *const kOwnerTeamListIdDistrictld = @"biz_district_id";
NSString *const kOwnerTeamListBizDistrictName = @"biz_district_name";
NSString *const kOwnerTeamListStaffId = @"staff_id";
NSString *const kOwnerTeamListSupplierName = @"supplier_name";
NSString *const kOwnerTeamListTeamId = @"team_id";
NSString *const kOwnerTeamListTeamName = @"team_name";
NSString *const kOwnerTeamqrcodeName = @"qrcode";
NSString *const kjoinedDataIndustryCode = @"industry_code";
NSString *const kDataWorkbenchLabel = @"workbench_label";

@interface TeamListModel ()
@end
@implementation TeamListModel




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if ([dictionary isKindOfClass:[NSNull class]]) {
        return self;
    }
    if(![dictionary[kOwnerTeamListIdField] isKindOfClass:[NSNull class]]){
        self.idField = dictionary[kOwnerTeamListIdField];
    }
    if(![dictionary[kOwnerTeamListIdDistrictld] isKindOfClass:[NSNull class]]){
        self.biz_district_id = dictionary[kOwnerTeamListIdDistrictld];
    }
    if(![dictionary[kOwnerTeamqrcodeName] isKindOfClass:[NSNull class]]){
        self.qrcode = dictionary[kOwnerTeamqrcodeName];
    }
    if(![dictionary[kOwnerTeamListBizDistrictName] isKindOfClass:[NSNull class]]){
        self.bizDistrictName = dictionary[kOwnerTeamListBizDistrictName];
    }
    if(![dictionary[kOwnerTeamListStaffId] isKindOfClass:[NSNull class]]){
        self.staffId = dictionary[kOwnerTeamListStaffId];
    }
    if(![dictionary[kOwnerTeamListSupplierName] isKindOfClass:[NSNull class]]){
        self.supplierName = dictionary[kOwnerTeamListSupplierName];
    }
    if(![dictionary[kOwnerTeamListTeamId] isKindOfClass:[NSNull class]]){
        self.teamId = dictionary[kOwnerTeamListTeamId];
    }
    if(![dictionary[kOwnerTeamListTeamName] isKindOfClass:[NSNull class]]){
        self.teamName = dictionary[kOwnerTeamListTeamName];
    }
    if(![dictionary[kjoinedDataIndustryCode] isKindOfClass:[NSNull class]]){
        self.industryCode = [dictionary[kjoinedDataIndustryCode] integerValue];
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
        dictionary[kOwnerTeamListIdField] = self.idField;
    }
    if(self.biz_district_id != nil){
        dictionary[kOwnerTeamListIdDistrictld] = self.biz_district_id;
    }
    
    if(self.bizDistrictName != nil){
        dictionary[kOwnerTeamListBizDistrictName] = self.bizDistrictName;
    }
    if(self.staffId != nil){
        dictionary[kOwnerTeamListStaffId] = self.staffId;
    }
    if(self.supplierName != nil){
        dictionary[kOwnerTeamListSupplierName] = self.supplierName;
    }
    if(self.teamId != nil){
        dictionary[kOwnerTeamListTeamId] = self.teamId;
    }
    if(self.teamName != nil){
        dictionary[kOwnerTeamListTeamName] = self.teamName;
    }
    dictionary[kjoinedDataIndustryCode] = @(self.industryCode);
    
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
        [aCoder encodeObject:self.idField forKey:kOwnerTeamListIdField];
    }
    if(self.biz_district_id != nil){
        [aCoder encodeObject:self.biz_district_id forKey:kOwnerTeamListIdDistrictld];
    }
    if(self.bizDistrictName != nil){
        [aCoder encodeObject:self.bizDistrictName forKey:kOwnerTeamListBizDistrictName];
    }
    if(self.staffId != nil){
        [aCoder encodeObject:self.staffId forKey:kOwnerTeamListStaffId];
    }
    if(self.supplierName != nil){
        [aCoder encodeObject:self.supplierName forKey:kOwnerTeamListSupplierName];
    }
    if(self.teamId != nil){
        [aCoder encodeObject:self.teamId forKey:kOwnerTeamListTeamId];
    }
    if(self.teamName != nil){
        [aCoder encodeObject:self.teamName forKey:kOwnerTeamListTeamName];
    }
    [aCoder encodeObject:@(self.industryCode) forKey:kjoinedDataIndustryCode];
    
    
}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    self.idField = [aDecoder decodeObjectForKey:kOwnerTeamListIdField];
    self.biz_district_id = [aDecoder decodeObjectForKey:kOwnerTeamListIdDistrictld];
    self.bizDistrictName = [aDecoder decodeObjectForKey:kOwnerTeamListBizDistrictName];
    self.staffId = [aDecoder decodeObjectForKey:kOwnerTeamListStaffId];
    self.supplierName = [aDecoder decodeObjectForKey:kOwnerTeamListSupplierName];
    self.teamId = [aDecoder decodeObjectForKey:kOwnerTeamListTeamId];
    self.teamName = [aDecoder decodeObjectForKey:kOwnerTeamListTeamName];
    self.industryCode = [[aDecoder decodeObjectForKey:kjoinedDataIndustryCode] integerValue];
    
    return self;
    
}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
    TeamListModel *copy = [TeamListModel new];
    
    copy.idField = [self.idField copy];
    copy.bizDistrictName = [self.bizDistrictName copy];
    copy.biz_district_id = [self.biz_district_id copy];
    copy.staffId = [self.staffId copy];
    copy.supplierName = [self.supplierName copy];
    copy.teamId = [self.teamId copy];
    copy.teamName = [self.teamName copy];
    copy.industryCode = self.industryCode;
    
    return copy;
}
@end
