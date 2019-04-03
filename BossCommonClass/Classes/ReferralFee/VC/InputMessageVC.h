//
//  InputMessageVC.h
//  AFNetworking
//
//  Created by admin on 2019/3/27.
//

#import <UIKit/UIKit.h>
#import "InputMessageModel.h"
#import "FooterView.h"
#import "GetCityView.h"
#import "RecommendedModel.h"

NS_ASSUME_NONNULL_BEGIN

@protocol InputMessageVCDelegate <NSObject>

- (void)InputMessageVCTypeStr:(NSString *)typeStr;

@end

@interface InputMessageVC : UIViewController
@property(nonatomic,strong)InputMessageModel *model;

/**
 判断是推荐输入还是查看详情
 */
@property(nonatomic, assign)BOOL isDetail;
- (void)cityView;

@property(nonatomic, strong)RecommendedModel *listModel;
@property(nonatomic, strong)UITableView *tableview;
@property(nonatomic, strong)FooterView *footerView;

/**
 0待推荐  1 已推荐  2已入职
 */
@property(nonatomic, assign)NSInteger index;
@property(nonatomic, weak)id<InputMessageVCDelegate>delegate;
@end

NS_ASSUME_NONNULL_END
