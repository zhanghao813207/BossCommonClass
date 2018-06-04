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

@interface NNBAccount()

@property (nonatomic, strong) NSString *postionIDString;

@property (nonatomic, strong) NSString *staffStateString;

@property (nonatomic, strong) NSString *genderString;


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
        self.expired_at = [NSString stringWithFormat:@"%@",value];
        return;
    }
    
    if ([key isEqualToString:@"city_list"]) {
        NSMutableArray *array = [NSMutableArray array];
        for (NSDictionary *dic in value) {
            CityModel *model = [[CityModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [array addObject:model];
        }
        self.city_list = [array copy];
        return;
    }
    
    if ([key isEqualToString:@"platform_list"]) {
        NSMutableArray *array = [NSMutableArray array];
        for (NSDictionary *dic in value) {
            PlatformModel *model = [[PlatformModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [array addObject:model];
        }
        self.platform_list = [array copy];
        return;
    }

    if ([key isEqualToString:@"departure_log"]) {
        NSMutableArray *array = [NSMutableArray array];
        for (NSDictionary *dic in value) {
            DepartureLogModel *model = [[DepartureLogModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [array addObject:model];
        }
        self.departure_log = [array copy];
        return;
    }

    if ([key isEqualToString:@"biz_district_list"]) {
        NSMutableArray *array = [NSMutableArray array];
        for (NSDictionary *dic in value) {
            BizDistrictModel *model = [[BizDistrictModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [array addObject:model];
        }
        self.biz_district_list = [array copy];
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
                                          @"position_id":@(self.position_id),
                                          @"job_category_id":@(self.job_category_id),
                                          @"pay_salary_cycle":@(self.pay_salary_cycle),
                                          @"recruitment_channel_id":@(self.recruitment_channel_id),
                                          @"state":@(self.state),
                                          @"gender_id":@(self.gender_id),

                                          @"bank_card_front_key":self.bank_card_front_key ? : @"",
                                          @"bust_key":self.bust_key ? : @"",
                                          @"departure_reason":self.departure_reason ? : @"",
                                          @"departure_date":self.departure_date ? : @"",
                                          @"national":self.national ? : @"",
                                          @"updated_at":self.updated_at ? : @"",
                                          @"bank_branch":self.bank_branch ? : @"",
                                          @"health_certificate_key":self.health_certificate_key ? : @"",
                                          @"education":self.education ? : @"",
                                          @"health_certificate":self.health_certificate ? : @"",
                                          @"platform_name":self.platform_name ? : @"",
                                          @"biz_district_name":self.biz_district_name ? : @"",
                                          @"staff_id":self.staff_id ? : @"",
                                          @"emergency_contact":self.emergency_contact ? : @"",
                                          @"contract_photo_key_list":self.contract_photo_key_list ? : @"",
                                          @"bank_card_id":self.bank_card_id ? : @"",
                                          @"bust":self.bust ? : @"",
                                          @"entry_date":self.entry_date ? : @"",
                                          @"emergency_contact_phone":self.emergency_contact_phone ? : @"",
                                          @"health_certificate_back":self.health_certificate_back ? : @"",
                                          @"bank_card_front":self.bank_card_front ? : @"",
                                          @"recruitment_channel":self.recruitment_channel ? : @"",
                                          @"identity_card_back_key":self.identity_card_back_key ? : @"",
                                          @"operator_id":self.operator_id ? : @"",
                                          @"contract_belong_name":self.contract_belong_name ? : @"",
                                          @"referrer_name":self.referrer_name ? : @"",
                                          @"departure_approver_name":self.departure_approver_name ? : @"",
                                          @"knight_type_id":self.knight_type_id ? : @"",
                                          @"identity_card_back":self.identity_card_back ? : @"",
                                          @"supplier_id":self.supplier_id ? : @"",
                                          @"supplier_name":self.supplier_name ? : @"",
                                          @"city_name":self.city_name ? : @"",
                                          @"associated_knight_id":self.associated_knight_id ? : @"",
                                          @"departure_approver_account_id":self.departure_approver_account_id ? : @"",
                                          @"knight_type_name":self.knight_type_name ? : @"",
                                          @"contract_belong_id":self.contract_belong_id ? : @"",
                                          @"name":self.name ? : @"",
                                          @"phone":self.phone ? : @"",
                                          @"identity_card_front" : self.identity_card_front ? : @"",
                                          @"identity_card_front_key":self.identity_card_front_key ? : @"",
                                          @"created_at":self.created_at ? : @"",
                                          @"identity_card_id":self.identity_card_id ? : @"",
                                          @"associated_identity_card_id":self.associated_identity_card_id ? : @"",
                                          @"operator_name":self.operator_name ? : @"",
                                          @"cardholder_name":self.cardholder_name ? : @"",
                                          @"_id":self._id ? : @"",
                                          @"cardholder_name":self.cardholder_name ? : @"",
                                          @"job_transfer_remark":self.job_transfer_remark ? : @"",
                                          @"access_token":self.access_token ? : @"",
                                          @"refresh_token":self.refresh_token ? : @"",
                                          @"expired_at":self.expired_at ? : @"",

                                          @"associated_knight_id_list":self.associated_knight_id_list ? : @[],
                                          @"job_category_log":self.job_category_log ? : @[],
                                          @"contract_photo_list":self.contract_photo_list ? : @[],
                                          @"district_description":self.district_description ? : @[],
                                          @"bank_location":self.bank_location ? : @[],

                                          @"platform_list":self.platform_list ? [self encodeArrayToArray:self.platform_list] : @[],
                                          @"city_list":self.city_list ? [self encodeArrayToArray:self.city_list] : @[],
                                          @"departure_log":self.departure_log ? [self encodeArrayToArray:self.departure_log] : @[],
                                          @"biz_district_list":self.biz_district_list ? [self encodeArrayToArray:self.biz_district_list] : @[],
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
    if (kCurrentAccount.staff_id && ![kCurrentAccount.staff_id isEqualToString:@""]) {
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
    // 当前用户信息已经完善
    if (kCurrentAccount.userInfoIsPerfect) {
        if (perfectBlock) {
            perfectBlock(YES);
        }
        return;
    }
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

- (NSString *)postionIDString
{
    switch (self.position_id) {
        case PositionIDDirector:
            _postionIDString =  @"总监";
            break;
        case PositionIDCityManger:
            _postionIDString =  @"城市经理";
            break;
        case PositionIDCityAssistant:
            _postionIDString =  @"城市助理";
            break;
        case PositionIDDispatcher:
            _postionIDString =  @"调度";
            break;
        case PositionIDStationAgent:
            _postionIDString =  @"站长";
            break;
        case PositionIDKnightCommander:
            _postionIDString =  @"骑士长";
            break;
        case PositionIDKnight:
            _postionIDString =  @"骑士";
            break;
        default:
            _postionIDString =  @"骑士";
            break;
    }
    return _postionIDString;
}
- (NSString *)staffStateString
{
    switch (self.state) {
        case StaffStateOnTheJob:
            _staffStateString = @"在职";
            break;
        case StaffStateLeaveToReview:
            _staffStateString = @"离职待审核";
            break;
        case StaffStateLeave:
            _staffStateString = @"离职";
            break;
        default:
            _staffStateString = @"在职";
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

#pragma mark -- help property

- (BOOL)userInfoIsPerfect
{
    if (!self.staffInfoIsPerfect || !self.jobInfoIsPerfect || !self.identityInfoIsPerfect || !self.bankCardInfoIsPerfect) {
        return NO;
    }
    return YES;
}

- (BOOL)staffInfoIsPerfect
{
    if (self.gender_id == GenderIDUnknown || [JYCSimpleToolClass stringIsEmpty:self.education] || [JYCSimpleToolClass stringIsEmpty:self.national] || [JYCSimpleToolClass stringIsEmpty:self.emergency_contact] || [JYCSimpleToolClass stringIsEmpty:self.emergency_contact_phone]) {
        return NO;
    }
    return YES;
}

- (BOOL)jobInfoIsPerfect
{
    if (!self.bustInfoIsPerfect || !self.healthCertificateInfoIsPerfect) {
        return NO;
    }
    return YES;
}

- (BOOL)identityInfoIsPerfect
{
    if ([JYCSimpleToolClass stringIsEmpty:self.identity_card_id] || [JYCSimpleToolClass stringIsEmpty:self.identity_card_front] || [JYCSimpleToolClass stringIsEmpty:self.identity_card_back]) {
        return NO;
    }
    return YES;
}

- (BOOL)bankCardInfoIsPerfect
{
    if ([JYCSimpleToolClass stringIsEmpty:self.bank_card_id] || [JYCSimpleToolClass stringIsEmpty:self.bank_branch] || [JYCSimpleToolClass stringIsEmpty:self.bank_card_front] || self.bank_location.count == 0) {
        return NO;
    }
    return YES;
}

- (BOOL)contractPhotosInfoIsPerfect
{
    if (self.contract_photo_list.count == 0) {
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
    if ([JYCSimpleToolClass stringIsEmpty:self.health_certificate] || [JYCSimpleToolClass stringIsEmpty:self.health_certificate_back]) {
        return NO;
    }
    return YES;
}


@end
