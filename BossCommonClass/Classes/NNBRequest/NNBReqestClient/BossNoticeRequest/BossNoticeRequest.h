//
//  BossNoticeRequest.h
//  BossCommonClass
//
//  Created by 贾远潮 on 2018/8/9.
//

#import <Foundation/Foundation.h>
#import "NoticeModuleModel.h"


@interface BossNoticeRequest : NSObject

/**
 BOSS通知
 
 @param page 页码
 @param limit 每页个数
 @param successBlock 成功的回调
 @param failBlock 服务器响应失败
 */
+ (void)noticeRequsetFindListWithPage:(NSInteger)page limit:(NSInteger)limit Success:(void(^)(NSArray <NoticeModuleModel *>*noticeList, NSInteger totalCount))successBlock fail:(void(^)(id error))failBlock;
@end
