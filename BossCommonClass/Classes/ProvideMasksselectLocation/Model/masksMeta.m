//
//	masksMeta.m
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "masksMeta.h"

NSString *const kmasksMetaHasMore = @"has_more";
NSString *const kmasksMetaPage = @"page";
NSString *const kmasksMetaPageSize = @"page_size";
NSString *const kmasksMetaResultCount = @"result_count";

@interface masksMeta ()
@end
@implementation masksMeta




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
    if ([dictionary isKindOfClass:[NSNull class]]) {
        return self;
    }
	if(![dictionary[kmasksMetaHasMore] isKindOfClass:[NSNull class]]){
		self.hasMore = [dictionary[kmasksMetaHasMore] boolValue];
	}

	if(![dictionary[kmasksMetaPage] isKindOfClass:[NSNull class]]){
		self.page = [dictionary[kmasksMetaPage] integerValue];
	}

	if(![dictionary[kmasksMetaPageSize] isKindOfClass:[NSNull class]]){
		self.pageSize = [dictionary[kmasksMetaPageSize] integerValue];
	}

	if(![dictionary[kmasksMetaResultCount] isKindOfClass:[NSNull class]]){
		self.resultCount = [dictionary[kmasksMetaResultCount] integerValue];
	}

	return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	dictionary[kmasksMetaHasMore] = @(self.hasMore);
	dictionary[kmasksMetaPage] = @(self.page);
	dictionary[kmasksMetaPageSize] = @(self.pageSize);
	dictionary[kmasksMetaResultCount] = @(self.resultCount);
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
	[aCoder encodeObject:@(self.hasMore) forKey:kmasksMetaHasMore];	[aCoder encodeObject:@(self.page) forKey:kmasksMetaPage];	[aCoder encodeObject:@(self.pageSize) forKey:kmasksMetaPageSize];	[aCoder encodeObject:@(self.resultCount) forKey:kmasksMetaResultCount];
}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.hasMore = [[aDecoder decodeObjectForKey:kmasksMetaHasMore] boolValue];
	self.page = [[aDecoder decodeObjectForKey:kmasksMetaPage] integerValue];
	self.pageSize = [[aDecoder decodeObjectForKey:kmasksMetaPageSize] integerValue];
	self.resultCount = [[aDecoder decodeObjectForKey:kmasksMetaResultCount] integerValue];
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	masksMeta *copy = [masksMeta new];

	copy.hasMore = self.hasMore;
	copy.page = self.page;
	copy.pageSize = self.pageSize;
	copy.resultCount = self.resultCount;

	return copy;
}
@end
