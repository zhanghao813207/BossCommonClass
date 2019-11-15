#import <UIKit/UIKit.h>
#import "BossEnumDefin.h"

@interface findLatestModel : NSObject

@property (nonatomic, strong) NSString * idField;
@property (nonatomic, strong) NSString * accountId;
@property (nonatomic, strong) NSObject * birthDate;
@property (nonatomic, strong) NSString * createdAt;
@property (nonatomic, strong) NSString * creatorId;
@property (nonatomic, strong) NSObject * doneAt;
@property (nonatomic, strong) NSObject * genderId;
@property (nonatomic, strong) NSObject * handBustAssetId;
@property (nonatomic, strong) NSObject * idcardBackAssetId;
@property (nonatomic, strong) NSObject * idcardEndDate;
@property (nonatomic, strong) NSObject * idcardFrontAssetId;
@property (nonatomic, strong) NSObject * idcardStartDate;
@property (nonatomic, strong) NSObject * idcardType;
@property (nonatomic, strong) NSObject * identityCardId;
@property (nonatomic, strong) NSString * lastOperatorTeamId;
@property (nonatomic, strong) NSObject * name;
@property (nonatomic, strong) NSObject * national;
@property (nonatomic, strong) NSString * operatorId;
@property (nonatomic, strong) NSObject * reason;
@property (nonatomic, strong) NSObject * rejectedAt;
@property (nonatomic, assign) NSInteger state;
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, strong) NSString * updatedAt;
@property (nonatomic, assign) SelectModifyOperationType updateType;
@property (nonatomic, assign) changeUserInfoCurrentstate updatestate;
@property (nonatomic, strong) NSString *currentState;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end
