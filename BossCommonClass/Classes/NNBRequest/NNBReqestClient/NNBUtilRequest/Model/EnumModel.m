//
//	EnumModel.m
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "EnumModel.h"

NSString *const kEnumModelIndustryCodes = @"industry_codes";

@interface EnumModel ()
@end
@implementation EnumModel




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
    if ([dictionary isKindOfClass:[NSNull class]]) {
        return self;
    }
	if(dictionary[kEnumModelIndustryCodes] != nil && [dictionary[kEnumModelIndustryCodes] isKindOfClass:[NSArray class]]){
		NSArray * industryCodesDictionaries = dictionary[kEnumModelIndustryCodes];
		NSMutableArray * industryCodesItems = [NSMutableArray array];
		for(NSDictionary * industryCodesDictionary in industryCodesDictionaries){
			EnumIndustryCode * industryCodesItem = [[EnumIndustryCode alloc] initWithDictionary:industryCodesDictionary];
			[industryCodesItems addObject:industryCodesItem];
		}
		self.industryCodes = industryCodesItems;
	}
	return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	if(self.industryCodes != nil){
		NSMutableArray * dictionaryElements = [NSMutableArray array];
		for(EnumIndustryCode * industryCodesElement in self.industryCodes){
			[dictionaryElements addObject:[industryCodesElement toDictionary]];
		}
		dictionary[kEnumModelIndustryCodes] = dictionaryElements;
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
	if(self.industryCodes != nil){
		[aCoder encodeObject:self.industryCodes forKey:kEnumModelIndustryCodes];
	}

}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.industryCodes = [aDecoder decodeObjectForKey:kEnumModelIndustryCodes];
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	EnumModel *copy = [EnumModel new];

	copy.industryCodes = [self.industryCodes copy];

	return copy;
}
@end
