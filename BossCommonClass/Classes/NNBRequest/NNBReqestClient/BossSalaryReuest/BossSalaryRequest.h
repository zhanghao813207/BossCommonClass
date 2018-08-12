//
//  BossSalaryRequest.h
//  BossCommonClass
//
//  Created by 贾远潮 on 2018/8/12.
//

#import <Foundation/Foundation.h>
#import "SalaryModel.h"

@interface BossSalaryRequest : NSObject

/**
 查询薪资明细

 @param salaryId 薪资id
 @param successBlock 成功回调
 @param failBlock 服务器响应失败
 */
+ (void)salaryRequestGetSalaryDetailWithSalaryId:(NSString *)salaryId success:(void(^)(SalaryModel *salaryModel))successBlock fail:(void(^)(id error))failBlock;

@end
