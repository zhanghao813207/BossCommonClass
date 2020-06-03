//
//  BossAccountRequest.m
//  BossCommonClass
//
//  Created by 贾远潮 on 2018/8/8.
//

#import "BossAccountRequest.h"
#import "BossBasicDefine.h"
#import "NNBBasicRequest.h"
#import "NNBRequestManager.h"
#import "BossManagerAccount.h"
@implementation BossAccountRequest

/**
 获取账号信息
 
 @param accountId 账号id
 @param successBlock 成功的回调
 @param failBlock 失败的回调
 */
+ (void)BossAccountRequestGainAccountWithAccountId:(NSString *)accountId success:(void(^)(BossManagerAccountModel *))successBlock fail:(void(^)(id error))failBlock
{
//    NSString *url = [NSString stringWithFormat:@"%@/account/gain_account_detail", kUrlApiVersion(@"/1.0")];
//    NSDictionary *paramDic = @{
//                               @"id":accountId
//                               };
//    [NNBBasicRequest postJsonWithUrl:url parameters:paramDic CMD:nil success:^(id responseObject) {
//
//        NSLog(@"BossAccountRequestGainAccountWithAccountId->response\n%@", responseObject);
//
//        BossManagerAccountModel *accountModel = [[BossManagerAccountModel alloc] init];
//        [accountModel setValuesForKeysWithDictionary:responseObject];
//
//        if (successBlock) {
//            successBlock(accountModel);
//        }
//    } fail:^(id error) {
//        if(failBlock){
//            failBlock(error);
//        }
//    }];
    
    
    NSDictionary *paramDic = @{
                               @"_id":accountId
                               };
    [NNBBasicRequest postJsonWithUrl:kUrl parameters:paramDic CMD:@"account.account.get" success:^(id responseObject) {

        NSLog(@"BossAccountRequestGainAccountWithAccountId->response\n%@", responseObject);

        BossManagerAccountModel *accountModel = [[BossManagerAccountModel alloc] init];
        // 从里层获取平台，供应商，城市信息
        NSDictionary *employeeData = responseObject;
        if ([employeeData.allKeys containsObject:@"employee_info"] && employeeData[@"employee_info"] != [NSNull null]) {
            NSDictionary *businessInfoData = employeeData[@"employee_info"];
            if ([businessInfoData.allKeys containsObject:@"biz_data_business_info"] && businessInfoData[@"biz_data_business_info"] != [NSNull null]) {
                [accountModel setValuesForKeysWithDictionary:businessInfoData[@"biz_data_business_info"]];
            }
        }
        // 保存个人信息
        accountModel._id = responseObject[@"_id"];
        accountModel.phone = responseObject[@"phone"];
        accountModel.name = responseObject[@"name"];
        accountModel.created_at = responseObject[@"created_at"];
        accountModel.state = [responseObject[@"state"] integerValue];
        // 是否是超级管理员
        accountModel.is_admin = [responseObject[@"is_admin"] boolValue];
        // 如果是超级管理员，需从外部取平台，供应商，城市信息，且只能取到code/id信息，没有name
        if (accountModel.is_admin == YES) {
            NSMutableArray *platform_list = [[NSMutableArray alloc] init];
            NSMutableArray *supplier_list = [[NSMutableArray alloc] init];
            NSMutableArray *city_list = [[NSMutableArray alloc] init];
            for (NSString *code in responseObject[@"platform_list"]) {
                PlatformModel *model = [[PlatformModel alloc] init];
                model.platform_code = code;
                [platform_list addObject:model];
            }
            accountModel.platform_list = [[NSArray alloc] initWithArray:platform_list];
            for (NSString *code in responseObject[@"supplier_list"]) {
                SupplierModel *model = [[SupplierModel alloc] init];
                model._id = code;
                [supplier_list addObject:model];
            }
            accountModel.supplier_list = [[NSArray alloc] initWithArray:supplier_list];
            for (NSString *code in responseObject[@"city_codes"]) {
                CityModel *model = [[CityModel alloc] init];
                model.city_code = code;
                [city_list addObject:model];
            }
            accountModel.city_list = [[NSArray alloc] initWithArray:city_list];
        }
        if (successBlock) {
            successBlock(accountModel);
        }
    } fail:^(id error) {
        if(failBlock){
            failBlock(error);
        }
    }];
}

@end
