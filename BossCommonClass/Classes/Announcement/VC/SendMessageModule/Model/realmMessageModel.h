#import <Realm/Realm.h>
RLM_ARRAY_TYPE(RealmRecordModel)
@class RealmRecordModel;

@interface realmMessageModel : RLMObject

@property (nonatomic, strong) NSString * sectionid;
@property (nonatomic, strong) RLMArray<RealmRecordModel> * realmRecordModels;
@property (nonatomic, strong) NSString * userid;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end
