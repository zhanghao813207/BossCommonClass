//
//  FinishRecommendVC.h
//  AFNetworking
//
//  Created by admin on 2019/3/26.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 已推荐代理
 */
@protocol FinishRecommendVCDelegate <NSObject>

/**
 删除成功回调
 */
- (void)deleteModel;

@end

/**
 已推荐页
 */
@interface FinishRecommendVC : UIViewController

@property (nonatomic, strong)NSString *teamID;

/**
 是否编辑
 */
@property(nonatomic, assign)BOOL isEditing;
/**
 是否从已推荐跳入
 */
@property(nonatomic, assign)BOOL isFinish;

@property(nonatomic, weak)id<FinishRecommendVCDelegate>delegate;

/**
 刷新列表
 */
- (void)update;

@end

NS_ASSUME_NONNULL_END
