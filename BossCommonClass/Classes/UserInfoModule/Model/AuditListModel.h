#import <UIKit/UIKit.h>
#import "AuditAccountInfo.h"

@interface AuditListModel : NSObject

@property (nonatomic, strong) NSString * idField;
@property (nonatomic, strong) AuditAccountInfo * accountInfo;
@property (nonatomic, strong) NSObject * birthDate;
@property (nonatomic, strong) NSString * createdAt;
@property (nonatomic, strong) NSObject * genderId;
@property (nonatomic, strong) NSString * handBustUrl;
@property (nonatomic, strong) NSObject * idcardEndDate;
@property (nonatomic, strong) NSObject * idcardStartDate;
@property (nonatomic, strong) NSObject * idcardType;
@property (nonatomic, strong) NSString * identityCardBackUrl;
@property (nonatomic, strong) NSString * identityCardFrontUrl;
@property (nonatomic, strong) NSObject * identityCardId;
@property (nonatomic, strong) NSObject * name;
@property (nonatomic, strong) NSObject * national;
@property (nonatomic, strong) NSObject * reason;
@property (nonatomic, assign) NSInteger state;
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, strong) NSString * updatedAt;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end