//
//	configH5.m
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "configH5.h"

NSString *const kconfigH5Url = @"url";

@interface configH5 ()
@end
@implementation configH5




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
    if ([dictionary isKindOfClass:[NSNull class]]) {
        return self;
    }
	if(![dictionary[kconfigH5Url] isKindOfClass:[NSNull class]]){
		self.url = dictionary[kconfigH5Url];
	}	
	return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	if(self.url != nil){
		dictionary[kconfigH5Url] = self.url;
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
	if(self.url != nil){
		[aCoder encodeObject:self.url forKey:kconfigH5Url];
	}

}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.url = [aDecoder decodeObjectForKey:kconfigH5Url];
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	configH5 *copy = [configH5 new];

	copy.url = [self.url copy];

	return copy;
}
@end
