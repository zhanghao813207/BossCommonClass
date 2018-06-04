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

@implementation BossStaffRequest

/**
 获取员工详情
 
 @param staffId 员工ID
 @param successBlock 成功返回员工的信息
 @param failBlock 响应失败
 */
+ (void)staffRequestGetStaffInfoWithId:(NSString *)staffId success:(void(^)(NNBAccount *staffInfoModel))successBlock fail:(void(^)(id error))failBlock
{
    if (!staffId) {
        DLog(@"员工id不能为空");
        return;
    }
    NSString *url = [NSString stringWithFormat:@"%@staff/get_staff_info",BossBasicURL];
    
    NSDictionary *paramDic = @{
                               @"staff_id":staffId,
                               };
    [NNBBasicRequest postJsonWithUrl:url parameters:paramDic CMD:nil success:^(id responseObject) {
        if ([NNBRequestManager saveAccountInfoWithAccountDic:responseObject]) {
            kCurrentAccount.isNeedUpdate = NO;
            if (successBlock) {
                successBlock(kCurrentAccount);
            }
        } else {
            
        }
    } fail:^(id error) {
        if (!failBlock) {
            return;
        }
        failBlock(error);
    }];
}

/**
 手持端编辑员工
 
 @param staffInfo 员工信息
 @param successBlock 是否更新成功
 @param failBlock 服务器响应失败
 */
+ (void)staffRequestUpdateStaffInfoWithStaffInfo:(NNBAccount *)staffInfo success:(void(^)(BOOL updateSuccess))successBlock fail:(void(^)(id error))failBlock
{
    if (!staffInfo) {
        DLog(@"员工信息为空");
        return;
    }
    NSString *url = [NSString stringWithFormat:@"%@staff/mobile_update_staff_info",BossBasicURL];
    
    NSDictionary *paramDic = @{
                               @"staff_id":kCurrentAccount.staff_id
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
    if (staffInfo.departure_reason) {
        [paramDic setValue:staffInfo.departure_reason forKey:@"departure_reason"];
    }
    if (staffInfo.departure_approver_account_id) {
        [paramDic setValue:staffInfo.departure_approver_account_id forKey:@"departure_approver_account_id"];
    }
    if (staffInfo.job_transfer_remark) {
        [paramDic setValue:staffInfo.job_transfer_remark forKey:@"job_transfer_remark"];
    }
    if (staffInfo.health_certificate) {
        [paramDic setValue:staffInfo.health_certificate forKey:@"health_certificate"];
    }
    if (staffInfo.health_certificate_back) {
        [paramDic setValue:staffInfo.health_certificate_back forKey:@"health_certificate_back"];
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
        
    [NNBBasicRequest postJsonWithUrl:url parameters:paramDic CMD:nil success:^(id responseObject) {
        if (!successBlock) {
            return;
        }
        BOOL ok = [responseObject[@"ok"] boolValue];
        kCurrentAccount.isNeedUpdate = YES;
        successBlock(ok);
    } fail:^(id error) {
        if (!failBlock) {
            return;
        }
        failBlock(error);
    }];
}
@end
