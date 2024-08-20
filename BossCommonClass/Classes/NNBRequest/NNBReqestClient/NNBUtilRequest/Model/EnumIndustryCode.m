//
//	EnumIndustryCode.m
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "EnumIndustryCode.h"

NSString *const kEnumIndustryCodeBlackIcon = @"black_icon";
NSString *const kEnumIndustryCodeCode = @"code";
NSString *const kEnumIndustryCodeIcon = @"icon";
NSString *const kEnumIndustryCodeName = @"name";

@interface EnumIndustryCode ()
@end
@implementation EnumIndustryCode




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
    if ([dictionary isKindOfClass:[NSNull class]]) {
        return self;
    }
	if(![dictionary[kEnumIndustryCodeBlackIcon] isKindOfClass:[NSNull class]]){
		self.blackIcon = dictionary[kEnumIndustryCodeBlackIcon];
	}	
	if(![dictionary[kEnumIndustryCodeCode] isKindOfClass:[NSNull class]]){
		self.code = [dictionary[kEnumIndustryCodeCode] integerValue];
	}

	if(![dictionary[kEnumIndustryCodeIcon] isKindOfClass:[NSNull class]]){
		self.icon = dictionary[kEnumIndustryCodeIcon];
	}	
	if(![dictionary[kEnumIndustryCodeName] isKindOfClass:[NSNull class]]){
		self.name = dictionary[kEnumIndustryCodeName];
	}	
	return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	if(self.blackIcon != nil){
		dictionary[kEnumIndustryCodeBlackIcon] = self.blackIcon;
	}
	dictionary[kEnumIndustryCodeCode] = @(self.code);
	if(self.icon != nil){
		dictionary[kEnumIndustryCodeIcon] = self.icon;
	}
	if(self.name != nil){
		dictionary[kEnumIndustryCodeName] = self.name;
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
	if(self.blackIcon != nil){
		[aCoder encodeObject:self.blackIcon forKey:kEnumIndustryCodeBlackIcon];
	}
	[aCoder encodeObject:@(self.code) forKey:kEnumIndustryCodeCode];	if(self.icon != nil){
		[aCoder encodeObject:self.icon forKey:kEnumIndustryCodeIcon];
	}
	if(self.name != nil){
		[aCoder encodeObject:self.name forKey:kEnumIndustryCodeName];
	}

}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.blackIcon = [aDecoder decodeObjectForKey:kEnumIndustryCodeBlackIcon];
	self.code = [[aDecoder decodeObjectForKey:kEnumIndustryCodeCode] integerValue];
	self.icon = [aDecoder decodeObjectForKey:kEnumIndustryCodeIcon];
	self.name = [aDecoder decodeObjectForKey:kEnumIndustryCodeName];
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	EnumIndustryCode *copy = [EnumIndustryCode new];

	copy.blackIcon = [self.blackIcon copy];
	copy.code = self.code;
	copy.icon = [self.icon copy];
	copy.name = [self.name copy];

	return copy;
}
@end
