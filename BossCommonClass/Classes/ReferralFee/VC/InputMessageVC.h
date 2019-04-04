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

- (void)hintMessage:(NSString *)hintStr;

@end

@interface InputMessageVC : UIViewController
@property(nonatomic,strong)InputMessageModel *model;

/**
 是否已入职
 */
@property(nonatomic, assign)BOOL isEntry;
@property(nonatomic, strong)NSArray *dataArr;

@property(nonatomic, strong)NSMutableArray *fieldArr;


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
