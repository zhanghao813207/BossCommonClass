#import <Realm/Realm.h>

@interface mediainfoListModel : RLMObject

@property (nonatomic, strong) NSString * fileType;
@property (nonatomic, strong) NSString * idField;
@property (nonatomic, strong) NSString * url;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end