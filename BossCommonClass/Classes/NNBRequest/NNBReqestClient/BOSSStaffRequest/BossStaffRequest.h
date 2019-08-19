//
//  BossStaffRequest.h
//  Pods-BossKnight
//
//  Created by 贾远潮 on 2018/5/23.
//

#import <Foundation/Foundation.h>
#import "BossKnightAccount.h"
#import "StaffTagModel.h"

@interface BossStaffRequest : NSObject

/**
 获取人员详情

 @param successBlock 成功返回人员的信息
 @param failBlock 响应失败
 */
+ (void)staffRequestGetStaffInfoWithId:(void(^)(void))successBlock fail:(void(^)(id error))failBlock;

/**
 手持端编辑人员

 @param staffInfo 人员信息
 @param successBlock 是否更新成功
 @param failBlock 服务器响应失败
 */
+ (void)staffRequestUpdateStaffInfoWithStaffInfo:(BossKnightAccountModel *)staffInfo success:(void(^)(BOOL updateSuccess))successBlock fail:(void(^)(id error))failBlock;


/**
 获取骑士标签列表

 @param successBlock 成功
 @param failBlock 服务器响应失败
 */
+ (void)staffRequestFindStaffTagSuccess:(void(^)(NSArray <StaffTagModel *>*staffTagList))successBlock fail:(void(^)(id error))failBlock;

@end
