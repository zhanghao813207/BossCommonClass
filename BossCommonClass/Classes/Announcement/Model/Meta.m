//
//	Meta.m
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "Meta.h"

NSString *const kMetaHasMore = @"has_more";
NSString *const kMetaPage = @"page";
NSString *const kMetaPageSize = @"page_size";
NSString *const kMetaResultCount = @"result_count";

@interface Meta ()
@end
@implementation Meta




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[kMetaHasMore] isKindOfClass:[NSNull class]]){
		self.hasMore = [dictionary[kMetaHasMore] boolValue];
	}

	if(![dictionary[kMetaPage] isKindOfClass:[NSNull class]]){
		self.page = [dictionary[kMetaPage] integerValue];
	}

	if(![dictionary[kMetaPageSize] isKindOfClass:[NSNull class]]){
		self.pageSize = [dictionary[kMetaPageSize] integerValue];
	}

	if(![dictionary[kMetaResultCount] isKindOfClass:[NSNull class]]){
		self.resultCount = [dictionary[kMetaResultCount] integerValue];
	}

	return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	dictionary[kMetaHasMore] = @(self.hasMore);
	dictionary[kMetaPage] = @(self.page);
	dictionary[kMetaPageSize] = @(self.pageSize);
	dictionary[kMetaResultCount] = @(self.resultCount);
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
	[aCoder encodeObject:@(self.hasMore) forKey:kMetaHasMore];	[aCoder encodeObject:@(self.page) forKey:kMetaPage];	[aCoder encodeObject:@(self.pageSize) forKey:kMetaPageSize];	[aCoder encodeObject:@(self.resultCount) forKey:kMetaResultCount];
}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.hasMore = [[aDecoder decodeObjectForKey:kMetaHasMore] boolValue];
	self.page = [[aDecoder decodeObjectForKey:kMetaPage] integerValue];
	self.pageSize = [[aDecoder decodeObjectForKey:kMetaPageSize] integerValue];
	self.resultCount = [[aDecoder decodeObjectForKey:kMetaResultCount] integerValue];
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	Meta *copy = [Meta new];

	copy.hasMore = self.hasMore;
	copy.page = self.page;
	copy.pageSize = self.pageSize;
	copy.resultCount = self.resultCount;

	return copy;
}
@end