//
//	masksporvideMasksModel.m
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "masksporvideMasksModel.h"

NSString *const kmasksporvideMasksModelMeta = @"_meta";
NSString *const kmasksporvideMasksModelData = @"data";

@interface masksporvideMasksModel ()
@end
@implementation masksporvideMasksModel




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[kmasksporvideMasksModelMeta] isKindOfClass:[NSNull class]]){
		self.meta = [[masksMeta alloc] initWithDictionary:dictionary[kmasksporvideMasksModelMeta]];
	}

	if(dictionary[kmasksporvideMasksModelData] != nil && [dictionary[kmasksporvideMasksModelData] isKindOfClass:[NSArray class]]){
		NSArray * dataDictionaries = dictionary[kmasksporvideMasksModelData];
		NSMutableArray * dataItems = [NSMutableArray array];
		for(NSDictionary * dataDictionary in dataDictionaries){
			masksData * dataItem = [[masksData alloc] initWithDictionary:dataDictionary];
			[dataItems addObject:dataItem];
		}
		self.data = dataItems;
	}
	return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	if(self.meta != nil){
		dictionary[kmasksporvideMasksModelMeta] = [self.meta toDictionary];
	}
	if(self.data != nil){
		NSMutableArray * dictionaryElements = [NSMutableArray array];
		for(masksData * dataElement in self.data){
			[dictionaryElements addObject:[dataElement toDictionary]];
		}
		dictionary[kmasksporvideMasksModelData] = dictionaryElements;
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
	if(self.meta != nil){
		[aCoder encodeObject:self.meta forKey:kmasksporvideMasksModelMeta];
	}
	if(self.data != nil){
		[aCoder encodeObject:self.data forKey:kmasksporvideMasksModelData];
	}

}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.meta = [aDecoder decodeObjectForKey:kmasksporvideMasksModelMeta];
	self.data = [aDecoder decodeObjectForKey:kmasksporvideMasksModelData];
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	masksporvideMasksModel *copy = [masksporvideMasksModel new];

	copy.meta = [self.meta copy];
	copy.data = [self.data copy];

	return copy;
}
@end