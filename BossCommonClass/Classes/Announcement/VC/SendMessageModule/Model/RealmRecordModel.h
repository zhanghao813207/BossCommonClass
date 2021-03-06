#import <Realm/Realm.h>
RLM_ARRAY_TYPE(realmMessageModel)
@class realmMessageModel;
RLM_ARRAY_TYPE(mediainfoListModel)
@class mediainfoListModel;
//RLM_ARRAY_TYPE ()
@interface RealmRecordModel : RLMObject

@property (nonatomic, strong) realmMessageModel * realmMessageModel;
@property (nonatomic, assign) BOOL isShowTime;
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
@property (nonatomic, strong) NSString * sectionid;
@property (nonatomic, strong) NSString * userid;
@property (nonatomic, strong) NSString * showAt_time;
// 是否失败
@property (nonatomic, assign) BOOL iserror;
// 图片转base64
@property (nonatomic, strong) NSString *encodedImageStr;
// 发送状态 200成功 100发送中 0失败
@property (nonatomic, assign) NSInteger sendstate;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end
