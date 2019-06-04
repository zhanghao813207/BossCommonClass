//
//  EntrustAccountRegistrationFailedVC.h
//  BossCommonClass
//
//  Created by 张浩 on 2019/5/23.
//

#import "BossViewController.h"

NS_ASSUME_NONNULL_BEGIN

/**
 委托个户注册审核失败页
 */
@interface EntrustAccountRegistrationFailedVC : BossViewController

@property (nonatomic, strong) NSString *url;

@property (nonatomic, strong) NSString *reason;

@end

NS_ASSUME_NONNULL_END
