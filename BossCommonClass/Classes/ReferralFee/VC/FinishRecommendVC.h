//
//  FinishRecommendVC.h
//  AFNetworking
//
//  Created by admin on 2019/3/26.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol FinishRecommendVCDelegate <NSObject>

- (void)deleteModel;

@end

@interface FinishRecommendVC : UIViewController
@property(nonatomic, assign)BOOL isEditing;
/**
 是否从已推荐跳入
 */
@property(nonatomic, assign)BOOL isFinish;
@property(nonatomic, weak)id<FinishRecommendVCDelegate>delegate;
- (void)update;
@end

NS_ASSUME_NONNULL_END
