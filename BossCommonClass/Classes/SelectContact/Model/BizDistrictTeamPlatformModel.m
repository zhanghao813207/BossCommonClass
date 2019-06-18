//
//    BizDistrictTeam.m
//    Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "BizDistrictTeamPlatformModel.h"
#import "BizDistrictTeam.h"

NSString *const BizDistrictTeamPlatformIdField = @"_id";
NSString *const BizDistrictTeamPlatformBusinessExtraField = @"business_extra_field";
NSString *const BizDistrictTeamPlatformName = @"name";
NSString *const BizDistrictTeamPlatformParentId = @"parent_id";
NSString *const BizDistrictTeamPlatformType = @"type";
NSString *const BizDistrictTeamPlatformVendorId = @"vendor_id";
NSString *const BizDistrictTeamPlatformVendorTargetId = @"vendor_target_id";

@interface BizDistrictTeamPlatformModel ()
@end
@implementation BizDistrictTeamPlatformModel




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 * 平台 -> 团队
 */
//- (void)setIsSelect:(BOOL)isSelect{
//    if (isSelect){
//        
//    } else {
//        
//    }
//}
- (void)setPlatformArr:(NSMutableArray *)PlatformArr{
    NSLog(@"parentIdArr%@", PlatformArr);
    NSMutableArray *IDArr = [NSMutableArray array];
    for (BizDistrictTeam *teamListModel in PlatformArr){
        [IDArr addObject:teamListModel.businessExtraField.supplierId];
    }
    IDArr = [IDArr valueForKeyPath:@"@distinctUnionOfObjects.self"];
    NSMutableArray *supplierList = [NSMutableArray array];
    for(NSString * supplierId in IDArr) {
        NSMutableArray *supplierArr = [NSMutableArray array];
        for (BizDistrictTeam *teamListModel in PlatformArr) {
            if ([supplierId isEqualToString:teamListModel.businessExtraField.supplierId]){
                [supplierArr addObject:teamListModel];
            }
        }
        if (supplierArr.count > 0) {
            BizDistrictTeam *bizDistrictTeam = supplierArr[0];
            BizDistrictTeamPlatformModel * PlatFormModel = [[BizDistrictTeamPlatformModel alloc] initWithDictionary:[bizDistrictTeam toDictionary]];
            PlatFormModel.supplierArr = supplierArr;
            [supplierList addObject: PlatFormModel];
        }
    }
    _PlatformArr = supplierList;
}
// 供应商
- (void)setSupplierArr:(NSMutableArray *)supplierArr{
    
    NSMutableArray *IDArr = [NSMutableArray array];
    for (BizDistrictTeam *teamListModel in supplierArr){
        [IDArr addObject:teamListModel.businessExtraField.cityCode];
    }
    IDArr = [IDArr valueForKeyPath:@"@distinctUnionOfObjects.self"];
    NSMutableArray *supplierList = [NSMutableArray array];
    for(NSString * cityCode in IDArr) {
        NSMutableArray *List = [NSMutableArray array];
        for (BizDistrictTeam *teamListModel in supplierArr) {
            if ([cityCode isEqualToString:teamListModel.businessExtraField.cityCode]){
                [List addObject:teamListModel];
            }
        }
        if (List.count > 0) {
            BizDistrictTeam *bizDistrictTeam = List[0];
            BizDistrictTeamPlatformModel * PlatFormModel = [[BizDistrictTeamPlatformModel alloc] initWithDictionary:[bizDistrictTeam toDictionary]];
            PlatFormModel.cityArr = List;
            [supplierList addObject: PlatFormModel];
        }
    }
    _supplierArr = supplierList;
}
- (void)setCityArr:(NSMutableArray *)cityArr{
    _cityArr = cityArr;
}
-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    
    if(![dictionary[BizDistrictTeamPlatformIdField] isKindOfClass:[NSNull class]]){
        self.idField = dictionary[BizDistrictTeamPlatformIdField];
    }
    if(![dictionary[BizDistrictTeamPlatformBusinessExtraField] isKindOfClass:[NSNull class]]){
        self.businessExtraField = [[BusinessExtraField alloc] initWithDictionary:dictionary[BizDistrictTeamPlatformBusinessExtraField]];
    }
    
    if(![dictionary[BizDistrictTeamPlatformName] isKindOfClass:[NSNull class]]){
        self.name = dictionary[BizDistrictTeamPlatformName];
    }
    if(![dictionary[BizDistrictTeamPlatformParentId] isKindOfClass:[NSNull class]]){
        self.parentId = dictionary[BizDistrictTeamPlatformParentId];
    }
    if(![dictionary[BizDistrictTeamPlatformType] isKindOfClass:[NSNull class]]){
        self.type = 0;
    }
    
    if(![dictionary[BizDistrictTeamPlatformVendorId] isKindOfClass:[NSNull class]]){
        self.vendorId = dictionary[BizDistrictTeamPlatformVendorId];
    }
    if(![dictionary[BizDistrictTeamPlatformVendorTargetId] isKindOfClass:[NSNull class]]){
        self.vendorTargetId = dictionary[BizDistrictTeamPlatformVendorTargetId];
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
        dictionary[BizDistrictTeamPlatformIdField] = self.idField;
    }
    if(self.businessExtraField != nil){
        dictionary[BizDistrictTeamPlatformBusinessExtraField] = [self.businessExtraField toDictionary];
    }
    if(self.name != nil){
        dictionary[BizDistrictTeamPlatformName] = self.name;
    }
    if(self.parentId != nil){
        dictionary[BizDistrictTeamPlatformParentId] = self.parentId;
    }
    dictionary[BizDistrictTeamPlatformType] = @(self.type);
    if(self.vendorId != nil){
        dictionary[BizDistrictTeamPlatformVendorId] = self.vendorId;
    }
    if(self.vendorTargetId != nil){
        dictionary[BizDistrictTeamPlatformVendorTargetId] = self.vendorTargetId;
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
        [aCoder encodeObject:self.idField forKey:BizDistrictTeamPlatformIdField];
    }
    if(self.businessExtraField != nil){
        [aCoder encodeObject:self.businessExtraField forKey:BizDistrictTeamPlatformBusinessExtraField];
    }
    if(self.name != nil){
        [aCoder encodeObject:self.name forKey:BizDistrictTeamPlatformName];
    }
    if(self.parentId != nil){
        [aCoder encodeObject:self.parentId forKey:BizDistrictTeamPlatformParentId];
    }
    [aCoder encodeObject:@(self.type) forKey:BizDistrictTeamPlatformType];    if(self.vendorId != nil){
        [aCoder encodeObject:self.vendorId forKey:BizDistrictTeamPlatformVendorId];
    }
    if(self.vendorTargetId != nil){
        [aCoder encodeObject:self.vendorTargetId forKey:BizDistrictTeamPlatformVendorTargetId];
    }
    
}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    self.idField = [aDecoder decodeObjectForKey:BizDistrictTeamPlatformIdField];
    self.businessExtraField = [aDecoder decodeObjectForKey:BizDistrictTeamPlatformBusinessExtraField];
    self.name = [aDecoder decodeObjectForKey:BizDistrictTeamPlatformName];
    self.parentId = [aDecoder decodeObjectForKey:BizDistrictTeamPlatformParentId];
    self.type = [[aDecoder decodeObjectForKey:BizDistrictTeamPlatformType] integerValue];
    self.vendorId = [aDecoder decodeObjectForKey:BizDistrictTeamPlatformVendorId];
    self.vendorTargetId = [aDecoder decodeObjectForKey:BizDistrictTeamPlatformVendorTargetId];
    return self;
    
}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
    BizDistrictTeamPlatformModel *copy = [BizDistrictTeamPlatformModel new];
    
    copy.idField = [self.idField copy];
    copy.businessExtraField = [self.businessExtraField copy];
    copy.name = [self.name copy];
    copy.parentId = [self.parentId copy];
    copy.type = self.type;
    copy.vendorId = [self.vendorId copy];
    copy.vendorTargetId = [self.vendorTargetId copy];
    
    return copy;
}
@end
