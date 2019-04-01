//
//  ReferralFeeRequest.h
//  AFNetworking
//
//  Created by admin on 2019/3/29.
//

#import <Foundation/Foundation.h>
#import "InputMessageModel.h"
#import "RecommendListModel.h"
#import "ReferralFeeRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface ReferralFeeRequest : NSObject
+ (void)recommendSubmit:(BOOL)isSubmit  WithParam:(InputMessageModel *)inputModel ll:(void(^)(InputMessageModel *inputModel))successBlock fail:(void(^)(void))failBlock;

//1:已保存 10:已推荐 100:已入职 state
+ (void)recommendList:(NSInteger)state success:(void(^)(NSArray *listModel))successBlock fail:(void(^)(void))failBlock;
//internal_recommend.internal_recommend_staff.get
+ (void)recommendDetail:(NSString *)idStr success:(void(^)(NSArray *list))successBlock fail:(void(^)(void))failBlock;
//internal_recommend.internal_recommend_staff.delete   删除员工
+ (void)deleteRecommend:(NSArray *)idcardArr success:(void(^)(void))successBlock fail:(void(^)(void))failBlock;
@end

NS_ASSUME_NONNULL_END
