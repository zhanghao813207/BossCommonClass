//
//	BossOwnerUserModel.m
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "BossOwnerUserModel.h"
#import "NSString+base.h"
#import "YYCache.h"
@import boss_basic_common_ios;

NSString *const kBossOwnerUserModelAccessToken = @"access_token";
NSString *const kBossOwnerUserModelAccountId = @"_id";
NSString *const kBossOwnerUserModelBankBranch = @"bank_name";
NSString *const kBossOwnerUserModelBankCardFrontUrl = @"bank_card_front_url";
NSString *const kBossOwnerUserModelBankCardId = @"bank_card_id";
NSString *const kBossOwnerUserModelBankLocation = @"bank_location";
NSString *const kBossOwnerUserModelBankName = @"bank_branch";
NSString *const kBossOwnerUserModelBirthDate = @"birth_date";
NSString *const kBossOwnerUserModelCardholderName = @"cardholder_name";
NSString *const kBossOwnerUserModelExpiredAt = @"expired_at";
NSString *const kBossOwnerUserModelGenderId = @"gender_id";
NSString *const kBossOwnerUserModelHandBustUrl = @"hand_bust_url";
NSString *const kBossOwnerUserModelHeadPortraitPhotoUrl = @"head_portrait_photo_url";
NSString *const kBossOwnerUserModelIdentityCardBackUrl = @"identity_card_back_url";
NSString *const kBossOwnerUserModelIdentityCardFrontUrl = @"identity_card_front_url";
NSString *const kBossOwnerUserModelIdentityCardId = @"identity_card_id";
NSString *const kBossOwnerUserModelName = @"name";
NSString *const kBossOwnerUserModelNational = @"national";
NSString *const kBossOwnerUserModelNickname = @"nickname";
NSString *const kBossOwnerUserModelphone = @"phone";
NSString *const kBossOwnerUserModelRefreshToken = @"refresh_token";

NSString *const kBossOwnerUserWechatModel = @"wechat_account";
NSString *const kBossOwnerUserWalletModel = @"wallet_info";
NSString *const kBossOwnerauthentication_type = @"authentication_type";
// 结束时间
NSString *const kBossOwnerUserhealthcertificateendModel = @"health_certificate_end";

// 开始时间
NSString *const kBossOwnerUserhealthcertificatestart = @"health_certificate_start";

//  健康证图片url(正面照片)
NSString *const kBossOwnerUserhealthcertificateurl = @"health_certificate_url";

// 健康证图片url(背面照片)
NSString *const kBossOwnerUserhealthcertificatebackurl = @"health_certificate_back_url";

// 网络配置
NSString *const kBossOwnerconfigurl = @"config";

// 身份证类型
NSString *const kBossOwnerUserIDcardType = @"idcard_type";

// 身份证开始时间
NSString *const kBossOwnerUserIDcardStartDate = @"idcard_start_date";

//  身份证结束时间
NSString *const kBossOwnerUserIDcardEndDate = @"idcard_end_date";

// 临时身份证的剩余有限天数
NSString *const kBossOwnerUserTemporaryIDcardEffectDays = @"temporary_idcard_effect_days";

// 健康证剩余有效天数
NSString *const kBossOwnerUserHealthEffectDays = @"health_certificate_effect_days";

// 健康证是否完善
NSString *const kBossOwnerUserHealthCardIsOk = @"health_card_is_ok";

// 健康证正面key
NSString *const kBossOwnerUserHealthCertificateKey = @"health_certificate";

// 健康证反面key
NSString *const kBossOwnerUserHealthCertificateBackKey = @"health_certificate_back";

// 是否发起注销申请
NSString *const kBossOwnerhascancellationapplyKey = @"has_cancellation_apply";



@interface BossOwnerUserModel ()
@end
@implementation BossOwnerUserModel

-(void)updateRefreshTokenWithTokenModel:(TokenModel *)tokenModel
{
    self.refreshToken = tokenModel.refresh_token;
    self.expiredAt = tokenModel.expiredAt;
    self.accessToken = tokenModel.access_token;
}

-(BOOL)hanDianAuth{
    NSString *authKey = [NSString stringWithFormat:@"%@threeAuthAgree",self.accountId];
    return  [[NSUserDefaults standardUserDefaults] valueForKey:authKey];
}

