#import <UIKit/UIKit.h>
#import "BalanceMoneyModel.h"
#import "WeChatModel.h"
#import "BossEnumDefin.h"
#import "configModel.h"

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
// 结束时间
@property (nonatomic, assign) NSInteger healthcertificateend;

// 开始时间
@property (nonatomic, assign) NSInteger healthcertificatestart;

//  健康证图片url(正面照片)
@property (nonatomic, strong) NSString * healthcertificateurl;

// 健康证图片url(背面照片)
@property (nonatomic, strong) NSString * healthcertificatebackurl;

@property (nonatomic, assign) BOOL isshowJoinTeam;

/**
 签约类型
 */
@property (nonatomic, assign) StaffSignType sign_type;

//微信绑定信息
@property (nonatomic, strong) WeChatModel *WeChatModel;

//钱包信息
@property (nonatomic, strong) BalanceMoneyModel *WalletModel;

//网络配置信息
@property (nonatomic, strong) configModel *configModel;
/**
 检查是否电子签约
 */
@property (nonatomic, assign, readonly) BOOL checkElectronicContract;

/**
 检查是否解约中
 - 站长提交解约后变为解约中
 */
@property (nonatomic, assign, readonly) BOOL checkStaffDeparture;

/**
 人员状态(1:待签约 100:已签约-正常 101:已签约-待换签 102:已签约-待续签 -100:已解约)
 */
@property (nonatomic, assign) StaffStates state;

//身份证状态
@property (nonatomic, assign, readonly) IdentityStatus identityStatus;
//银行卡状态
@property (nonatomic, assign, readonly) BankCardStatus bankCardStatus;
//工作证件是否完善
@property (nonatomic, assign, readonly) BOOL workCardIsDone;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end
