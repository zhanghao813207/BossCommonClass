//
//  SendMessageStartVc.h
//  BossOwner
//
//  Created by 高炀辉 on 2019/6/21.
//  Copyright © 2019 高炀辉. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BossViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface SendMessageStartVc : BossViewController
@property (nonatomic, strong)NSString *name;
@property (nonatomic, strong)NSString *teamName;
@property (nonatomic, strong)NSString *targetid;

@end

NS_ASSUME_NONNULL_END
