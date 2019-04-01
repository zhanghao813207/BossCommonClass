//
//  RecommendedCell.h
//  AFNetworking
//
//  Created by admin on 2019/3/26.
//

#import <UIKit/UIKit.h>
#import "RecommendedModel.h"
@class RecommendedCell;
NS_ASSUME_NONNULL_BEGIN


@protocol RecommendedCellDelegate <NSObject>

- (void)didSelect:(RecommendedModel *)model cell:(RecommendedCell *)cell;

@end

@interface RecommendedCell : UITableViewCell
@property(nonatomic, strong)RecommendedModel *model;
@property(nonatomic, weak)id<RecommendedCellDelegate>delegate;
@end

NS_ASSUME_NONNULL_END
