#import <UIKit/UIKit.h>
#import "BalanceMoneyModel.h"
#import "WeChatModel.h"
#import "BossEnumDefin.h"
#import "configModel.h"
#import "TokenModel.h"

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
// 刷新token
@property (nonatomic, strong) NSString * refreshToken;

// 健康证结束时间
@property (nonatomic, assign) NSInteger healthcertificateend;

//健康证开始时间
@property (nonatomic, assign) NSInteger healthcertificatestart;


//  健康证图片key(正面照片)
@property (nonatomic, strong) NSString * healthCertificateKey;

// 健康证图片key(背面照片)
@property (nonatomic, strong) NSString * healthCertificateBackKey;

//  健康证图片url(正面照片)
@property (nonatomic, strong) NSString * healthcertificateurl;

// 健康证图片url(背面照片)
@property (nonatomic, strong) NSString * healthcertificatebackurl;

//健康证的有效天数
@property (nonatomic, assign) NSInteger healthEffectDays;

@property (nonatomic, assign) BOOL isshowJoinTeam;

// 身份证类型 10正常的身份证类型,20临时的身份证类型
@property (nonatomic, assign) IdentityType idcardType;

// 身份证开始时间
@property (nonatomic, assign) NSInteger idcardStartDate;

//身份证结束时间
@property (nonatomic, assign) NSInteger idcardEndDate;

// 临时身份证的剩余有限天数
@property (nonatomic, assign) NSInteger temporaryIdcardEffectDays;

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

//健康证件是否完善
@property (nonatomic, assign) BOOL healthCardIsOK;

//身份证状态
@property (nonatomic, assign, readonly) IdentityStatus identityStatus;
//银行卡状态
@property (nonatomic, assign, readonly) BankCardStatus bankCardStatus;

//认证类型 10 身份证 20 人脸
@property (nonatomic, assign) authenticationType authenticationType;

// 汗点三方是否授权
@property (nonatomic, assign,readonly) BOOL hanDianAuth;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;

-(void)updateRefreshTokenWithTokenModel:(TokenModel *)tokenModel;


@end
