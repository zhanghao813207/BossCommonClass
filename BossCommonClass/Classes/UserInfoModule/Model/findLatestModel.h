#import <UIKit/UIKit.h>
#import "BossEnumDefin.h"

@interface findLatestModel : NSString

@property (nonatomic, strong) NSString * idField;
@property (nonatomic, strong) NSString * accountId;
@property (nonatomic, strong) NSString * birthDate;
@property (nonatomic, strong) NSString * createdAt;
@property (nonatomic, strong) NSString * creatorId;
@property (nonatomic, strong) NSString * doneAt;
@property (nonatomic, strong) NSString * genderId;
@property (nonatomic, strong) NSString * handBustAssetId;
@property (nonatomic, strong) NSString * idcardBackAssetId;
@property (nonatomic, strong) NSString * idcardEndDate;
@property (nonatomic, strong) NSString * idcardFrontAssetId;
@property (nonatomic, strong) NSString * idcardStartDate;
@property (nonatomic, strong) NSString * idcardType;
@property (nonatomic, strong) NSString * identityCardId;
@property (nonatomic, strong) NSString * lastOperatorTeamId;
@property (nonatomic, strong) NSString * name;
@property (nonatomic, strong) NSString * national;
@property (nonatomic, strong) NSString * operatorId;
@property (nonatomic, strong) NSString * reason;
@property (nonatomic, strong) NSString * rejectedAt;
@property (nonatomic, assign) NSInteger state;
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, strong) NSString * updatedAt;
@property (nonatomic, assign) NSInteger dcardeffectdays;

@property (nonatomic, assign) SelectModifyOperationType updateType;
@property (nonatomic, assign) changeUserInfoCurrentstate updatestate;
@property (nonatomic, strong) NSString *currentState;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end
