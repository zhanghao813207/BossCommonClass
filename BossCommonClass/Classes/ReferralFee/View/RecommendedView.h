//
//  RecommendedView.h
//  AFNetworking
//
//  Created by admin on 2019/3/26.
//

#import <UIKit/UIKit.h>
@class RecommendedModel;
NS_ASSUME_NONNULL_BEGIN

/**
 推荐View操作代理
 */
@protocol RecommendedViewDelegate <NSObject>

/**
 单条选中回调
 */
- (void)didSelectModel:(RecommendedModel *)model;

/**
 点击全部提交回调
 */
- (void)submitAll:(NSArray *)modelArr;

/**
 点击全部删除回调
 */
- (void)deleteAll:(NSArray *)modelArr;

/**
 下拉刷新
 */
- (void)refresh;

/**
 上拉加载更多
 */
- (void)getMore;
@end

/**
 推荐View
 */
@interface RecommendedView : UIView
@property(nonatomic, strong)NSMutableArray *dataArr;

/**
 是否编辑状态
 */
@property(nonatomic, assign)BOOL isEditing;

@property(nonatomic, weak)id<RecommendedViewDelegate>delegate;

/**
 是不是待推荐
 */
@property(nonatomic, assign)BOOL isWait;

/**
 是否从已推荐跳入
 */
@property(nonatomic, assign)BOOL isFinish;

/**
 是否有上拉
 */
@property(nonatomic, assign)BOOL isHasmore;

- (void)headerFresh;

/**
 上拉没有更多数据
 */
- (void)noDataViewCount:(NSInteger)count;

@end

NS_ASSUME_NONNULL_END
