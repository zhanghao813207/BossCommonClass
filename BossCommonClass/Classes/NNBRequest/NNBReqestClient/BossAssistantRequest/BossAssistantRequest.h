//
//  BossAssistantRequest.h
//  BossCommonClass
//
//  Created by 贾远潮 on 2018/8/9.
//

#import <Foundation/Foundation.h>
#import "AssistantMessageModuleModel.h"
@interface BossAssistantRequest : NSObject

/**
 BOSS助理

 @param page 页码
 @param limit 限制条数
 @param successBlock 成功的列表
 @param failBlock 失败的列表
 */
+ (void)BossAssistantRequestFindAssistantWithPage:(NSInteger)page Limit:(NSInteger)limit Success:(void(^)(NSArray *messageList, NSInteger totalCount))successBlock fail:(void(^)(id error))failBlock;

@end
