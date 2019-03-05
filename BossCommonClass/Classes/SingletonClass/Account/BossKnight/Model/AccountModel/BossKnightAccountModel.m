//
//  BossKnightAccountModel.m
//  AFNetworking
//
//  Created by 张浩 on 2019/2/20.
//

#import "BossKnightAccountModel.h"
#import "JYCSimpleToolClass.h"

@interface BossKnightAccountModel()

@property (nonatomic, strong) NSString *postionIDString;

@property (nonatomic, strong) NSString *staffStateString;

@property (nonatomic, strong) NSString *genderString;

@property (nonatomic, strong) NSString *individualTypeStr;

@property (nonatomic, strong) NSString *recruitmentChannelStr;

@property (nonatomic, strong) NSString *supplier_name;

@property (nonatomic, strong) NSString *platform_name;

@property (nonatomic, strong) NSString *city_name;

@property (nonatomic, strong) NSString *biz_district_name;

@property (nonatomic, strong) NSString *contract_belong_name;

@property (nonatomic, strong) NSString *electronicContractStateStr;

@end

@implementation BossKnightAccountModel

- (void)setValue:(id)value forKey:(NSString *)key
{
    if (!value || value == [NSNull null]) {
        return;
    }
    
    if ([key isEqualToString:@"signed_date"]) {
        self.signed_date = [NSString stringWithFormat:@"%@", value];
        return;
    }
    
    if ([key isEqualToString:@"contract_belong_info"]) {
        ContractBelongModel *model = [[ContractBelongModel alloc] init];
        [model setValuesForKeysWithDictionary:value];
        self.contract_belong_info = model;
        return;
    }
    
    [super setValue:value forKey:key];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

- (NSString *)staffStateString
{
    switch (self.state) {
        case StaffStatePendingSign:
            _staffStateString = @"待签约";
            break;
        case StaffStateSigned:
            _staffStateString = @"已签约-正常";
            break;
        case StaffStateWaitingRenewal:
            _staffStateString = @"已签约-待换签";
            break;
        case StaffStateRenewaled:
            _staffStateString = @"已签约-待续签";
            break;
        case StaffStateTerminated:
            _staffStateString = @"已解约";
            break;
    }
    return _staffStateString;
}

- (NSString *)genderString
{
    switch (self.gender_id) {
        case GenderIDUnknown:
            _genderString = @"";
            break;
        case GenderIDMan:
            _genderString = @"男";
            break;
        case GenderIDWoman:
            _genderString = @"女";
            break;
        default:
            _genderString = @"";
            break;
    }
    return _genderString;
}

- (NSString *)individualTypeStr
{
    switch (self.individual_type) {
        case StaffIndividualTypeA:
            _individualTypeStr = @"甲类";
            break;
        case StaffIndividualTypeB:
            _individualTypeStr = @"乙类";
            break;
    }
    return _individualTypeStr;
}

- (NSString *)recruitmentChannelStr
{
    switch (self.recruitment_channel_id) {
        case RecruitmentChannelIdThird:
            _recruitmentChannelStr = @"第三方";
            break;
        case RecruitmentChannelIdPersonal:
            _recruitmentChannelStr = @"个人推荐";
            break;
        case RecruitmentChannelIdOther:
            _recruitmentChannelStr = @"其他";
            break;
        case RecruitmentChannelIdTransfer:
            _recruitmentChannelStr = @"转签";
            break;
        case RecruitmentChannelIdInternal:
            _recruitmentChannelStr = @"内部推荐";
            break;
    }
    return _recruitmentChannelStr;
}

- (NSString *)supplier_name
{
    BOOL checkEmpty = self.supplier_names && [self.supplier_names count] >= 1;
    return checkEmpty ? self.supplier_names[0] : @"";
}

- (NSString *)platform_name
{
    BOOL checkEmpty = self.platform_names && [self.platform_names count] >= 1;
    return checkEmpty ? self.platform_names[0] : @"";
}

- (NSString *)city_name
{
    BOOL checkEmpty = self.city_names && [self.city_names count] >= 1;
    return checkEmpty ? self.city_names[0] : @"";
}

- (NSString *)biz_district_name
{
    BOOL checkEmpty = self.biz_district_names && [self.biz_district_names count] >= 1;
    return checkEmpty ? self.biz_district_names[0] : @"";
}

- (NSString *)contract_belong_name
{
    BOOL checkNil = self.contract_belong_info && self.contract_belong_info.name;
    return checkNil ? self.contract_belong_info.name : @"";
}

- (NSString *)electronicContractStateStr
{
    _electronicContractStateStr = self.checkSigned ? @"已完成" : @"未完成";
    return _electronicContractStateStr;
}

#pragma mark -- help property

- (BOOL)userInfoIsPerfect
{
    // 员工信息 & 工作信息 & 身份信息 & 银行卡
    if (!self.staffInfoIsPerfect || !self.jobInfoIsPerfect || !self.identityInfoIsPerfect || !self.bankCardInfoIsPerfect) {
        return NO;
    }
    return YES;
}

- (BOOL)staffInfoIsPerfect
{
    // 性别 & 学历 & 民族 & 紧急联系人 & 紧急联系人电话
    if (self.gender_id == GenderIDUnknown || [JYCSimpleToolClass stringIsEmpty:self.education] || [JYCSimpleToolClass stringIsEmpty:self.national] || [JYCSimpleToolClass stringIsEmpty:self.emergency_contact] || [JYCSimpleToolClass stringIsEmpty:self.emergency_contact_phone]) {
        return NO;
    }
    return YES;
}

- (BOOL)jobInfoIsPerfect
{
    // 近期半身照 & 健康证
    return self.bustInfoIsPerfect && self.healthCertificateInfoIsPerfect;
}

- (BOOL)identityInfoIsPerfect
{
    // 身份证号 & 身份证正面照(照片) & 身份证背面照(照片)
    if ([JYCSimpleToolClass stringIsEmpty:self.identity_card_id] || [JYCSimpleToolClass stringIsEmpty:self.identity_card_front] || [JYCSimpleToolClass stringIsEmpty:self.identity_card_back]) {
        return NO;
    }
    return YES;
}

- (BOOL)bankCardInfoIsPerfect
{
    // 银行卡号 & 开户行支行 & 银行卡正面照(照片) & 银行卡省市
    if ([JYCSimpleToolClass stringIsEmpty:self.bank_card_id] || [JYCSimpleToolClass stringIsEmpty:self.bank_branch] || [JYCSimpleToolClass stringIsEmpty:self.bank_card_front] || self.bank_location.count == 0) {
        return NO;
    }
    return YES;
}

- (BOOL)bustInfoIsPerfect
{
    if ([JYCSimpleToolClass stringIsEmpty:self.bust]) {
        return NO;
    }
    return YES;
}

- (BOOL)healthCertificateInfoIsPerfect
{
    // 健康证(正面照片) & 健康证(背面照片)
    if ([JYCSimpleToolClass stringIsEmpty:self.health_certificate] || [JYCSimpleToolClass stringIsEmpty:self.health_certificate_back]) {
        return NO;
    }
    return YES;
}

- (BOOL)checkContractUploaded
{
    BOOL checkElectronicUploaded = ![JYCSimpleToolClass stringIsEmpty:self.contract_asset_url];
    BOOL checkPaperUploaded = self.contract_photo_list_url && self.contract_photo_list_url.count > 0;
    return checkElectronicUploaded || checkPaperUploaded;
}

- (BOOL)checkSigned
{
    // 已签约-正常
    // return self.state == StaffStateSigned || self.state == StaffStateWaitingRenewal || self.state == StaffStateRenewaled;
    return self.state == StaffStateSigned;
}

- (BOOL)checkElectronicContract
{
    return self.sign_type == StaffSignTypeElectronic;
}

/**
 模型转字典
 
 @return 字典
 */
- (NSDictionary *)decodeToDic
{
    NSDictionary *dic = @{
                          @"_id":self._id ? : @"",
                          @"name":self.name ? : @"",
                          @"phone":self.phone ? : @"",
                          @"gender_id":@(self.gender_id),
                          @"national":self.national ? : @"",
                          @"emergency_contact":self.emergency_contact ? : @"",
                          @"emergency_contact_phone":self.emergency_contact_phone ? : @"",
                          @"education":self.education ? : @"",
                          @"state":@(self.state),
                          @"often_address":self.often_address ? : @"",
                          @"entry_date":self.entry_date ? : @"",
                          @"signed_date":self.signed_date ? : @"",
                          @"created_at":self.created_at ? : @"",
                          @"updated_at":self.updated_at ? : @"",
                          @"referrer_company_id":self.referrer_company_id ? : @"",
                          @"sign_type":@(self.sign_type),
                          @"position_type":@(self.position_type),
                          @"individual_type":@(self.individual_type),
                          @"sign_cycle":@(self.sign_cycle),
                          @"signed_date_id":self.signed_date_id ? : @"",
                          @"contract_asset_id":self.contract_asset_id ? : @"",
                          @"contract_asset_url":self.contract_asset_url ? : @"",
                          @"recruitment_channel_id":@(self.recruitment_channel_id),
                          @"bust":self.bust ? : @"",
                          @"bust_url":self.bust_url ? : @"",
                          @"identity_card_id":self.identity_card_id ? : @"",
                          @"identity_card_front" : self.identity_card_front ? : @"",
                          @"identity_card_front_url" : self.identity_card_front_url ? : @"",
                          @"identity_card_back":self.identity_card_back ? : @"",
                          @"identity_card_back_url":self.identity_card_back_url ? : @"",
                          @"health_certificate":self.health_certificate ? : @"",
                          @"health_certificate_url":self.health_certificate_url ? : @"",
                          @"health_certificate_back":self.health_certificate_back ? : @"",
                          @"health_certificate_back_url":self.health_certificate_back_url ? : @"",
                          @"platform_names":self.platform_names ? : @[],
                          @"biz_district_names":self.biz_district_names ? : @[],
                          @"supplier_names":self.supplier_names ? : @[],
                          @"city_names":self.city_names ? : @[],
                          @"associated_identity_card_id":self.associated_identity_card_id ? : @"",
                          @"custom_id":self.custom_id ? : @"",
                          @"associated_knight_id_list":self.associated_knight_id_list ? : @[],
                          @"associated_knight_id":self.associated_knight_id ? : @"",
                          @"contract_belong_id":self.contract_belong_id ? : @"",
                          @"contract_belong_info":self.contract_belong_info ? [self.contract_belong_info decodeToDic] : @{},
                          @"contract_photo_list":self.contract_photo_list ? : @[],
                          @"contract_photo_list_url":self.contract_photo_list_url ? : @[],
                          @"bank_card_id":self.bank_card_id ? : @"",
                          @"cardholder_name":self.cardholder_name ? : @"",
                          @"bank_location":self.bank_location ? : @[],
                          @"bank_branch":self.bank_branch ? : @"",
                          @"bank_card_front":self.bank_card_front ? : @"",
                          @"bank_card_front_url":self.bank_card_front_url ? : @"",
                          @"operator_id":self.operator_id ? : @""
                          };
    return dic;
}

@end
