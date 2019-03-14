//
//  BossStaffRequest.m
//  Pods-BossKnight
//
//  Created by 贾远潮 on 2018/5/23.
//

#import "BossStaffRequest.h"
#import "BossBasicDefine.h"
#import "NNBBasicRequest.h"
#import "NNBRequestManager.h"
#import "SaasModel.h"

@implementation BossStaffRequest

/**
 获取员工详情

 @param successBlock 成功返回员工的信息
 @param failBlock 响应失败
 */
+ (void)staffRequestGetStaffInfoWithId:(void(^)(void))successBlock fail:(void(^)(id error))failBlock
{
    NSDictionary *paramDic = @{
                               @"staff_id":kCurrentBossKnightAccount.tokenModel.account_id,
                               };
    [NNBBasicRequest postJsonWithUrl:kUrl parameters:paramDic CMD:@"staff.staff.get" success:^(id responseObject) {
        BossKnightAccountModel *accountModel = [[BossKnightAccountModel alloc] init];
        [accountModel setValuesForKeysWithDictionary:responseObject];
        
        BossKnightAccount *knightAccount  = [[BossKnightAccount alloc] init];
        knightAccount.tokenModel = kCurrentBossKnightAccount.tokenModel;
        knightAccount.accountModel = accountModel;
        
        kCurrentBossKnightAccount = knightAccount;
        kCurrentBossKnightAccount.isNeedUpdate = NO;
        if (successBlock) {
            successBlock();
        }
    } fail:^(id error) {
        if (!failBlock) {
            return;
        }
        failBlock(error);
    }];
}

/**
 更新员工信息
 
 @param staffInfo 员工信息
 @param successBlock 是否更新成功
 @param failBlock 服务器响应失败
 */
+ (void)staffRequestUpdateStaffInfoWithStaffInfo:(BossKnightAccountModel *)staffInfo success:(void(^)(BOOL updateSuccess))successBlock fail:(void(^)(id error))failBlock
{
    if (!staffInfo) {
        DLog(@"员工信息为空");
        return;
    }
    
    NSDictionary *paramDic = @{
                               @"staff_id":kCurrentBossKnightAccount.tokenModel.account_id
                               }.mutableCopy;
    
    if (staffInfo.befor_phone) {
        [paramDic setValue:staffInfo.befor_phone forKey:@"befor_phone"];
    }
    
    if (staffInfo.befor_name) {
        [paramDic setValue:staffInfo.befor_name forKey:@"befor_name"];
    }

    if (staffInfo.befor_identity_card_id) {
        [paramDic setValue:staffInfo.befor_identity_card_id forKey:@"befor_identity_card_id"];
    }
    
    if (staffInfo.phone) {
        [paramDic setValue:staffInfo.phone forKey:@"phone"];
    }
    
    if (staffInfo.verify_code) {
        [paramDic setValue:staffInfo.verify_code forKey:@"verify_code"];
    }

    if (staffInfo.bank_location) {
        [paramDic setValue:staffInfo.bank_location forKey:@"bank_location"];
    }
    
    if (staffInfo.identity_card_id) {
        [paramDic setValue:staffInfo.identity_card_id forKey:@"identity_card_id"];
    }
    if (staffInfo.contract_photo_list) {
        [paramDic setValue:staffInfo.contract_photo_list forKey:@"contract_photo_list"];
    }
    if (staffInfo.state) {
        [paramDic setValue:@(staffInfo.state) forKey:@"state"];
    }

    if (staffInfo.health_certificate) {
        [paramDic setValue:staffInfo.health_certificate forKey:@"health_certificate"];
    }
    if (staffInfo.health_certificate_back) {
        [paramDic setValue:staffInfo.health_certificate_back forKey:@"health_certificate_back"];
    }
    
    if (staffInfo.bank_info_type) {
        [paramDic setValue:@(staffInfo.bank_info_type) forKey:@"bank_info_type"];
    }
    
    if (staffInfo.identity_card_front) {
        [paramDic setValue:staffInfo.identity_card_front forKey:@"identity_card_front"];
    }
    if (staffInfo.identity_card_back) {
        [paramDic setValue:staffInfo.identity_card_back forKey:@"identity_card_back"];
    }
    if (staffInfo.cardholder_name) {
        [paramDic setValue:staffInfo.cardholder_name forKey:@"cardholder_name"];
    }
    
    if (staffInfo.bank_card_id) {
        [paramDic setValue:staffInfo.bank_card_id forKey:@"bank_card_id"];
    }
    if (staffInfo.bank_branch) {
        [paramDic setValue:staffInfo.bank_branch forKey:@"bank_branch"];
    }
    if (staffInfo.bank_branch_name) {
        [paramDic setValue:staffInfo.bank_branch_name forKey:@"bank_branch_name"];
    }
    if (staffInfo.bank_card_front) {
        [paramDic setValue:staffInfo.bank_card_front forKey:@"bank_card_front"];
    }
    if (staffInfo.national) {
        [paramDic setValue:staffInfo.national forKey:@"national"];
    }
    if (staffInfo.gender_id != GenderIDUnknown) {
        [paramDic setValue:@(staffInfo.gender_id) forKey:@"gender_id"];
    }
    if (staffInfo.education) {
        [paramDic setValue:staffInfo.education forKey:@"education"];
    }
    if (staffInfo.emergency_contact) {
        [paramDic setValue:staffInfo.emergency_contact forKey:@"emergency_contact"];
    }
    if (staffInfo.emergency_contact_phone) {
        [paramDic setValue:staffInfo.emergency_contact_phone forKey:@"emergency_contact_phone"];
    }
    if (staffInfo.bust) {
        [paramDic setValue:staffInfo.bust forKey:@"bust"];
    }
        
    [NNBBasicRequest postJsonWithUrl:kUrl parameters:paramDic CMD:@"staff.staff.app_update" success:^(id responseObject) {
        
        kCurrentBossKnightAccount.isNeedUpdate = YES;
        
        if (!successBlock) {
            return;
        }
        BOOL ok = [responseObject[@"ok"] boolValue];
        successBlock(ok);
    } fail:^(id error) {
        NSLog(@"error: %@", error);
        if (!failBlock) {
            return;
        }
        failBlock(error);
    }];
}

/**
 获取骑士标签列表
 
 @param successBlock 成功
 @param failBlock 服务器响应失败
 */
+ (void)staffRequestFindStaffTagSuccess:(void(^)(NSArray <StaffTagModel *>*staffTagList))successBlock fail:(void(^)(id error))failBlock
{
    NSDictionary *paramDic = @{
                               @"_meta":@{
                                       @"page":@(1),
                                       @"limit":@(500),
                                       },
                               };
    [NNBBasicRequest postJsonWithUrl:kUrl parameters:paramDic CMD:@"staff.staff_tag.find" success:^(id responseObject) {
        if (!successBlock) {
            return;
        }
        NSMutableArray *array = [NSMutableArray array];
        for (NSDictionary *tagDic in responseObject[@"data"]) {
            StaffTagModel *model = [[StaffTagModel alloc] init];
            [model setValuesForKeysWithDictionary:tagDic];
            [array addObject:model];
        }
        successBlock([array copy]);
    } fail:^(id error) {
        DLog(@"payrollerror = %@",error);
    }];
}
@end
