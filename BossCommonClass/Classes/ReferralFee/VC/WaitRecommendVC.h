//
//  WaitRecommendVC.h
//  AFNetworking
//
//  Created by admin on 2019/3/26.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol WaitRecommendVCDelgate <NSObject>

- (void)waitRecommendVCfailIds:(NSArray *)ids;

- (void)deletAll:(NSArray *)ids;

@end

@interface WaitRecommendVC : UIViewController

/**
 判断是否是编辑状态
 */
@property(nonatomic, assign)BOOL isEditing;
@property(nonatomic, weak)id<WaitRecommendVCDelgate>delegate;
- (void)updateWithIds:(NSArray *)ids;
- (void)refresh;

@end

NS_ASSUME_NONNULL_END
