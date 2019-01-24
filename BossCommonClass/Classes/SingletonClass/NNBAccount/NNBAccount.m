//
//  NNBAccount.m
//  NNBarKnight
//
//  Created by 贾远潮 on 2017/9/27.
//  Copyright © 2017年 贾远潮. All rights reserved.
//

#import "NNBAccount.h"
#import "BossWhiteNavigationController.h"
#import "LoginVC.h"
#import "NNBRequestManager.h"
#import "NSDate+Helper.h"

@interface NNBAccount()

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

@implementation NNBAccount

static NNBAccount *defaultAccount = nil;

+ (__kindof NNBAccount *)defaultAccount
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        defaultAccount = [[NNBAccount alloc] init];
    });
    return defaultAccount;
}

- (void)setValue:(id)value forKey:(NSString *)key
{
    if (!value || value == [NSNull null]) {
        return;
    }
    
    if ([key isEqualToString:@"expired_at"]) {
        self.expired_at = [NSString stringWithFormat:@"%@", value];
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

/**
 模型转字典
 
 @return 字典
 */
- (NSDictionary *)decodeToDic
{
    NSDictionary *localAccountInfoDic = @{
                                          @"access_token":self.access_token ? : @"",
                                          @"refresh_token":self.refresh_token ? : @"",
                                          @"expired_at":self.expired_at ? : @"",
                                          
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
    return localAccountInfoDic;
}


/**
 判断用户是否登录
 
 @param success 成功登录
 @param viewController 弹出登录的控制器（一般为当前控制器）
 */
+ (void)userIsLoginSuccess:(void (^)(BOOL isSuccess, BOOL isFirstLogin))success withController:(UIViewController *)viewController
{
    // 当前用户已经登录
    if (kCurrentAccount._id && ![kCurrentAccount._id isEqualToString:@""]) {
        if (success) {
            success(YES,NO);
        }
        return;
    }
    // 用户需要登录
    if ([viewController isKindOfClass:[UIViewController class]]) {
        LoginVC *loginVC = [[LoginVC alloc] init];
        [loginVC setLoginSuccessBlock:^(BOOL isLogin) {
            if (!success) {
                return;
            }
            defaultAccount.isFirstLogin = NO;
            success(isLogin,YES);
        }];
        BossWhiteNavigationController *loginNC = [[BossWhiteNavigationController alloc] initWithRootViewController:loginVC];
        [viewController.navigationController presentViewController:loginNC animated:!defaultAccount.isFirstLogin completion:nil];
    }
}

/**
 判断用户是否信息完善
 
 @param perfectBlock 完善
 @param toPerfectBlock 去完善
 @param viewController 弹出去完善的按钮
 */
+ (void)userInfoIsPerfect:(void(^)(BOOL isPerfect))perfectBlock toPerfect:(void(^)(void))toPerfectBlock withController:(UIViewController *)viewController
{
    // 当前用户信息未完善
    if (!kCurrentAccount.userInfoIsPerfect) {
        // 用户需要完善
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"请先完善个人信息" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        UIAlertAction *setUpAction = [UIAlertAction actionWithTitle:@"立即完善" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (!toPerfectBlock) {
                return;
            }
            toPerfectBlock();
        }];
        [alert addAction:cancelAction];
        [alert addAction:setUpAction];
        [viewController presentViewController:alert animated:YES completion:nil];
        return;
    }
    
    // 信息已完善
    if (perfectBlock) {
        perfectBlock(YES);
    }
}

/**
 判断是否需电子签约
 
 @param onterContractBlock      其他签约回调
 @param electronicContractBlock 电子签约回调
 @param viewController          弹出去完善的按钮
 */
+ (void)checkElectronicContract:(void(^)(void))onterContractBlock electronicContractBlock:(void(^)(void))electronicContractBlock withController:(UIViewController *)viewController
{
    // 电子签约
    if(kCurrentAccount.checkElectronicContract){
        // 弹出签约对话框
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"您有合同未签约，请立即签约" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        UIAlertAction *setUpAction = [UIAlertAction actionWithTitle:@"立即签约" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if(electronicContractBlock){
                electronicContractBlock();
            }
        }];
        [alert addAction:cancelAction];
        [alert addAction:setUpAction];
        [viewController presentViewController:alert animated:YES completion:nil];
        return;
    }

    // 纸质签约
    if (onterContractBlock) {
        onterContractBlock();
    }
    return;
    
}

/**
 当前用户是否登录，登录信息是否过期
 
 @param loginBlock 是否登录
 @param expeiredBlock 登录是否过期（只有登录才会回调是否过期）
 */
+ (void)userIsLogin:(void(^)(BOOL isLogin))loginBlock Expired:(void (^)(BOOL isExpired))expeiredBlock
{
    NSDictionary *dic = [[NSUserDefaults standardUserDefaults] objectForKey:AccountInfoKey];
    DLog(@"userIsLogin account date:\n%@",dic);
    if (dic) {
        // 未过期的情况 用户上次登录过 且 不需要重新登录
        if (![[NNBRequestManager shareNNBRequestManager] accountTockenIsExpiredWithExpired_at:dic[@"expired_at"]]) {
            [kCurrentAccount setValuesForKeysWithDictionary:dic];
            kCurrentAccount.isNeedUpdate = YES;
            kCurrentAccount.isFirstLogin = YES;
            if (!expeiredBlock) {
                return;
            }
            expeiredBlock(NO);
        } else {
            // 过期的情况（目前不做处理，相当于没有登录过，会去重新登录(同安卓一样)）后期可以考虑刷新tocken
            kCurrentAccount.isFirstLogin = YES;
            if (!expeiredBlock) {
                return;
            }
            expeiredBlock(YES);
        }
    } else {
        // 没有登录过
        kCurrentAccount.isFirstLogin = YES;
        if (!loginBlock) {
            return;
        }
    }
}

/**
 用户退出登录
 
 @param confirmBlock 点击确认后的回调
 @param viewController 弹出的登录
 */
+ (void)userIsLoginOutConfirm:(void(^)(BOOL isLoginOut))confirmBlock withController:(UIViewController *)viewController
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"确认退出登录？" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *photoAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self clearAccountInfo];
        if (!confirmBlock) {
            return;
        }
        confirmBlock(YES);
    }];
    
    [alertController addAction:cancelAction];
    [alertController addAction:photoAction];
    [viewController.navigationController presentViewController:alertController animated:YES completion:nil];
}

+ (void)clearAccountInfo
{
    defaultAccount = [[NNBAccount alloc] init];
    [kUserDefault removeObjectForKey:AccountInfoKey];
    [kUserDefault synchronize];
    [[NNBRequestManager shareNNBRequestManager] cleanToken];
}

- (NSArray *)encodeArrayToArray:(NSArray *)array
{
    NSMutableArray *arrayM = [NSMutableArray array];
    for (id model in array) {
        if ([model respondsToSelector:@selector(decodeToDic)]) {
            NSDictionary *dic = [model decodeToDic];
            [arrayM addObject:dic];
        }
    }
    return [arrayM copy];
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
    // 已签约-正常 & 已签约-待换签 & 已签约-待续签
    return self.state == StaffStateSigned || self.state == StaffStateWaitingRenewal || self.state == StaffStateRenewaled;
}

- (BOOL)checkElectronicContract
{
    return self.sign_type == StaffSignTypeElectronic;
}

@end
