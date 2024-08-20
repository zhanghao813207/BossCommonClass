//
//	Data.m
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "Message.h"

NSString *const kDataIdField = @"_id";
NSString *const kDataAccountId = @"account_id";
NSString *const kDataName = @"name";
NSString *const kDataProxyAccountInfo = @"proxy_account_info";
NSString *const kDatatype = @"type";
NSString *const kDataHeadimgUrl = @"head_img_url";
NSString *const kDataDarkModeHeadimgUrl = @"dark_mode_head_img_url";

@interface Message ()
@end
@implementation Message


- (BOOL)isEqual:(Message *)object{
    if (self == object){
        return true;
    }
    // ID 相等 名字相等 图标相等
    if ([self.idField isEqualToString:object.idField] && [self.name isEqualToString:object.name] && [[self ImageCharacteristicsAndString:self.headimgurl] isEqualToString:[self ImageCharacteristicsAndString:object.headimgurl]]){
        return true;
    }
    return false;
}
// ?分割为2个字符串
- (NSString *)ImageCharacteristicsAndString:(NSString *)url{
    NSArray *urlArr = [url componentsSeparatedByString:@"?"];
    // 数量为2 表示分割成功 返回下表为0的字符串
    if (urlArr.count == 2) {
        return urlArr[0];
    }
    return @"";
}
/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
    if ([dictionary isKindOfClass:[NSNull class]]) {
        return self;
    }
	if(![dictionary[kDataIdField] isKindOfClass:[NSNull class]]){
		self.idField = dictionary[kDataIdField];
	}
    if(![dictionary[kDatatype] isKindOfClass:[NSNull class]]){
        self.type = [dictionary[kDatatype] integerValue];
        self.messageType = self.type;
    }
	if(![dictionary[kDataAccountId] isKindOfClass:[NSNull class]]){
		self.accountId = dictionary[kDataAccountId];
	}	
	if(![dictionary[kDataName] isKindOfClass:[NSNull class]]){
		self.name = dictionary[kDataName];
	}	
	if(![dictionary[kDataProxyAccountInfo] isKindOfClass:[NSNull class]]){
		self.proxyAccountInfo = [[ProxyAccountInfo alloc] initWithDictionary:dictionary[kDataProxyAccountInfo]];
	}
    if(![dictionary[kDataHeadimgUrl] isKindOfClass:[NSNull class]]){
        self.headimgurl = dictionary[kDataHeadimgUrl];
    }
    if(![dictionary[kDataDarkModeHeadimgUrl] isKindOfClass:[NSNull class]]){
        self.DarkModeHeadimgUrl = dictionary[kDataDarkModeHeadimgUrl];
    }
    if(![dictionary[@"extra_data"] isKindOfClass:[NSNull class]] && ![dictionary[@"extra_data"][@"target_type"] isKindOfClass:[NSNull class]]){
        self.messageTargetType = [dictionary[@"extra_data"][@"target_type"] integerValue];
    }

	return self;
}
/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	if(self.idField != nil){
		dictionary[kDataIdField] = self.idField;
	}
    if(self.headimgurl != nil){
        dictionary[kDataHeadimgUrl] = self.headimgurl;
    }
	if(self.accountId != nil){
		dictionary[kDataAccountId] = self.accountId;
	}
	if(self.name != nil){
		dictionary[kDataName] = self.name;
	}
	if(self.proxyAccountInfo != nil){
		dictionary[kDataProxyAccountInfo] = [self.proxyAccountInfo toDictionary];
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
	if(self.idField != nil){
		[aCoder encodeObject:self.idField forKey:kDataIdField];
	}
	if(self.accountId != nil){
		[aCoder encodeObject:self.accountId forKey:kDataAccountId];
	}
	if(self.name != nil){
		[aCoder encodeObject:self.name forKey:kDataName];
	}
	if(self.proxyAccountInfo != nil){
		[aCoder encodeObject:self.proxyAccountInfo forKey:kDataProxyAccountInfo];
	}

}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.idField = [aDecoder decodeObjectForKey:kDataIdField];
	self.accountId = [aDecoder decodeObjectForKey:kDataAccountId];
	self.name = [aDecoder decodeObjectForKey:kDataName];
	self.proxyAccountInfo = [aDecoder decodeObjectForKey:kDataProxyAccountInfo];
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	Message *copy = [Message new];

	copy.idField = [self.idField copy];
	copy.accountId = [self.accountId copy];
	copy.name = [self.name copy];
	copy.proxyAccountInfo = [self.proxyAccountInfo copy];

	return copy;
}
@end
