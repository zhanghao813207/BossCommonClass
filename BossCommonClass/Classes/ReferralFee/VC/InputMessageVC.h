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

@interface InputMessageVC : UIViewController
@property(nonatomic,strong)InputMessageModel *model;

/**
 判断是推荐输入还是查看详情
 */
@property(nonatomic, assign)BOOL isDetail;
- (void)cityView;

@property(nonatomic, strong)RecommendedModel *listModel;

@end

NS_ASSUME_NONNULL_END
