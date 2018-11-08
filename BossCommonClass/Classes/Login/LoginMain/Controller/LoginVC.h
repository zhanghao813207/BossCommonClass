//
//  LoginVC.h
//  NNB
//
//  Created by 贾远潮 on 2017/12/20.
//  Copyright © 2017年 贾远潮. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginVC : UIViewController

@property (nonatomic, copy) void(^loginSuccessBlock)(BOOL isLogin);

@end
