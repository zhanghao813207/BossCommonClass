//
//	MessageSummaryInfo.m
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "MessageSummaryInfo.h"
#import "JYCSimpleToolClass.h"
#import "NSDate+Helper.h"
#import "NSDate+Extension.h"
#import "NSString+Time.h"


NSString *const kmessageSessionsModelExtraData = @"extra_data";


NSString *const kMessageSummaryInfoIdField = @"_id";
NSString *const kMessageSummaryInfoContent = @"content";
NSString *const kMessageSummaryInfoCreatedAt = @"created_at";
NSString *const kMessageSummaryInfoExtraType = @"extra_type";
NSString *const kMessageSummaryInfoMessageType = @"message_type";
NSString *const kMessageSummaryInfoTitle = @"title";
NSString *const kMessageMessagemimekindTitle = @"message_mime_kind";


@interface MessageSummaryInfo ()
@end
@implementation MessageSummaryInfo




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
    if ([dictionary isKindOfClass:[NSNull class]]) {
        return self;
    }
    
    if(![dictionary[kmessageSessionsModelExtraData] isKindOfClass:[NSNull class]]){
        
        self.extra_data = [[NSDictionary alloc] initWithDictionary:dictionary[kmessageSessionsModelExtraData]];
    }
    
    
    
	if(![dictionary[kMessageSummaryInfoIdField] isKindOfClass:[NSNull class]]){
		self.idField = dictionary[kMessageSummaryInfoIdField];
	}	
	if(![dictionary[kMessageSummaryInfoContent] isKindOfClass:[NSNull class]]){
		self.content = dictionary[kMessageSummaryInfoContent];
	}	
	if(![dictionary[kMessageSummaryInfoCreatedAt] isKindOfClass:[NSNull class]]){
		self.createdAt = dictionary[kMessageSummaryInfoCreatedAt];
	}	
	if(![dictionary[kMessageSummaryInfoExtraType] isKindOfClass:[NSNull class]]){
		self.extraType = [dictionary[kMessageSummaryInfoExtraType] integerValue];
	}

	if(![dictionary[kMessageSummaryInfoMessageType] isKindOfClass:[NSNull class]]){
		self.messageType = [dictionary[kMessageSummaryInfoMessageType] integerValue];
	}

	if(![dictionary[kMessageSummaryInfoTitle] isKindOfClass:[NSNull class]]){
		self.title = dictionary[kMessageSummaryInfoTitle];
	}
    if(![dictionary[kMessageMessagemimekindTitle] isKindOfClass:[NSNull class]]){
        self.messagemimekind = [dictionary[kMessageMessagemimekindTitle] integerValue];
    }
	return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
    
    
    if(self.extra_data != nil){
//        dictionary[kmessageSessionsModelExtraData] = [self.extra_data toDictionary];
    }
    
    
	if(self.idField != nil){
		dictionary[kMessageSummaryInfoIdField] = self.idField;
	}
	if(self.content != nil){
		dictionary[kMessageSummaryInfoContent] = self.content;
	}
	if(self.createdAt != nil){
		dictionary[kMessageSummaryInfoCreatedAt] = self.createdAt;
	}
	dictionary[kMessageSummaryInfoExtraType] = @(self.extraType);
	dictionary[kMessageSummaryInfoMessageType] = @(self.messageType);
	if(self.title != nil){
		dictionary[kMessageSummaryInfoTitle] = self.title;
	}
    dictionary[kMessageMessagemimekindTitle] = @(self.messagemimekind);

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
    
    if(self.extra_data != nil){
        [aCoder encodeObject:self.extra_data forKey:kmessageSessionsModelExtraData];
    }
    
	if(self.idField != nil){
		[aCoder encodeObject:self.idField forKey:kMessageSummaryInfoIdField];
	}
	if(self.content != nil){
		[aCoder encodeObject:self.content forKey:kMessageSummaryInfoContent];
	}
	if(self.createdAt != nil){
		[aCoder encodeObject:self.createdAt forKey:kMessageSummaryInfoCreatedAt];
	}
	[aCoder encodeObject:@(self.extraType) forKey:kMessageSummaryInfoExtraType];	[aCoder encodeObject:@(self.messageType) forKey:kMessageSummaryInfoMessageType];	if(self.title != nil){
		[aCoder encodeObject:self.title forKey:kMessageSummaryInfoTitle];
	}

}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
    
    
    self.extra_data = [aDecoder decodeObjectForKey:kmessageSessionsModelExtraData];
    
	self.idField = [aDecoder decodeObjectForKey:kMessageSummaryInfoIdField];
	self.content = [aDecoder decodeObjectForKey:kMessageSummaryInfoContent];
	self.createdAt = [aDecoder decodeObjectForKey:kMessageSummaryInfoCreatedAt];
	self.extraType = [[aDecoder decodeObjectForKey:kMessageSummaryInfoExtraType] integerValue];
	self.messageType = [[aDecoder decodeObjectForKey:kMessageSummaryInfoMessageType] integerValue];
	self.title = [aDecoder decodeObjectForKey:kMessageSummaryInfoTitle];
	return self;

    
}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	MessageSummaryInfo *copy = [MessageSummaryInfo new];

    copy.extra_data = [self.extra_data copy];

    
	copy.idField = [self.idField copy];
	copy.content = [self.content copy];
	copy.createdAt = [self.createdAt copy];
	copy.extraType = self.extraType;
	copy.messageType = self.messageType;
	copy.title = [self.title copy];

	return copy;
}
-(NSString *)showAt_time{
    NSString *normalTime = [JYCSimpleToolClass fastChangeToNormalTimeWithString:self.createdAt];
    NSDate *normalDate = [NSDate dateFromString:normalTime];
    NSString *tempDate = [NSDate stringFromDate:normalDate withFormat:@"yyyy-MM-dd HH:mm:ss"];
    return [tempDate getTimeStr:@""];
}
- (NSString *)showAt {
    
    NSString *normalTime = [JYCSimpleToolClass fastChangeToNormalTimeWithString:self.createdAt];
    
    NSDate *date = [NSDate dateFromString:normalTime withFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSString *mainString = [JYCSimpleToolClass standardTimeFormatterToWChatTimeFormatterByDate:date nowDate:[NSDate date] showToday:YES showFullYear:NO showChineYear:YES];
    
//    NSString *mainTitleString = [JYCSimpleToolClass standardTimeFormatterToWChatTimeFormatterByDate:date nowDate:[NSDate date] showToday:NO showFullYear:YES showChineYear:YES];
//
//    NSString *lastString = [JYCSimpleToolClass segementOneDayByDate:date segement:YES];
    
    return mainString;
}
@end
