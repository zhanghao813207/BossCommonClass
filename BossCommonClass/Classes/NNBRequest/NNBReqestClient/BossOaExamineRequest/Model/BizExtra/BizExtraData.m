//
//	BizExtraData.m
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "BizExtraData.h"

NSString *const kBizExtraDataOtherFee = @"other_fee";
NSString *const kBizExtraDataStayFee = @"stay_fee";
NSString *const kBizExtraDataSubsidyFee = @"subsidy_fee";
NSString *const kBizExtraDataTransportFee = @"transport_fee";
NSString *const kBizExtraDataUrbanTransportFee = @"urban_transport_fee";

@interface BizExtraData ()
@end

@implementation BizExtraData

/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[kBizExtraDataOtherFee] isKindOfClass:[NSNull class]]){
		self.otherFee = [dictionary[kBizExtraDataOtherFee] integerValue];
	}

	if(![dictionary[kBizExtraDataStayFee] isKindOfClass:[NSNull class]]){
		self.stayFee = [dictionary[kBizExtraDataStayFee] integerValue];
	}

	if(![dictionary[kBizExtraDataSubsidyFee] isKindOfClass:[NSNull class]]){
		self.subsidyFee = [dictionary[kBizExtraDataSubsidyFee] integerValue];
	}

	if(![dictionary[kBizExtraDataTransportFee] isKindOfClass:[NSNull class]]){
		self.transportFee = [dictionary[kBizExtraDataTransportFee] integerValue];
	}

	if(![dictionary[kBizExtraDataUrbanTransportFee] isKindOfClass:[NSNull class]]){
		self.urbanTransportFee = [dictionary[kBizExtraDataUrbanTransportFee] integerValue];
	}

	return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	dictionary[kBizExtraDataOtherFee] = @(self.otherFee);
	dictionary[kBizExtraDataStayFee] = @(self.stayFee);
	dictionary[kBizExtraDataSubsidyFee] = @(self.subsidyFee);
	dictionary[kBizExtraDataTransportFee] = @(self.transportFee);
	dictionary[kBizExtraDataUrbanTransportFee] = @(self.urbanTransportFee);
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
	[aCoder encodeObject:@(self.otherFee) forKey:kBizExtraDataOtherFee];	[aCoder encodeObject:@(self.stayFee) forKey:kBizExtraDataStayFee];	[aCoder encodeObject:@(self.subsidyFee) forKey:kBizExtraDataSubsidyFee];	[aCoder encodeObject:@(self.transportFee) forKey:kBizExtraDataTransportFee];	[aCoder encodeObject:@(self.urbanTransportFee) forKey:kBizExtraDataUrbanTransportFee];
}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.otherFee = [[aDecoder decodeObjectForKey:kBizExtraDataOtherFee] integerValue];
	self.stayFee = [[aDecoder decodeObjectForKey:kBizExtraDataStayFee] integerValue];
	self.subsidyFee = [[aDecoder decodeObjectForKey:kBizExtraDataSubsidyFee] integerValue];
	self.transportFee = [[aDecoder decodeObjectForKey:kBizExtraDataTransportFee] integerValue];
	self.urbanTransportFee = [[aDecoder decodeObjectForKey:kBizExtraDataUrbanTransportFee] integerValue];
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	BizExtraData *copy = [BizExtraData new];

	copy.otherFee = self.otherFee;
	copy.stayFee = self.stayFee;
	copy.subsidyFee = self.subsidyFee;
	copy.transportFee = self.transportFee;
	copy.urbanTransportFee = self.urbanTransportFee;

	return copy;
}
@end
