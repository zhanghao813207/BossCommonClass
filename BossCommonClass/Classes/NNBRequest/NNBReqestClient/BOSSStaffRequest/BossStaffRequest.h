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
 获取员工详情

 @param staffId 员工ID
 @param successBlock 成功返回员工的信息
 @param failBlock 响应失败
 */
+ (void)staffRequestGetStaffInfoWithId:(NSString *)staffId success:(void(^)(BossKnightAccount *staffInfoModel))successBlock fail:(void(^)(id error))failBlock;

/**
 手持端编辑员工

 @param staffInfo 员工信息
 @param successBlock 是否更新成功
 @param failBlock 服务器响应失败
 */
+ (void)staffRequestUpdateStaffInfoWithStaffInfo:(BossKnightAccount *)staffInfo success:(void(^)(BOOL updateSuccess))successBlock fail:(void(^)(id error))failBlock;


/**
 获取骑士标签列表

 @param successBlock 成功
 @param failBlock 服务器响应失败
 */
+ (void)staffRequestFindStaffTagSuccess:(void(^)(NSArray <StaffTagModel *>*staffTagList))successBlock fail:(void(^)(id error))failBlock;

@end
