//
//	BaseTeamListModel.m
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "BaseTeamListModel.h"

NSString *const kBaseTeamListModelBizDistrictTeam = @"biz_district_team";
NSString *const kBaseTeamListModelRoleTeam = @"role_team";

@interface BaseTeamListModel ()
@end
@implementation BaseTeamListModel




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(dictionary[kBaseTeamListModelBizDistrictTeam] != nil && [dictionary[kBaseTeamListModelBizDistrictTeam] isKindOfClass:[NSArray class]]){
		NSArray * bizDistrictTeamDictionaries = dictionary[kBaseTeamListModelBizDistrictTeam];
		NSMutableArray * bizDistrictTeamItems = [NSMutableArray array];
        NSMutableArray * platformList = [NSMutableArray array];
        NSMutableArray * platformCodeLists = [NSMutableArray array];
//        NSMutableArray * supplierIDArr = [NSMutableArray array];

        for(NSDictionary * bizDistrictTeamDictionary in bizDistrictTeamDictionaries){
            
            BizDistrictTeam *bizDistrictTeam = [[BizDistrictTeam alloc] initWithDictionary:bizDistrictTeamDictionary];
            [platformCodeLists addObject:bizDistrictTeam.businessExtraField.platformCode];
            [bizDistrictTeamItems addObject:bizDistrictTeam];
        }
        platformCodeLists = [platformCodeLists valueForKeyPath:@"@distinctUnionOfObjects.self"];
        
        for (NSString *platformCode in platformCodeLists) {
            NSMutableArray * platformArr = [NSMutableArray array];
//            NSMutableArray * supplierIDArr = [NSMutableArray array];
            for (BizDistrictTeam *bizDistrictTeam in bizDistrictTeamItems) {
                if ([platformCode isEqualToString:bizDistrictTeam.businessExtraField.platformCode]){
                    [platformArr addObject:bizDistrictTeam];
                }
            }
            [platformList addObject:platformArr];
        }

        self.platformList = platformList;
    
        self.bizDistrictTeam = bizDistrictTeamItems;
    }
	if(![dictionary[kBaseTeamListModelRoleTeam] isKindOfClass:[NSNull class]]){
		self.roleTeam = [[RoleTeam alloc] initWithDictionary:dictionary[kBaseTeamListModelRoleTeam]];
	}

	return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	if(self.bizDistrictTeam != nil){
		NSMutableArray * dictionaryElements = [NSMutableArray array];
		for(BizDistrictTeam * bizDistrictTeamElement in self.bizDistrictTeam){
			[dictionaryElements addObject:[bizDistrictTeamElement toDictionary]];
		}
		dictionary[kBaseTeamListModelBizDistrictTeam] = dictionaryElements;
	}
	if(self.roleTeam != nil){
		dictionary[kBaseTeamListModelRoleTeam] = [self.roleTeam toDictionary];
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
	if(self.bizDistrictTeam != nil){
		[aCoder encodeObject:self.bizDistrictTeam forKey:kBaseTeamListModelBizDistrictTeam];
	}
	if(self.roleTeam != nil){
		[aCoder encodeObject:self.roleTeam forKey:kBaseTeamListModelRoleTeam];
	}

}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.bizDistrictTeam = [aDecoder decodeObjectForKey:kBaseTeamListModelBizDistrictTeam];
	self.roleTeam = [aDecoder decodeObjectForKey:kBaseTeamListModelRoleTeam];
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	BaseTeamListModel *copy = [BaseTeamListModel new];

	copy.bizDistrictTeam = [self.bizDistrictTeam copy];
	copy.roleTeam = [self.roleTeam copy];

	return copy;
}
@end
