//
//  ViewController.m
//  BossCommonClass_Example
//
//  Created by 贾远潮 on 2018/3/12.
//  Copyright © 2018年 JiaYuanchao. All rights reserved.
//

#import "ViewController.h"
#import "BossBasicDefine.h"
#import "LoginVC.h"
#import "ThirdRequest.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [BossAccount userIsLoginSuccess:^(BOOL isSuccess, BOOL isFirstLogin) {
//        
//    } withController:self];
    
    [ThirdRequest ThirdRequestGetBankByBankcardId:@"621434" success:^(BOOL resp,NSString *bankName) {
        
    } fail:^(NSError *err) {
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
