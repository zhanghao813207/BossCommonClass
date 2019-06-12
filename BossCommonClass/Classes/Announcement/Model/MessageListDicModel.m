//
//	MessageListDicModel.m
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "MessageListDicModel.h"

NSString *const kMessageListDicModelMeta = @"_meta";
NSString *const kMessageListDicModelData = @"data";

@interface MessageListDicModel ()
@end

@implementation MessageListDicModel

/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[kMessageListDicModelMeta] isKindOfClass:[NSNull class]]){
		self.meta = [[Meta alloc] initWithDictionary:dictionary[kMessageListDicModelMeta]];
	}

	if(dictionary[kMessageListDicModelData] != nil && [dictionary[kMessageListDicModelData] isKindOfClass:[NSArray class]]){
		NSArray * dataDictionaries = dictionary[kMessageListDicModelData];
		NSMutableArray * dataItems = [NSMutableArray array];
		for(NSDictionary * dataDictionary in dataDictionaries){
			Message * dataItem = [[Message alloc] initWithDictionary:dataDictionary];
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
		dictionary[kMessageListDicModelMeta] = [self.meta toDictionary];
	}
	if(self.data != nil){
		NSMutableArray * dictionaryElements = [NSMutableArray array];
		for(Message * dataElement in self.data){
			[dictionaryElements addObject:[dataElement toDictionary]];
		}
		dictionary[kMessageListDicModelData] = dictionaryElements;
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
		[aCoder encodeObject:self.meta forKey:kMessageListDicModelMeta];
	}
	if(self.data != nil){
		[aCoder encodeObject:self.data forKey:kMessageListDicModelData];
	}

}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.meta = [aDecoder decodeObjectForKey:kMessageListDicModelMeta];
	self.data = [aDecoder decodeObjectForKey:kMessageListDicModelData];
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	MessageListDicModel *copy = [MessageListDicModel new];

	copy.meta = [self.meta copy];
	copy.data = [self.data copy];

	return copy;
}
@end
