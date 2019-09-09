//
//	configModel.m
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "configModel.h"

NSString *const kconfigModelH5 = @"h5";
NSString *const kconfigModelMqtt = @"mqtt";
NSString *const kconfigModelUms = @"ums";

@interface configModel ()
@end
@implementation configModel




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[kconfigModelH5] isKindOfClass:[NSNull class]]){
		self.h5 = [[configH5 alloc] initWithDictionary:dictionary[kconfigModelH5]];
	}

	if(![dictionary[kconfigModelMqtt] isKindOfClass:[NSNull class]]){
		self.mqtt = [[configMqtt alloc] initWithDictionary:dictionary[kconfigModelMqtt]];
	}

	if(![dictionary[kconfigModelUms] isKindOfClass:[NSNull class]]){
		self.ums = [[configH5 alloc] initWithDictionary:dictionary[kconfigModelUms]];
	}

	return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	if(self.h5 != nil){
		dictionary[kconfigModelH5] = [self.h5 toDictionary];
	}
	if(self.mqtt != nil){
		dictionary[kconfigModelMqtt] = [self.mqtt toDictionary];
	}
	if(self.ums != nil){
		dictionary[kconfigModelUms] = [self.ums toDictionary];
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
	if(self.h5 != nil){
		[aCoder encodeObject:self.h5 forKey:kconfigModelH5];
	}
	if(self.mqtt != nil){
		[aCoder encodeObject:self.mqtt forKey:kconfigModelMqtt];
	}
	if(self.ums != nil){
		[aCoder encodeObject:self.ums forKey:kconfigModelUms];
	}

}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.h5 = [aDecoder decodeObjectForKey:kconfigModelH5];
	self.mqtt = [aDecoder decodeObjectForKey:kconfigModelMqtt];
	self.ums = [aDecoder decodeObjectForKey:kconfigModelUms];
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	configModel *copy = [configModel new];

	copy.h5 = [self.h5 copy];
	copy.mqtt = [self.mqtt copy];
	copy.ums = [self.ums copy];

	return copy;
}
@end