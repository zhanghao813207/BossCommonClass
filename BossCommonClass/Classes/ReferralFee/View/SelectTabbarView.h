//
//  SelectTabbarView.h
//  AFNetworking
//
//  Created by admin on 2019/3/26.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class SelectTabbarView;

/**
 底部按钮操作回调
 */
@protocol SelectTabbarViewDelegate <NSObject>

/**
 点击删除/全部删除操作回调
 */
- (void)deleteModel:(SelectTabbarView *)view;

/**
 点击提交/全部提交操作回调
 */
- (void)selectModel:(SelectTabbarView *)view;

@end

/**
 推荐View底部按钮
 */
@interface SelectTabbarView : UIView

@property(nonatomic, weak)id<SelectTabbarViewDelegate>delegate;

/**
 是否全部选中
 */
@property(nonatomic, assign)BOOL isAll;

/**
 刚进编辑页的数据
 */
@property(nonatomic, strong)NSArray *modelArr;

/**
 选中的数据
 */
@property(nonatomic, strong)NSArray *seletcArr;

/**
 是否从已推荐跳入
 */
@property(nonatomic, assign)BOOL isFinish;
@end

NS_ASSUME_NONNULL_END
