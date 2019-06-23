#import <Realm/Realm.h>
RLM_ARRAY_TYPE(realmMessageModel)
@class realmMessageModel;
RLM_ARRAY_TYPE(mediainfoListModel)
@class mediainfoListModel;
//RLM_ARRAY_TYPE ()
@interface RealmRecordModel : RLMObject

@property (nonatomic, strong) realmMessageModel * realmMessageModel;
@property (nonatomic, strong) NSString * idField;
@property (nonatomic, strong) NSString * content;
@property (nonatomic, strong) NSString * createdAt;
@property (nonatomic, strong) NSString * extraData;
@property (nonatomic, strong) NSString * extraType;
@property (nonatomic, strong) NSString * groupId;
@property (nonatomic, strong) RLMArray<mediainfoListModel>* mediaInfoList;
@property (nonatomic, assign) NSInteger messageMimeKind;
@property (nonatomic, assign) NSInteger messageType;
@property (nonatomic, strong) NSString * proxyId;
@property (nonatomic, strong) NSString * senderId;
@property (nonatomic, assign) NSInteger state;
@property (nonatomic, strong) NSString * title;
@property (nonatomic, strong) NSString * updatedAt;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end
