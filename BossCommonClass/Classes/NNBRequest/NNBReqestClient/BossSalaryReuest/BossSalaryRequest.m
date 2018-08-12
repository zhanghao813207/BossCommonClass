//
//  BossSalaryRequest.m
//  BossCommonClass
//
//  Created by 贾远潮 on 2018/8/12.
//

#import "BossSalaryRequest.h"
#import "BossBasicDefine.h"
#import "NNBBasicRequest.h"

@implementation BossSalaryRequest

/**
 查询薪资明细
 
 @param salaryId 薪资id
 @param successBlock 成功回调
 @param failBlock 服务器响应失败
 */
+ (void)salaryRequestGetSalaryDetailWithSalaryId:(NSString *)salaryId success:(void(^)(SalaryModel *salaryModel))successBlock fail:(void(^)(id error))failBlock
{
    NSString *url = [NSString stringWithFormat:@"%@salary_inquiries/gain_salary_detail",BossBasicURL];
    NSDictionary *paramDic = @{
                               @"_id":salaryId,
                               };
    [NNBBasicRequest postJsonWithUrl:url parameters:paramDic CMD:nil success:^(id responseObject) {
        DLog(@"%@", responseObject);
        if (!successBlock) {
            return;
        }
        SalaryModel *model = [[SalaryModel alloc] init];
        [model setValuesForKeysWithDictionary:responseObject];
        successBlock(model);
    } fail:^(id error) {
        if(failBlock){
            failBlock(error);
        }
    }];
}

@end
