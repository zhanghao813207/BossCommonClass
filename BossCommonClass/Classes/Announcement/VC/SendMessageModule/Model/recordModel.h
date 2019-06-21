#import <UIKit/UIKit.h>

@interface recordModel : NSObject

@property (nonatomic, strong) NSString * idField;
@property (nonatomic, strong) NSString * accountId;
@property (nonatomic, strong) NSString * createdAt;
@property (nonatomic, assign) BOOL isPin;
@property (nonatomic, strong) NSString * nickName;
@property (nonatomic, assign) BOOL noDisturb;
@property (nonatomic, assign) NSInteger state;
@property (nonatomic, strong) NSString * targetId;
@property (nonatomic, assign) NSInteger targetType;
@property (nonatomic, strong) NSString * updatedAt;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end