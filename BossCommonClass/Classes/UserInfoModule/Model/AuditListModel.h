#import <UIKit/UIKit.h>

@interface AuditListModel : NSObject

@property (nonatomic, strong) NSString * idField;
@property (nonatomic, strong) NSString * birthDate;
@property (nonatomic, strong) NSString * createdAt;
@property (nonatomic, strong) NSString * genderId;
@property (nonatomic, strong) NSString * handBustUrl;
@property (nonatomic, strong) NSString * idcardEndDate;
@property (nonatomic, strong) NSString * idcardStartDate;
@property (nonatomic, strong) NSString * idcardType;
@property (nonatomic, strong) NSString * identityCardBackUrl;
@property (nonatomic, strong) NSString * identityCardFrontUrl;
@property (nonatomic, strong) NSString * identityCardId;
@property (nonatomic, strong) NSString * name;
@property (nonatomic, strong) NSString * national;
@property (nonatomic, strong) NSString * oldHandBustUrl;
@property (nonatomic, strong) NSString * oldIdentityCardBackUrl;
@property (nonatomic, strong) NSString * oldIdentityCardFrontUrl;
@property (nonatomic, strong) NSString * oldIdentityCardId;
@property (nonatomic, strong) NSString * oldName;
@property (nonatomic, strong) NSString * reason;
@property (nonatomic, assign) NSInteger state;
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, strong) NSString * updatedAt;
@property (nonatomic, strong) NSString * stateStr;
@property (nonatomic, strong) NSString * currentstateStr;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end
