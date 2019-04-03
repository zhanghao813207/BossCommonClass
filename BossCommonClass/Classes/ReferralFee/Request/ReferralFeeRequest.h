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
#import "RecommendDetailModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ReferralFeeRequest : NSObject
+ (void)recommendSubmit:(BOOL)isSubmit  WithParam:(InputMessageModel *)inputModel success:(void(^)(InputMessageModel *inputModel))successBlock fail:(void(^)(NSString *))failBlock;

//1:已保存 10:已推荐 100:已入职 state
+ (void)recommendList:(NSInteger)state success:(void(^)(NSArray *listModel))successBlock fail:(void(^)(void))failBlock;
//internal_recommend.internal_recommend_staff.get
+ (void)recommendDetail:(NSString *)idStr success:(void(^)(NSArray *list))successBlock detailModel:(void(^)(RecommendDetailModel *model))detailmodel fail:(void(^)(void))failBlock;
//internal_recommend.internal_recommend_staff.delete   删除员工
+ (void)deleteRecommend:(NSArray *)idcardArr success:(void(^)(void))successBlock fail:(void(^)(void))failBlock;
////批量提交 internal_recommend.internal_recommend_staff.batch_submit
+ (void)submitArrs:(NSArray *)idcardArr success:(void(^)(NSArray *sucessarr))successBlock fail:(void(^)(NSArray *failArr))failBlock;
@end

NS_ASSUME_NONNULL_END
