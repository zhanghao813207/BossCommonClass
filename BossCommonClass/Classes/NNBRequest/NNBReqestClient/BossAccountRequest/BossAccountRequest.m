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
    NSDictionary *paramDic = @{
        @"_id":accountId?:@""
                               };
    [NNBBasicRequest postJsonWithUrl:kUrl parameters:paramDic CMD:@"account.account.get" success:^(id responseObject) {

        NSLog(@"BossAccountRequestGainAccountWithAccountId->response\n%@", responseObject);

        BossManagerAccountModel *accountModel = [[BossManagerAccountModel alloc] init];
        // 从里层获取平台，供应商，城市信息
        NSDictionary *employeeData = responseObject;
        if ([employeeData.allKeys containsObject:@"employee_info"] && employeeData[@"employee_info"] != [NSNull null]) {
            NSDictionary *businessInfoData = employeeData[@"employee_info"];
            if ([businessInfoData.allKeys containsObject:@"biz_data_business_info"] && businessInfoData[@"biz_data_business_info"] != [NSNull null]) {
                NSMutableArray *platform_list = [[NSMutableArray alloc] init];
                NSMutableArray *supplier_list = [[NSMutableArray alloc] init];
                NSMutableArray *city_list = [[NSMutableArray alloc] init];
                for (NSDictionary *platform in businessInfoData[@"biz_data_business_info"][@"platform_list"]) {
                    PlatformModel *model = [[PlatformModel alloc] init];
                    model.platform_code = platform.allKeys.firstObject;
                    model.platform_name = platform.allValues.firstObject;
                    [platform_list addObject:model];
                }
                accountModel.platform_list = [[NSArray alloc] initWithArray:platform_list];
                for (NSDictionary *supplier in businessInfoData[@"biz_data_business_info"][@"supplier_list"]) {
                    SupplierModel *model = [[SupplierModel alloc] init];
                    model._id = supplier.allKeys.firstObject;
                    model.name = supplier.allValues.firstObject;
                    [supplier_list addObject:model];
                }
                accountModel.supplier_list = [[NSArray alloc] initWithArray:supplier_list];
                for (NSDictionary *city in businessInfoData[@"biz_data_business_info"][@"city_list"]) {
                    CityModel *model = [[CityModel alloc] init];
                    model.city_code = city.allKeys.firstObject;
                    model.city_name = city.allValues.firstObject;
                    [city_list addObject:model];
                }
                accountModel.city_list = [[NSArray alloc] initWithArray:city_list];
            }
            
            // 岗位部门信息
            if ([businessInfoData.allKeys containsObject:@"department_info_list"] && [businessInfoData.allKeys containsObject:@"pluralism_department_job_relation_list"]) {
                NSMutableArray *pluralism_department_job_relation_list = [[NSMutableArray alloc] init];
                for (NSDictionary *obj in businessInfoData[@"pluralism_department_job_relation_list"]) {
                    [pluralism_department_job_relation_list addObject:@{
                        @"department_info":obj[@"department_info"],
                        @"job_info":@{@"name":obj[@"job_info"][@"name"]},
                    }];
                }

                NSDictionary *dict = @{
                    @"userId":[NSString stringWithFormat:@"%@", responseObject[@"_id"]],
                    @"major_job_info":businessInfoData[@"major_job_info"],
                    @"major_department_info":businessInfoData[@"major_department_info"],
                    @"department_info_list":businessInfoData[@"department_info_list"],
                    @"pluralism_department_job_relation_list":pluralism_department_job_relation_list,
                };
                [kUserDefault setObject:[self exchangeDict:dict] forKey:@"JobAndDepartmentInfo"];
                [kUserDefault synchronize];
            }
			
			// 银行卡信息
			if (businessInfoData[@"bank_info"] && businessInfoData[@"bank_info"] != [NSNull null]) {
				NSDictionary *bankinfoData = businessInfoData[@"bank_info"];
				BankInfoModel *model = [[BankInfoModel alloc]initWithDictionary:bankinfoData];
				accountModel.bankInfoModel = model;
			}
			
			if (businessInfoData[@"work_email"] && businessInfoData[@"work_email"] != [NSNull null] && ![[businessInfoData[@"work_email"] stringValue] isEqual:@""]) {
				NSString * work_email =  [businessInfoData[@"work_email"] stringValue];
				accountModel.work_email = work_email;
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

+ (NSDictionary *)exchangeDict:(NSDictionary *)dict {
    
    NSMutableDictionary *newDict = [[NSMutableDictionary alloc] init];
    
    for (NSString *key in dict.allKeys) {
        
        id obj = dict[key];
        if ([obj isKindOfClass:[NSString class]] || [obj isKindOfClass:[NSNumber class]]) {
            
            [newDict setObject:obj?:@"" forKey:key];
            
        }else if ([obj isKindOfClass:[NSArray class]]) {
            
            [newDict setObject:[self exchangeArray:obj] forKey:key];
            
        }else if ([obj isKindOfClass:[NSDictionary class]]) {
            
            NSDictionary *everyDict = [self exchangeDict:obj];
            [newDict setObject:everyDict forKey:key];
            
        }
        
    }
    return [NSDictionary dictionaryWithDictionary:newDict];
}

+ (NSArray *)exchangeArray:(NSArray *)array {
    
    NSMutableArray *newArray = [[NSMutableArray alloc] init];
    
    for (id obj in array) {
        
        if ([obj isKindOfClass:[NSString class]] || [obj isKindOfClass:[NSNumber class]]) {
            
            [newArray addObject:obj?:@""];
            
        }else if ([obj isKindOfClass:[NSArray class]]) {
            
            [newArray addObject:[self exchangeArray:obj]];
            
        }else if ([obj isKindOfClass:[NSDictionary class]]) {
            
            NSDictionary *everyDict = [self exchangeDict:obj];
            [newArray addObject:everyDict];
            
        }
        
    }
    
    return [NSArray arrayWithArray:newArray];
}

@end