/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */
- (BOOL)checkElectronicContract
{
    return self.sign_type == StaffSignTypeElectronic;
}

- (BOOL)checkStaffDeparture
{
    return self.state == StaffStateDeparture;
}
//身份信息状态
- (IdentityStatus)identityStatus
{
    if(self.identityCardBackUrl == nil ||[self.identityCardBackUrl isEqualToString:@""] || self.identityCardFrontUrl == nil ||[self.identityCardFrontUrl isEqualToString:@""])
    {
        return IdentityStatusFew;
    }
    
    if (self.handBustUrl == nil || [self.handBustUrl isEqualToString:@""] )
    {
        return IdentityStatusMissSome;
    }
    return IdentityStatusDone;
}
//银行卡信息状态
- (BankCardStatus)bankCardStatus
{
    if( self.bankCardId == nil ||[self.bankCardId isEqualToString:@""])
    {
        return BankCardStatusNOCardId;
    }
    if(self.bankCardId != nil && (self.cardholderName == nil ||[self.cardholderName isEqualToString:@""] || self.bankName == nil || [self.bankName isEqualToString:@""]
       || self.bankBranch == nil || [self.bankBranch isEqualToString:@""] || self.bankLocation == nil ))
    {
        return BankCardStatusNOSome;
    }
    return BankCardStatusDone;
}


