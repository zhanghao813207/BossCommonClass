//
//  UserInfoFixVc.h
//  BossCommonClass
//
//  Created by 高炀辉 on 2019/11/13.
//

#import <UIKit/UIKit.h>
#import "BossBasicDefine.h"
#import "BossViewController.h"
NS_ASSUME_NONNULL_BEGIN

@interface UserInfoFixVc : BossViewController

// 修改类型
@property (nonatomic, assign)SelectModifyOperationType fixType;

// 修改类型
@property (nonatomic, assign)changeUserInfoCurrentstate fixState;
// 任务ID
@property (nonatomic, strong)NSString *taskID;

@property (nonatomic, assign)NSInteger days;

@end

NS_ASSUME_NONNULL_END
