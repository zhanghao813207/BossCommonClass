//
//  BOOperatCompassVC.h
//  BossKnight
//
//  Created by admin on 2019/7/19.
//  Copyright © 2019 贾远潮. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BOOperatCompassVC : UIViewController

@property(nonatomic, copy) NSString *teamId;
// 团队List
@property(nonatomic, strong) NSArray *teamList;
// 商圈名字数组
@property (nonatomic, strong) NSMutableArray * bizDistrictNameArr;

@end

NS_ASSUME_NONNULL_END
