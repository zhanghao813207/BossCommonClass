//
//  MessageContentVc.h
//  BossOwner
//
//  Created by 高炀辉 on 2019/6/21.
//  Copyright © 2019 欧客云. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BossViewController.h"
NS_ASSUME_NONNULL_BEGIN
//
@interface MessageContentVc : BossViewController
@property (nonatomic, strong)NSString *sectionid;
@property (nonatomic, strong)NSString *targetid;
@property (nonatomic, strong)CABasicAnimation *animation;
 
@end

NS_ASSUME_NONNULL_END
