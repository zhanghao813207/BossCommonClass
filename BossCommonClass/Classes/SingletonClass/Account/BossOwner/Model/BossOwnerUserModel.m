//
//	BossOwnerUserModel.m
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "BossOwnerUserModel.h"

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

NSString *const kBossOwnerUserWechatModel = @"wechat_account";
NSString *const kBossOwnerUserWalletModel = @"wallet_info";

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

@interface BossOwnerUserModel ()
@end
@implementation BossOwnerUserModel



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

//工作证件是否完善
- (BOOL)workCardIsDone
{
   if(self.healthcertificatebackurl == nil ||self.healthcertificateurl == nil || !self.healthcertificateend  || !self.healthcertificatestart)
   {
       return NO;
   }
    return YES;
}
-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
    
    if(![dictionary[kBossOwnerUserhealthcertificateendModel] isKindOfClass:[NSNull class]]){
        self.healthcertificateend = [dictionary[kBossOwnerUserhealthcertificateendModel] integerValue];
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

    if(![dictionary[kBossOwnerUserModelphone] isKindOfClass:[NSNull class]]){
        self.phone = dictionary[kBossOwnerUserModelphone];
    }

    
	if(![dictionary[kBossOwnerUserModelAccessToken] isKindOfClass:[NSNull class]]){
		self.accessToken = dictionary[kBossOwnerUserModelAccessToken];
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
	[aCoder encodeObject:@(self.birthDate) forKey:kBossOwnerUserModelBirthDate];	if(self.cardholderName != nil){
		[aCoder encodeObject:self.cardholderName forKey:kBossOwnerUserModelCardholderName];
	}
	[aCoder encodeObject:@(self.expiredAt) forKey:kBossOwnerUserModelExpiredAt];	[aCoder encodeObject:@(self.genderId) forKey:kBossOwnerUserModelGenderId];	if(self.handBustUrl != nil){
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

}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.accessToken = [aDecoder decodeObjectForKey:kBossOwnerUserModelAccessToken];
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
	return copy;
}
@end
