//
//  SendMessageStartVc.h
//  BossOwner
//
//  Created by 高炀辉 on 2019/6/21.
//  Copyright © 2019 欧客云. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BossViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface SendMessageStartVc : BossViewController
@property (nonatomic, strong)NSString *name;
@property (nonatomic, strong)NSString *teamName;
@property (nonatomic, strong)NSString *targetid;
@property (weak, nonatomic) IBOutlet UILabel *headerNameLabel;
@property (weak, nonatomic) IBOutlet UIView *headerLabelView;

@end

NS_ASSUME_NONNULL_END
