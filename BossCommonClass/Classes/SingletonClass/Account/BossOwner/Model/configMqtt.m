//
//	configMqtt.m
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "configMqtt.h"

NSString *const kconfigMqttClientid = @"clientid";
NSString *const kconfigMqttPassword = @"password";
NSString *const kconfigMqttPort = @"port";
NSString *const kconfigMqttSecretKey = @"secret_key";
NSString *const kconfigMqttServer = @"server";
NSString *const kconfigMqttUserName = @"user_name";

@interface configMqtt ()
@end
@implementation configMqtt




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
    if ([dictionary isKindOfClass:[NSNull class]]) {
        return self;
    }
	if(![dictionary[kconfigMqttClientid] isKindOfClass:[NSNull class]]){
		self.clientid = dictionary[kconfigMqttClientid];
	}	
	if(![dictionary[kconfigMqttPassword] isKindOfClass:[NSNull class]]){
		self.password = dictionary[kconfigMqttPassword];
	}	
	if(![dictionary[kconfigMqttPort] isKindOfClass:[NSNull class]]){
		self.port = [dictionary[kconfigMqttPort] integerValue];
	}

	if(![dictionary[kconfigMqttSecretKey] isKindOfClass:[NSNull class]]){
		self.secretKey = dictionary[kconfigMqttSecretKey];
	}	
	if(![dictionary[kconfigMqttServer] isKindOfClass:[NSNull class]]){
		self.server = dictionary[kconfigMqttServer];
	}	
	if(![dictionary[kconfigMqttUserName] isKindOfClass:[NSNull class]]){
		self.userName = dictionary[kconfigMqttUserName];
	}	
	return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	if(self.clientid != nil){
		dictionary[kconfigMqttClientid] = self.clientid;
	}
	if(self.password != nil){
		dictionary[kconfigMqttPassword] = self.password;
	}
	dictionary[kconfigMqttPort] = @(self.port);
	if(self.secretKey != nil){
		dictionary[kconfigMqttSecretKey] = self.secretKey;
	}
	if(self.server != nil){
		dictionary[kconfigMqttServer] = self.server;
	}
	if(self.userName != nil){
		dictionary[kconfigMqttUserName] = self.userName;
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
	if(self.clientid != nil){
		[aCoder encodeObject:self.clientid forKey:kconfigMqttClientid];
	}
	if(self.password != nil){
		[aCoder encodeObject:self.password forKey:kconfigMqttPassword];
	}
	[aCoder encodeObject:@(self.port) forKey:kconfigMqttPort];	if(self.secretKey != nil){
		[aCoder encodeObject:self.secretKey forKey:kconfigMqttSecretKey];
	}
	if(self.server != nil){
		[aCoder encodeObject:self.server forKey:kconfigMqttServer];
	}
	if(self.userName != nil){
		[aCoder encodeObject:self.userName forKey:kconfigMqttUserName];
	}

}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.clientid = [aDecoder decodeObjectForKey:kconfigMqttClientid];
	self.password = [aDecoder decodeObjectForKey:kconfigMqttPassword];
	self.port = [[aDecoder decodeObjectForKey:kconfigMqttPort] integerValue];
	self.secretKey = [aDecoder decodeObjectForKey:kconfigMqttSecretKey];
	self.server = [aDecoder decodeObjectForKey:kconfigMqttServer];
	self.userName = [aDecoder decodeObjectForKey:kconfigMqttUserName];
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	configMqtt *copy = [configMqtt new];

	copy.clientid = [self.clientid copy];
	copy.password = [self.password copy];
	copy.port = self.port;
	copy.secretKey = [self.secretKey copy];
	copy.server = [self.server copy];
	copy.userName = [self.userName copy];

	return copy;
}
@end
