//
//  BOOperatCompassVC.h
//  BossKnight
//
//  Created by admin on 2019/7/19.
//

#import <UIKit/UIKit.h>
#import "BossViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface BOOperatCompassVC : BossViewController

@property(nonatomic, copy) NSString *teamId;
// 团队List
@property(nonatomic, strong) NSArray *teamList;


@end

NS_ASSUME_NONNULL_END
