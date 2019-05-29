//
//  WaitRecommendVC.h
//  AFNetworking
//
//  Created by admin on 2019/3/26.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 待推荐代理
 */
@protocol WaitRecommendVCDelgate <NSObject>

/**
 提交失败回调

 @param ids 提交失败的推荐IDs
 */
- (void)waitRecommendVCfailIds:(NSArray *)ids;

/**
 删除成功回调

 @param ids 删除成功的推荐IDs
 */
- (void)deletAll:(NSArray *)ids;

@end

/**
 待推荐页
 */
@interface WaitRecommendVC : UIViewController

/**
 判断是否是编辑状态
 */
@property(nonatomic, assign)BOOL isEditing;
@property(nonatomic, weak)id<WaitRecommendVCDelgate>delegate;

/**
 刷新列表
 */
- (void)updateWithIds:(NSArray *)ids;
- (void)refresh;

@end

NS_ASSUME_NONNULL_END
