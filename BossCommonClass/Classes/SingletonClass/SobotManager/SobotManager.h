//
//  SobotManager.h
//  NNBarKnight
//
//  Created by 贾远潮 on 2017/10/10.
//  Copyright © 2017年 贾远潮. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SobotManager : NSObject

+ (__kindof SobotManager *)shareSobotManager;

- (void)startChatWithViewController:(UIViewController *)viewController;

@end