- (NSString *)showIdcardEndDate{
    
    if (self.idcardEndDate > 20990000){
        return @"长期";
    }
    NSString *endStr = [NSString stringWithFormat:@"%ld", self.idcardEndDate];
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    format.dateFormat = @"yyyyMMdd";
    NSDate *date = [format dateFromString:endStr];
    format.dateFormat = @"yyyy.MM.dd";
    if ([format stringFromDate:date]) {
        return [format stringFromDate:date];
    }
    return @"";
}

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
    
    if ([dictionary isKindOfClass:[NSNull class]]) {
        return self;
    }
    
    [[CacheManager manager]setValueForKey:@"USERINFO" :dictionary];
    
    if(![dictionary[kBossOwnerUserhealthcertificateendModel] isKindOfClass:[NSNull class]]){
        self.healthcertificateend = [dictionary[kBossOwnerUserhealthcertificateendModel] integerValue];
    }
    
    if(![dictionary[kBossOwnerauthentication_type] isKindOfClass:[NSNull class]]){
        self.authenticationType = [dictionary[kBossOwnerauthentication_type] integerValue];
    }
    
    if(![dictionary[kBossOwnerUserhealthcertificatestart] isKindOfClass:[NSNull class]]){
        self.healthcertificatestart = [dictionary[kBossOwnerUserhealthcertificatestart] integerValue];
    }
    if(![dictionary[kBossOwnerUserhealthcertificateurl] isKindOfClass:[NSNull class]]){
        self.healthcertificateurl = dictionary[kBossOwnerUserhealthcertificateurl];
    }
    if(![dictionary[kBossOwnerUserhealthcertificatebackurl] isKindOfClass:[NSNull class]]){
        self.healthcertificatebackurl = dictionary[kBossOwnerUserhealthcertificatebackurl];
    }
	
	if(![dictionary[kBossOwnerhascancellationapplyKey] isKindOfClass:[NSNull class]]){
		self.hasCancellationApply = [dictionary[kBossOwnerhascancellationapplyKey] boolValue];
	}
	
    if(![dictionary[kBossOwnerUserModelphone] isKindOfClass:[NSNull class]]){
        self.phone = dictionary[kBossOwnerUserModelphone];
    }
    
	if(![dictionary[kBossOwnerUserModelAccessToken] isKindOfClass:[NSNull class]]){
		self.accessToken = dictionary[kBossOwnerUserModelAccessToken];
        
        YYCache *cache = [[YYCache alloc] initWithName: @"QH"];
        [cache setObject:self.accessToken forKey: @"accessToken"];
	}
    
    if(![dictionary[kBossOwnerUserModelRefreshToken] isKindOfClass:[NSNull class]]){
        self.refreshToken = dictionary[kBossOwnerUserModelRefreshToken];
    }
    if(![dictionary[kBossOwnerUserModelphone] isKindOfClass:[NSNull class]]){
        self.phone = dictionary[kBossOwnerUserModelphone];
    }
	if(![dictionary[kBossOwnerUserModelAccountId] isKindOfClass:[NSNull class]]){
		self.accountId = dictionary[kBossOwnerUserModelAccountId];
	}	
	if(![dictionary[kBossOwnerUserModelBankBranch] isKindOfClass:[NSNull class]]){
		self.bankBranch = dictionary[kBossOwnerUserModelBankBranch];
	}	
	if(![dictionary[kBossOwnerUserModelBankCardFrontUrl] isKindOfClass:[NSNull class]]){
		self.bankCardFrontUrl = dictionary[kBossOwnerUserModelBankCardFrontUrl];
	}	
	if(![dictionary[kBossOwnerUserModelBankCardId] isKindOfClass:[NSNull class]]){
		self.bankCardId = dictionary[kBossOwnerUserModelBankCardId];
	}	
	if(![dictionary[kBossOwnerUserModelBankLocation] isKindOfClass:[NSNull class]]){
		self.bankLocation = dictionary[kBossOwnerUserModelBankLocation];
	}	
	if(![dictionary[kBossOwnerUserModelBankName] isKindOfClass:[NSNull class]]){
		self.bankName = dictionary[kBossOwnerUserModelBankName];
	}	
	if(![dictionary[kBossOwnerUserModelBirthDate] isKindOfClass:[NSNull class]]){
		self.birthDate = [dictionary[kBossOwnerUserModelBirthDate] integerValue];
	}

	if(![dictionary[kBossOwnerUserModelCardholderName] isKindOfClass:[NSNull class]]){
		self.cardholderName = dictionary[kBossOwnerUserModelCardholderName];
	}	
	if(![dictionary[kBossOwnerUserModelExpiredAt] isKindOfClass:[NSNull class]]){
		self.expiredAt = [dictionary[kBossOwnerUserModelExpiredAt] integerValue];
	}

	if(![dictionary[kBossOwnerUserModelGenderId] isKindOfClass:[NSNull class]]){
		self.genderId = [dictionary[kBossOwnerUserModelGenderId] integerValue];
        if (self.genderId == 10) {
            self.gender = @"男";
        } else {
            self.gender = @"女";
        }
	}

	if(![dictionary[kBossOwnerUserModelHandBustUrl] isKindOfClass:[NSNull class]]){
		self.handBustUrl = dictionary[kBossOwnerUserModelHandBustUrl];
	}	
	if(![dictionary[kBossOwnerUserModelHeadPortraitPhotoUrl] isKindOfClass:[NSNull class]]){
		self.headPortraitPhotoUrl = dictionary[kBossOwnerUserModelHeadPortraitPhotoUrl];
	}	
	if(![dictionary[kBossOwnerUserModelIdentityCardBackUrl] isKindOfClass:[NSNull class]]){
		self.identityCardBackUrl = dictionary[kBossOwnerUserModelIdentityCardBackUrl];
	}	
	if(![dictionary[kBossOwnerUserModelIdentityCardFrontUrl] isKindOfClass:[NSNull class]]){
		self.identityCardFrontUrl = dictionary[kBossOwnerUserModelIdentityCardFrontUrl];
	}	
	if(![dictionary[kBossOwnerUserModelIdentityCardId] isKindOfClass:[NSNull class]]){
		self.identityCardId = dictionary[kBossOwnerUserModelIdentityCardId];
	}	
	if(![dictionary[kBossOwnerUserModelName] isKindOfClass:[NSNull class]]){
		self.name = dictionary[kBossOwnerUserModelName];
	}	
	if(![dictionary[kBossOwnerUserModelNational] isKindOfClass:[NSNull class]]){
		self.national = dictionary[kBossOwnerUserModelNational];
	}	
	if(![dictionary[kBossOwnerUserModelNickname] isKindOfClass:[NSNull class]]){
		self.nickname = dictionary[kBossOwnerUserModelNickname];
	}
    
    if(![dictionary[kBossOwnerUserWalletModel] isKindOfClass:[NSNull class]]){
        self.WalletModel = [[BalanceMoneyModel alloc]initWithDictionary:dictionary[kBossOwnerUserWalletModel]] ;
    }
    if(![dictionary[kBossOwnerUserWechatModel] isKindOfClass:[NSNull class]]){
        self.WeChatModel = [[WeChatModel alloc]initWithDictionary:dictionary[kBossOwnerUserWechatModel]];
    }
    if(![dictionary[kBossOwnerconfigurl] isKindOfClass:[NSNull class]]){
        self.configModel = [[configModel alloc]initWithDictionary:dictionary[kBossOwnerconfigurl]];
    }
    if(![dictionary[kBossOwnerUserIDcardType] isKindOfClass:[NSNull class]]){
        self.idcardType = [dictionary[kBossOwnerUserIDcardType] integerValue];
    }
    if(![dictionary[kBossOwnerUserIDcardStartDate] isKindOfClass:[NSNull class]]){
        self.idcardStartDate = [dictionary[kBossOwnerUserIDcardStartDate] integerValue];
       }
    if(![dictionary[kBossOwnerUserIDcardEndDate] isKindOfClass:[NSNull class]]){
        self.idcardEndDate = [dictionary[kBossOwnerUserIDcardEndDate] integerValue];
       }
    if(![dictionary[kBossOwnerUserTemporaryIDcardEffectDays] isKindOfClass:[NSNull class]]){
        self.temporaryIdcardEffectDays = [dictionary[kBossOwnerUserTemporaryIDcardEffectDays] integerValue];
    }
    if(![dictionary[kBossOwnerUserHealthCardIsOk] isKindOfClass:[NSNull class]]){
        self.healthCardIsOK = [dictionary[kBossOwnerUserHealthCardIsOk] boolValue];
    }
    
    if(![dictionary[kBossOwnerUserHealthEffectDays] isKindOfClass:[NSNull class]]){
        self.healthEffectDays = [dictionary[kBossOwnerUserHealthEffectDays] integerValue];
    }
  
    if(![dictionary[kBossOwnerUserHealthCertificateKey] isKindOfClass:[NSNull class]]){
        self.healthCertificateKey = dictionary[kBossOwnerUserHealthCertificateKey];
    }
    if(![dictionary[kBossOwnerUserHealthCertificateBackKey] isKindOfClass:[NSNull class]]){
        self.healthCertificateBackKey = dictionary[kBossOwnerUserHealthCertificateBackKey];
    }
    
	return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
    if(self.healthcertificateend){
        dictionary[kBossOwnerUserhealthcertificateendModel] = @(self.healthcertificateend);
    }
    if(self.healthcertificatestart){
        dictionary[kBossOwnerUserhealthcertificatestart] = @(self.healthcertificatestart);
    }
    if(self.healthcertificateurl != nil){
        dictionary[kBossOwnerUserhealthcertificateurl] = self.healthcertificateurl;
    }
    if(self.healthcertificatebackurl != nil){
        dictionary[kBossOwnerUserhealthcertificatebackurl] = self.healthcertificatebackurl;
    }
    
    
	if(self.accessToken != nil){
		dictionary[kBossOwnerUserModelAccessToken] = self.accessToken;
	}
    
    if (self.refreshToken != nil){
        dictionary[kBossOwnerUserModelRefreshToken] = self.refreshToken;

    }
    if(self.phone != nil){
        dictionary[kBossOwnerUserModelphone] = self.phone;
    }
	if(self.accountId != nil){
		dictionary[kBossOwnerUserModelAccountId] = self.accountId;
	}
	if(self.bankBranch != nil){
		dictionary[kBossOwnerUserModelBankBranch] = self.bankBranch;
	}
	if(self.bankCardFrontUrl != nil){
		dictionary[kBossOwnerUserModelBankCardFrontUrl] = self.bankCardFrontUrl;
	}
	if(self.bankCardId != nil){
		dictionary[kBossOwnerUserModelBankCardId] = self.bankCardId;
	}
	if(self.bankLocation != nil){
		dictionary[kBossOwnerUserModelBankLocation] = self.bankLocation;
	}
	if(self.bankName != nil){
		dictionary[kBossOwnerUserModelBankName] = self.bankName;
	}
	dictionary[kBossOwnerUserModelBirthDate] = @(self.birthDate);
	if(self.cardholderName != nil){
		dictionary[kBossOwnerUserModelCardholderName] = self.cardholderName;
	}
	dictionary[kBossOwnerUserModelExpiredAt] = @(self.expiredAt);
	dictionary[kBossOwnerUserModelGenderId] = @(self.genderId);
    
	if(self.handBustUrl != nil){
		dictionary[kBossOwnerUserModelHandBustUrl] = self.handBustUrl;
	}
	if(self.headPortraitPhotoUrl != nil){
		dictionary[kBossOwnerUserModelHeadPortraitPhotoUrl] = self.headPortraitPhotoUrl;
	}
	if(self.identityCardBackUrl != nil){
		dictionary[kBossOwnerUserModelIdentityCardBackUrl] = self.identityCardBackUrl;
	}
	if(self.identityCardFrontUrl != nil){
		dictionary[kBossOwnerUserModelIdentityCardFrontUrl] = self.identityCardFrontUrl;
	}
	if(self.identityCardId != nil){
		dictionary[kBossOwnerUserModelIdentityCardId] = self.identityCardId;
	}
	if(self.name != nil){
		dictionary[kBossOwnerUserModelName] = self.name;
	}
	if(self.national != nil){
		dictionary[kBossOwnerUserModelNational] = self.national;
	}
	if(self.nickname != nil){
		dictionary[kBossOwnerUserModelNickname] = self.nickname;
	}
    if(self.WeChatModel != nil){
        dictionary[kBossOwnerUserWechatModel] = [self.WeChatModel toDictionary];
    }
    if(self.WalletModel != nil){
        dictionary[kBossOwnerUserWalletModel] = [self.WalletModel toDictionary];
    }
    dictionary[kBossOwnerUserIDcardType] = @(self.idcardType);
    dictionary[kBossOwnerUserIDcardStartDate] = @(self.idcardStartDate);
    dictionary[kBossOwnerUserIDcardEndDate] = @(self.idcardEndDate);
    dictionary[kBossOwnerUserTemporaryIDcardEffectDays] = @(self.temporaryIdcardEffectDays);
    dictionary[kBossOwnerUserHealthCardIsOk] = @(self.healthCardIsOK);
    dictionary[kBossOwnerUserHealthEffectDays] = @(self.healthEffectDays);
	dictionary[kBossOwnerhascancellationapplyKey] = @(self.hasCancellationApply);
    if(self.healthCertificateKey != nil){
        dictionary[kBossOwnerUserHealthCertificateKey] = self.healthCertificateKey;
    }
    if(self.healthCertificateBackKey != nil){
        dictionary[kBossOwnerUserHealthCertificateBackKey] = self.healthCertificateBackKey;
    }
	return dictionary;

}

