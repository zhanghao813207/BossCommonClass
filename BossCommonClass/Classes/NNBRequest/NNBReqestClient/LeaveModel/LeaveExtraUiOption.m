//
//	LeaveExtraUiOption.m
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "LeaveExtraUiOption.h"

NSString *const kLeaveExtraUiOptionFormTemplate = @"form_template";

@interface LeaveExtraUiOption ()
@end
@implementation LeaveExtraUiOption




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[kLeaveExtraUiOptionFormTemplate] isKindOfClass:[NSNull class]]){
		self.formTemplate = dictionary[kLeaveExtraUiOptionFormTemplate];
	}	
	return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	if(self.formTemplate != nil){
		dictionary[kLeaveExtraUiOptionFormTemplate] = self.formTemplate;
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
	if(self.formTemplate != nil){
		[aCoder encodeObject:self.formTemplate forKey:kLeaveExtraUiOptionFormTemplate];
	}

}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.formTemplate = [aDecoder decodeObjectForKey:kLeaveExtraUiOptionFormTemplate];
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	LeaveExtraUiOption *copy = [LeaveExtraUiOption new];

	copy.formTemplate = [self.formTemplate copy];

	return copy;
}
@end