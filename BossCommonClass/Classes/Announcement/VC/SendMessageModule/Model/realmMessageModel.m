//
//	realmMessageModel.m
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "realmMessageModel.h"
#import "RealmRecordModel.h"


@interface realmMessageModel ()
@end
@implementation realmMessageModel




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	if(dictionary == nil || [dictionary isKindOfClass:[NSNull class]]){
		return nil;
	}
	self = [super init];

	if(![dictionary[@"sectionid"] isKindOfClass:[NSNull class]]){
		self.sectionid = dictionary[@"sectionid"];
	}

	if(dictionary[@"realmRecordModel"] != nil && ![dictionary[@"realmRecordModel"] isKindOfClass:[NSNull class]]){
		NSArray * realmRecordModelDictionaries = dictionary[@"realmRecordModel"];
		RLMArray * realmRecordModelItems = [[RLMArray alloc] initWithObjectClassName:[RealmRecordModel className]];
		for(NSDictionary * realmRecordModelDictionary in realmRecordModelDictionaries){
			RealmRecordModel * realmRecordModelItem = [[RealmRecordModel alloc] initWithDictionary:realmRecordModelDictionary];
			[realmRecordModelItems addObject:realmRecordModelItem];
		}
        self.realmRecordModels = (RLMArray<RealmRecordModel> *)realmRecordModelItems;
	}
	if(![dictionary[@"userid"] isKindOfClass:[NSNull class]]){
		self.userid = dictionary[@"userid"];
	}

	return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	if(self.sectionid != nil){
		dictionary[@"sectionid"] = self.sectionid;
	}
    if(self.realmRecordModels != nil){
		NSMutableArray * dictionaryElements = [NSMutableArray array];
        for(RealmRecordModel * realmRecordModelElement in self.realmRecordModels){
			[dictionaryElements addObject:[realmRecordModelElement toDictionary]];
		}
		dictionary[@"realmRecordModel"] = dictionaryElements;
	}
	if(self.userid != nil){
		dictionary[@"userid"] = self.userid;
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
	if(self.sectionid != nil){
		[aCoder encodeObject:self.sectionid forKey:@"sectionid"];
	}
    if(self.realmRecordModels != nil){
        [aCoder encodeObject:self.realmRecordModels forKey:@"realmRecordModel"];
	}
	if(self.userid != nil){
		[aCoder encodeObject:self.userid forKey:@"userid"];
	}

}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.sectionid = [aDecoder decodeObjectForKey:@"sectionid"];
    self.realmRecordModels = [aDecoder decodeObjectForKey:@"realmRecordModel"];
	self.userid = [aDecoder decodeObjectForKey:@"userid"];
	return self;

}
@end
