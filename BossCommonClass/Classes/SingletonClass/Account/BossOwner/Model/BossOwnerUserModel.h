#import <UIKit/UIKit.h>
#import "BalanceMoneyModel.h"
#import "WeChatModel.h"

@interface BossOwnerUserModel : NSObject

@property (nonatomic, strong) NSString * accessToken;
@property (nonatomic, strong) NSString * accountId;
@property (nonatomic, strong) NSString * bankBranch;
@property (nonatomic, strong) NSString * bankCardFrontUrl;
@property (nonatomic, strong) NSString * bankCardId;
@property (nonatomic, strong) NSArray * bankLocation;
@property (nonatomic, strong) NSString * bankName;
@property (nonatomic, assign) NSInteger birthDate;
@property (nonatomic, strong) NSString * cardholderName;
@property (nonatomic, assign) NSInteger expiredAt;
@property (nonatomic, assign) NSInteger genderId;
@property (nonatomic, strong) NSString * handBustUrl;
@property (nonatomic, strong) NSString * headPortraitPhotoUrl;
@property (nonatomic, strong) NSString * identityCardBackUrl;
@property (nonatomic, strong) NSString * identityCardFrontUrl;
@property (nonatomic, strong) NSString * identityCardId;
@property (nonatomic, strong) NSString * name;
@property (nonatomic, strong) NSString * national;
@property (nonatomic, strong) NSString * nickname;
@property (nonatomic, strong) NSString * phone;
@property (nonatomic, strong) NSString * gender;
@property (nonatomic, assign) BOOL isshowJoinTeam;


//微信绑定信息
@property (nonatomic, strong) WeChatModel *WeChatModel;

//钱包信息
@property (nonatomic, strong) BalanceMoneyModel *WalletModel;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end
