//
//	RoleTeam.m
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "RoleTeam.h"

NSString *const kRoleTeamData = @"data";
NSString *const kRootClassName = @"name";

@interface RoleTeam ()
@end
@implementation RoleTeam




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(dictionary[kRoleTeamData] != nil && [dictionary[kRoleTeamData] isKindOfClass:[NSArray class]]){
		NSArray * dataDictionaries = dictionary[kRoleTeamData];
		NSMutableArray * dataItems = [NSMutableArray array];
		for(NSDictionary * dataDictionary in dataDictionaries){
			BizDistrictTeamPlatformModel * dataItem = [[BizDistrictTeamPlatformModel alloc] initWithDictionary:dataDictionary];
			[dataItems addObject:dataItem];
		}
		self.data = dataItems;
	}
    if(![dictionary[kRootClassName] isKindOfClass:[NSNull class]]){
        self.name = dictionary[kRootClassName];
    }
	return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	if(self.data != nil){
		NSMutableArray * dictionaryElements = [NSMutableArray array];
		for(BizDistrictTeamPlatformModel * dataElement in self.data){
			[dictionaryElements addObject:[dataElement toDictionary]];
		}
		dictionary[kRoleTeamData] = dictionaryElements;
	}
    if(self.name != nil){
        dictionary[kRootClassName] = self.name;
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
	if(self.data != nil){
		[aCoder encodeObject:self.data forKey:kRoleTeamData];
	}
    if(self.name != nil){
        [aCoder encodeObject:self.name forKey:kRootClassName];
    }
}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.data = [aDecoder decodeObjectForKey:kRoleTeamData];
    self.name = [aDecoder decodeObjectForKey:kRootClassName];
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	RoleTeam *copy = [RoleTeam new];

	copy.data = [self.data copy];
    copy.name = [self.name copy];
	return copy;
}
@end