/**
 * Implementation of NSCoding encoding method
 */
/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
- (void)encodeWithCoder:(NSCoder *)aCoder
{
	if(self.accessToken != nil){
		[aCoder encodeObject:self.accessToken forKey:kBossOwnerUserModelAccessToken];
	}
    if(self.refreshToken != nil){
        [aCoder encodeObject:self.refreshToken forKey:kBossOwnerUserModelRefreshToken];
    }
    if(self.phone != nil){
        [aCoder encodeObject:self.phone forKey:kBossOwnerUserModelphone];
    }
	if(self.accountId != nil){
		[aCoder encodeObject:self.accountId forKey:kBossOwnerUserModelAccountId];
	}
	if(self.bankBranch != nil){
		[aCoder encodeObject:self.bankBranch forKey:kBossOwnerUserModelBankBranch];
	}
	if(self.bankCardFrontUrl != nil){
		[aCoder encodeObject:self.bankCardFrontUrl forKey:kBossOwnerUserModelBankCardFrontUrl];
	}
	if(self.bankCardId != nil){
		[aCoder encodeObject:self.bankCardId forKey:kBossOwnerUserModelBankCardId];
	}
	if(self.bankLocation != nil){
		[aCoder encodeObject:self.bankLocation forKey:kBossOwnerUserModelBankLocation];
	}
	if(self.bankName != nil){
		[aCoder encodeObject:self.bankName forKey:kBossOwnerUserModelBankName];
	}
	[aCoder encodeObject:@(self.birthDate) forKey:kBossOwnerUserModelBirthDate];
    if(self.cardholderName != nil){
		[aCoder encodeObject:self.cardholderName forKey:kBossOwnerUserModelCardholderName];
	}
	[aCoder encodeObject:@(self.expiredAt) forKey:kBossOwnerUserModelExpiredAt];
    [aCoder encodeObject:@(self.genderId) forKey:kBossOwnerUserModelGenderId];
    if(self.handBustUrl != nil){
		[aCoder encodeObject:self.handBustUrl forKey:kBossOwnerUserModelHandBustUrl];
	}
	if(self.headPortraitPhotoUrl != nil){
		[aCoder encodeObject:self.headPortraitPhotoUrl forKey:kBossOwnerUserModelHeadPortraitPhotoUrl];
	}
	if(self.identityCardBackUrl != nil){
		[aCoder encodeObject:self.identityCardBackUrl forKey:kBossOwnerUserModelIdentityCardBackUrl];
	}
	if(self.identityCardFrontUrl != nil){
		[aCoder encodeObject:self.identityCardFrontUrl forKey:kBossOwnerUserModelIdentityCardFrontUrl];
	}
	if(self.identityCardId != nil){
		[aCoder encodeObject:self.identityCardId forKey:kBossOwnerUserModelIdentityCardId];
	}
	if(self.name != nil){
		[aCoder encodeObject:self.name forKey:kBossOwnerUserModelName];
	}
	if(self.national != nil){
		[aCoder encodeObject:self.national forKey:kBossOwnerUserModelNational];
	}
	if(self.nickname != nil){
		[aCoder encodeObject:self.nickname forKey:kBossOwnerUserModelNickname];
	}
    if(self.WalletModel != nil){
        [aCoder encodeObject:self.WalletModel forKey:kBossOwnerUserWalletModel];
    }
    if(self.WeChatModel != nil){
        [aCoder encodeObject:self.WeChatModel forKey:kBossOwnerUserWechatModel];
    }
    [aCoder encodeObject:@(self.idcardType) forKey:kBossOwnerUserIDcardType];
    [aCoder encodeObject:@(self.idcardStartDate) forKey:kBossOwnerUserIDcardStartDate];
    [aCoder encodeObject:@(self.idcardEndDate) forKey:kBossOwnerUserIDcardEndDate];
    [aCoder encodeObject:@(self.temporaryIdcardEffectDays) forKey:kBossOwnerUserTemporaryIDcardEffectDays];
    [aCoder encodeObject:@(self.healthCardIsOK) forKey:kBossOwnerUserHealthCardIsOk];
    [aCoder encodeObject:@(self.healthEffectDays) forKey:kBossOwnerUserHealthEffectDays];
	
	[aCoder encodeObject:@(self.hasCancellationApply) forKey:kBossOwnerhascancellationapplyKey];
    
    if(self.healthCertificateKey != nil){
        [aCoder encodeObject:self.healthCertificateKey forKey:kBossOwnerUserHealthCertificateKey];
    }
    if(self.healthCertificateBackKey != nil){
        [aCoder encodeObject:self.healthCertificateBackKey forKey:kBossOwnerUserHealthCertificateBackKey];
    }
}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.accessToken = [aDecoder decodeObjectForKey:kBossOwnerUserModelAccessToken];
    self.refreshToken = [aDecoder decodeObjectForKey:kBossOwnerUserModelRefreshToken];
    self.phone = [aDecoder decodeObjectForKey:kBossOwnerUserModelphone];
	self.accountId = [aDecoder decodeObjectForKey:kBossOwnerUserModelAccountId];
	self.bankBranch = [aDecoder decodeObjectForKey:kBossOwnerUserModelBankBranch];
	self.bankCardFrontUrl = [aDecoder decodeObjectForKey:kBossOwnerUserModelBankCardFrontUrl];
	self.bankCardId = [aDecoder decodeObjectForKey:kBossOwnerUserModelBankCardId];
	self.bankLocation = [aDecoder decodeObjectForKey:kBossOwnerUserModelBankLocation];
	self.bankName = [aDecoder decodeObjectForKey:kBossOwnerUserModelBankName];
	self.birthDate = [[aDecoder decodeObjectForKey:kBossOwnerUserModelBirthDate] integerValue];
	self.cardholderName = [aDecoder decodeObjectForKey:kBossOwnerUserModelCardholderName];
	self.expiredAt = [[aDecoder decodeObjectForKey:kBossOwnerUserModelExpiredAt] integerValue];
	self.genderId = [[aDecoder decodeObjectForKey:kBossOwnerUserModelGenderId] integerValue];
	self.handBustUrl = [aDecoder decodeObjectForKey:kBossOwnerUserModelHandBustUrl];
	self.headPortraitPhotoUrl = [aDecoder decodeObjectForKey:kBossOwnerUserModelHeadPortraitPhotoUrl];
	self.identityCardBackUrl = [aDecoder decodeObjectForKey:kBossOwnerUserModelIdentityCardBackUrl];
	self.identityCardFrontUrl = [aDecoder decodeObjectForKey:kBossOwnerUserModelIdentityCardFrontUrl];
	self.identityCardId = [aDecoder decodeObjectForKey:kBossOwnerUserModelIdentityCardId];
	self.name = [aDecoder decodeObjectForKey:kBossOwnerUserModelName];
	self.national = [aDecoder decodeObjectForKey:kBossOwnerUserModelNational];
	self.nickname = [aDecoder decodeObjectForKey:kBossOwnerUserModelNickname];
    self.WalletModel = [aDecoder decodeObjectForKey:kBossOwnerUserWalletModel];
    self.WeChatModel = [aDecoder decodeObjectForKey:kBossOwnerUserWechatModel];
    
    self.idcardType = [[aDecoder decodeObjectForKey:kBossOwnerUserIDcardType] integerValue];
    self.idcardStartDate = [[aDecoder decodeObjectForKey:kBossOwnerUserIDcardStartDate] integerValue];
    self.idcardEndDate = [[aDecoder decodeObjectForKey:kBossOwnerUserIDcardEndDate] integerValue];
    self.temporaryIdcardEffectDays = [[aDecoder decodeObjectForKey:kBossOwnerUserTemporaryIDcardEffectDays] integerValue];
    self.healthCardIsOK = [[aDecoder decodeObjectForKey:kBossOwnerUserHealthCardIsOk] boolValue];
	
	self.hasCancellationApply = [[aDecoder decodeObjectForKey:kBossOwnerhascancellationapplyKey] boolValue];
    self.healthEffectDays = [[aDecoder decodeObjectForKey:kBossOwnerUserHealthEffectDays] integerValue];
    self.healthCertificateKey = [aDecoder decodeObjectForKey:kBossOwnerUserHealthCertificateKey];
    self.healthCertificateBackKey = [aDecoder decodeObjectForKey:kBossOwnerUserHealthCertificateBackKey];
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	BossOwnerUserModel *copy = [BossOwnerUserModel new];
    copy.phone = [self.phone copy];
	copy.accessToken = [self.accessToken copy];
    copy.refreshToken = [self.refreshToken copy];
	copy.accountId = [self.accountId copy];
	copy.bankBranch = [self.bankBranch copy];
	copy.bankCardFrontUrl = [self.bankCardFrontUrl copy];
	copy.bankCardId = [self.bankCardId copy];
	copy.bankLocation = [self.bankLocation copy];
	copy.bankName = [self.bankName copy];
	copy.birthDate = self.birthDate;
	copy.cardholderName = [self.cardholderName copy];
	copy.expiredAt = self.expiredAt;
	copy.genderId = self.genderId;
	copy.handBustUrl = [self.handBustUrl copy];
	copy.headPortraitPhotoUrl = [self.headPortraitPhotoUrl copy];
	copy.identityCardBackUrl = [self.identityCardBackUrl copy];
	copy.identityCardFrontUrl = [self.identityCardFrontUrl copy];
	copy.identityCardId = [self.identityCardId copy];
	copy.name = [self.name copy];
	copy.national = [self.national copy];
	copy.nickname = [self.nickname copy];
    copy.WeChatModel = [self.WeChatModel copy];
    copy.WalletModel = [self.WalletModel copy];
    copy.idcardType = self.idcardType;
    copy.idcardStartDate = self.idcardStartDate;
    copy.idcardEndDate = self.idcardEndDate;
    copy.temporaryIdcardEffectDays = self.temporaryIdcardEffectDays;
    copy.healthCardIsOK = self.healthCardIsOK;
    copy.healthEffectDays = self.healthEffectDays;
    copy.healthCertificateKey = self.healthCertificateKey;
    copy.healthCertificateBackKey = self.healthCertificateBackKey;

	return copy;
}
@end
