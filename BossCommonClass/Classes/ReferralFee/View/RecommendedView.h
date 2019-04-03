//
//  RecommendedView.h
//  AFNetworking
//
//  Created by admin on 2019/3/26.
//

#import <UIKit/UIKit.h>
@class RecommendedModel;
NS_ASSUME_NONNULL_BEGIN
@protocol RecommendedViewDelegate <NSObject>

- (void)didSelectModel:(RecommendedModel *)model;

- (void)submitAll:(NSArray *)modelArr;

- (void)deleteAll:(NSArray *)modelArr;
@end
@interface RecommendedView : UIView
@property(nonatomic, strong)NSMutableArray *dataArr;
@property(nonatomic, assign)BOOL isEditing;
@property(nonatomic, weak)id<RecommendedViewDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
