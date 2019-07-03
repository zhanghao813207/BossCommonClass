//
//	mediainfoListModel.m
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "mediainfoListModel.h"

@interface mediainfoListModel ()
@end
@implementation mediainfoListModel




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	if(dictionary == nil || [dictionary isKindOfClass:[NSNull class]]){
		return nil;
	}
	self = [super init];

	if(![dictionary[@"file_type"] isKindOfClass:[NSNull class]]){
		self.fileType = dictionary[@"file_type"];
	}

	if(![dictionary[@"id"] isKindOfClass:[NSNull class]]){
		self.idField = dictionary[@"id"];
	}

	if(![dictionary[@"url"] isKindOfClass:[NSNull class]]){
		self.url = dictionary[@"url"];
	}

	return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	if(self.fileType != nil){
		dictionary[@"file_type"] = self.fileType;
	}
	if(self.idField != nil){
		dictionary[@"id"] = self.idField;
	}
	if(self.url != nil){
		dictionary[@"url"] = self.url;
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
	if(self.fileType != nil){
		[aCoder encodeObject:self.fileType forKey:@"file_type"];
	}
	if(self.idField != nil){
		[aCoder encodeObject:self.idField forKey:@"id"];
	}
	if(self.url != nil){
		[aCoder encodeObject:self.url forKey:@"url"];
	}

}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.fileType = [aDecoder decodeObjectForKey:@"file_type"];
	self.idField = [aDecoder decodeObjectForKey:@"id"];
	self.url = [aDecoder decodeObjectForKey:@"url"];
	return self;

}
@end