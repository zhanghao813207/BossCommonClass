//
//  BossSalaryRuleRequest.m
//  BossCommonClass
//
//  Created by 贾远潮 on 2018/11/6.
//

#import "BossSalaryRuleRequest.h"
#import "NNBBasicRequest.h"
#import "AttendanceTemplateModel.h"
#import "OrderTemplateModel.h"
#import "QualityTemplateModel.h"
#import "ManageTemplateModel.h"
#import "NNBRequestManager.h"

@implementation BossSalaryRuleRequest

/**
 获取指标列表
 
 @param platformCode 平台code
 @param successBlock 成功回调
 @param failBlock 服务器响应失败
 */
+ (void)salaryRequestFindSalaryVarListWithPlatformCode:(NSString *)platformCode success:(void(^)(NSArray <IndexInfoModel *>*indexList))successBlock fail:(void(^)(id error))failBlock;
{
    NSDictionary *paramDic = @{
                               @"_meta":@{
                                       @"page":@(1),
                                       @"limit":@(500),
                                       },
                               @"platform_code":platformCode,
                               @"state":@(100),
                               @"tags":@[@"1",@"2",@"3",@"4"],
                               };
    [NNBBasicRequest postJsonWithUrl:kUrl parameters:paramDic CMD:@"salary.salary_var.find" success:^(id responseObject) {
        if (!successBlock) {
            return;
        }
        NSMutableArray *array = [NSMutableArray array];
        for (NSDictionary *resDic in responseObject[@"data"]) {
            IndexInfoModel *model = [[IndexInfoModel alloc] init];
            [model setValuesForKeysWithDictionary:resDic];
            [array addObject:model];
        }
        successBlock([array copy]);
    } fail:^(id error) {
        DLog(@"payrollerror = %@",error);
    }];
}
/**
 服务费方案版本详情
 
 @param versionId 版本ID
 @param successBlock 成功回调
 @param failBlock 服务器响应失败
 */
+ (void)salaryRuleRequestGetSalaryPlaneDetailWithVersionId:(NSString *)versionId success:(void(^)(SalaryPlaneModel *salaryPlaneModel))successBlock fail:(void(^)(id error))failBlock
{
    
    NSDictionary *paramDic = @{
                               @"_id":versionId,
                               };
    [NNBBasicRequest postJsonWithUrl:kUrl parameters:paramDic CMD:@"salary.salary_plan_version.get" success:^(id responseObject) {
        if (!successBlock) {
            return;
        }
        SalaryPlaneModel *model = [[SalaryPlaneModel alloc] init];
        [model setValuesForKeysWithDictionary:responseObject];
        successBlock(model);
    } fail:^(id error) {
        DLog(@"payrollerror = %@",error);
    }];

}

/**
 服务费计算规则列表
 
 @param ruleCollectionId 服务费规则集ID
 @param collection_cate 规则分类(1:单量,2:出勤,3:质量,4:管理)
 @param successBlock 成功回调
 @param failBlock 失败
 */
+ (void)salaryRuleRequestFindSalaryRuleListWithRuleCollectionId:(NSString *)ruleCollectionId salarRuleCollectionType:(SalaryRuleCollectionType)collection_cate success:(void(^)(NSArray <TemplateDataBasicModel *>*templateList))successBlock fail:(void (^)(id error))failBlock
{
    NSDictionary *paramDic = @{
                               @"_meta":@{
                                       @"page":@(1),
                                       @"limit":@(100),
                                       },
                               @"rule_collection_id":ruleCollectionId,
                               @"collection_cate":@(collection_cate),
                               @"state":@(100),
                               };
    [NNBBasicRequest postJsonWithUrl:kUrl parameters:paramDic CMD:@"salary.salary_rule.find" success:^(id responseObject) {
        if (!successBlock) {
            return;
        }
        DLog(@"responseObject %@",responseObject);
        NSMutableArray *array = [NSMutableArray array];
        switch (collection_cate) {
            case SalaryRuleCollectionTypeOrder:
            {
                for (NSDictionary *resDic in responseObject[@"data"]) {
                    OrderTemplateModel *model = [[OrderTemplateModel alloc] init];
                    [model setValuesForKeysWithDictionary:resDic];
                    [array addObject:model];
                }
            }
                break;
            case SalaryRuleCollectionTypeAttendance:
            {
                for (NSDictionary *resDic in responseObject[@"data"]) {
                    AttendanceTemplateModel *model = [[AttendanceTemplateModel alloc] init];
                    [model setValuesForKeysWithDictionary:resDic];
                    [array addObject:model];
                }

            }
                break;
            case SalaryRuleCollectionTypeQuality:
            {
                for (NSDictionary *resDic in responseObject[@"data"]) {
                    QualityTemplateModel *model = [[QualityTemplateModel alloc] init];
                    [model setValuesForKeysWithDictionary:resDic];
                    [array addObject:model];
                }

            }
                break;
            case SalaryRuleCollectionTypeManage:
            {
                for (NSDictionary *resDic in responseObject[@"data"]) {
                    ManageTemplateModel *model = [[ManageTemplateModel alloc] init];
                    [model setValuesForKeysWithDictionary:resDic];
                    [array addObject:model];
                }
            }
                break;
            default:
            {
                for (NSDictionary *resDic in responseObject[@"data"]) {
                    TemplateDataBasicModel *model = [[TemplateDataBasicModel alloc] init];
                    [model setValuesForKeysWithDictionary:resDic];
                    [array addObject:model];
                }
            }
                break;
        }
        successBlock([array copy]);
    } fail:^(id error) {
        DLog(@"payrollerror = %@",error);
    }];
}

/**
 人员服务费计算结果集列表
 
 @param page 页数
 @param taskId  服务费试算任务id
 @param type '1（人员明细）2（商圈）3（城市）'
 @param successBlock 成功的回调
 @param failBlock 服务器响应失败
 */
+ (void)salaryComputeFindSalaryComputeDataSetWithPage:(NSInteger)page taskID:(NSString *)taskId type:(SalaryComputeTaskType)type success:(void(^)(BOOL hasMore, NSArray <SalaryComputeDatasetModel *> *salaryComputeList))successBlock fail:(void (^)(id error))failBlock
{
    NSDictionary *paramDic = @{
                               @"_meta":@{
                                       @"page":@(page),
                                       @"limit":@(10),
                                       },
                               @"_id":taskId,
                               @"type":@(type),
                               };
    [NNBBasicRequest postJsonWithUrl:kUrl parameters:paramDic CMD:@"salary.salary_compute_task.dataset_find" success:^(id responseObject) {
        if (!successBlock) {
            return;
        }
        NSMutableArray *array = [NSMutableArray array];
        for (NSDictionary *resDic in responseObject[@"data"]) {
            SalaryComputeDatasetModel *model = [[SalaryComputeDatasetModel alloc] init];
            [model setValuesForKeysWithDictionary:resDic];
            [array addObject:model];
        }
        successBlock([responseObject[@"_meta"][@"has_more"] boolValue],[array copy]);
    } fail:^(id error) {
        DLog(@"payrollerror = %@",error);
    }];
}
@end
