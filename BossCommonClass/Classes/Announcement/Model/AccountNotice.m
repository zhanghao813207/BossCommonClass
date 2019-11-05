//
//	Data.m
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "AccountNotice.h"

NSString *const kDataCount = @"count";
NSString *const kDataMessageSummaryInfo = @"message_summary_info";
NSString *const kDataProxyInfo = @"proxy_info";
NSString *const kDataSenderInfo = @"sender_info";

@interface AccountNotice ()
@end

@implementation AccountNotice

/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[kDataCount] isKindOfClass:[NSNull class]]){
		self.count = [dictionary[kDataCount] integerValue];
	}

	if(![dictionary[kDataMessageSummaryInfo] isKindOfClass:[NSNull class]]){
		self.messageSummaryInfo = [[MessageSummaryInfo alloc] initWithDictionary:dictionary[kDataMessageSummaryInfo]];
	}

	if(![dictionary[kDataProxyInfo] isKindOfClass:[NSNull class]]){
		self.proxyInfo = [[ProxyInfo alloc] initWithDictionary:dictionary[kDataProxyInfo]];
	}

	if(![dictionary[kDataSenderInfo] isKindOfClass:[NSNull class]]){
		self.senderInfo = [[SenderInfo alloc] initWithDictionary:dictionary[kDataSenderInfo]];
	}

	return self;
}

-(BOOL)isEqual:(AccountNotice *)object{
    if (self == object){
        return true;
    }
    // 数量 以及 title相等才会相等
    if (self.count == object.count && [self.messageSummaryInfo.title isEqualToString:object.messageSummaryInfo.title] && [self.messageSummaryInfo.idField isEqualToString:object.messageSummaryInfo.idField]){
        return true;
    }
    return false;
}
/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	dictionary[kDataCount] = @(self.count);
	if(self.messageSummaryInfo != nil){
		dictionary[kDataMessageSummaryInfo] = [self.messageSummaryInfo toDictionary];
	}
	if(self.proxyInfo != nil){
		dictionary[kDataProxyInfo] = [self.proxyInfo toDictionary];
	}
	if(self.senderInfo != nil){
		dictionary[kDataSenderInfo] = [self.senderInfo toDictionary];
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
	[aCoder encodeObject:@(self.count) forKey:kDataCount];	if(self.messageSummaryInfo != nil){
		[aCoder encodeObject:self.messageSummaryInfo forKey:kDataMessageSummaryInfo];
	}
	if(self.proxyInfo != nil){
		[aCoder encodeObject:self.proxyInfo forKey:kDataProxyInfo];
	}
	if(self.senderInfo != nil){
		[aCoder encodeObject:self.senderInfo forKey:kDataSenderInfo];
	}

}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.count = [[aDecoder decodeObjectForKey:kDataCount] integerValue];
	self.messageSummaryInfo = [aDecoder decodeObjectForKey:kDataMessageSummaryInfo];
	self.proxyInfo = [aDecoder decodeObjectForKey:kDataProxyInfo];
	self.senderInfo = [aDecoder decodeObjectForKey:kDataSenderInfo];
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	AccountNotice *copy = [AccountNotice new];

	copy.count = self.count;
	copy.messageSummaryInfo = [self.messageSummaryInfo copy];
	copy.proxyInfo = [self.proxyInfo copy];
	copy.senderInfo = [self.senderInfo copy];

	return copy;
}
@end
