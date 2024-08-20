//
//	AccountNoticeListDicModel.m
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "AccountNoticeListDicModel.h"

NSString *const kAccountNoticeListDicModelData = @"data";
NSString *const kAccountNoticeListDicModelOk = @"ok";

@interface AccountNoticeListDicModel ()
@end

@implementation AccountNoticeListDicModel

/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
    if ([dictionary isKindOfClass:[NSNull class]]) {
        return self;
    }
	if(dictionary[kAccountNoticeListDicModelData] != nil && [dictionary[kAccountNoticeListDicModelData] isKindOfClass:[NSArray class]]){
		NSArray * dataDictionaries = dictionary[kAccountNoticeListDicModelData];
		NSMutableArray * dataItems = [NSMutableArray array];
		for(NSDictionary * dataDictionary in dataDictionaries){
			AccountNotice * dataItem = [[AccountNotice alloc] initWithDictionary:dataDictionary];
			[dataItems addObject:dataItem];
		}
		self.data = dataItems;
	}
	if(![dictionary[kAccountNoticeListDicModelOk] isKindOfClass:[NSNull class]]){
		self.ok = [dictionary[kAccountNoticeListDicModelOk] boolValue];
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
		for(AccountNotice * dataElement in self.data){
			[dictionaryElements addObject:[dataElement toDictionary]];
		}
		dictionary[kAccountNoticeListDicModelData] = dictionaryElements;
	}
	dictionary[kAccountNoticeListDicModelOk] = @(self.ok);
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
		[aCoder encodeObject:self.data forKey:kAccountNoticeListDicModelData];
	}
	[aCoder encodeObject:@(self.ok) forKey:kAccountNoticeListDicModelOk];
}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.data = [aDecoder decodeObjectForKey:kAccountNoticeListDicModelData];
	self.ok = [[aDecoder decodeObjectForKey:kAccountNoticeListDicModelOk] boolValue];
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	AccountNoticeListDicModel *copy = [AccountNoticeListDicModel new];

	copy.data = [self.data copy];
	copy.ok = self.ok;

	return copy;
}
@end
