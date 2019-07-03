#import <UIKit/UIKit.h>

@interface SendResultModel : NSObject

@property (nonatomic, strong) NSString * idField;
@property (nonatomic, strong) NSString * content;
@property (nonatomic, strong) NSString * createdAt;
@property (nonatomic, strong) NSString * extraData;
@property (nonatomic, strong) NSString * extraType;
@property (nonatomic, strong) NSString * groupId;
@property (nonatomic, strong) NSArray * mediaInfoList;
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