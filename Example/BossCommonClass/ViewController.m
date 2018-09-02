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
#import "BossOaExamineRequest.h"
#import "BorderView.h"
#import "BossMessageRequest.h"
@interface ViewController ()

@property (nonatomic, strong) CostOrderModel *applyModel;


@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
//
//    [BossAccount userIsLoginSuccess:^(BOOL isSuccess, BOOL isFirstLogin) {
//    } withController:self];
    
    [BossMessageRequest msgRequestGetBaChannelMessageWithPage:1 limit:30 success:^(NSArray<BossAssistantMessageModel *> *msgList) {

    } fail:^(id error) {

    }];
    
//    [BossMessageRequest msgRequestCountMsgWithChannleId:@"BA" state:@[@(MESSAGE_TYPE_NEW),@(MESSAGE_TYPE_SEND),@(MESSAGE_TYPE_READ)] success:^(NSInteger cnt) {
//
//    } fail:^(id error) {
//
//    }];
//    [BossMessageRequest msgRequestGetSysChannelMessageWithPage:1 limit:30 success:^(NSArray<BossNoticeMessageModel *> *msgList) {
//
//    } fail:^(id error) {
//
//    }];
    
//    [BossOaExamineRequest OaExamineRequestGetExamineListWithType:MOBILE_PASS_EXAMINE_FAIL page:1 successBlock:^(NSArray<ExamineOrderModel *> *examineFlowList) {
//
//    } fail:^(id error) {
//
//    }];
    
//    5afd4d41ce6d2a06a8332345 状态100的单子 5b74db05ce6d2a63b4ac77e2 状态10的单子
    
//    [BossOaExamineRequest OaExamineRequestGetExamineDetailWithExamineId:@"5b74db05ce6d2a63b4ac77e2" successBlock:^(ExamineOrderModel *examineFlowList) {
//
//    } fail:^(id error) {
//
//    }];
    
//    [BossOaExamineRequest OaExamineRequestGetCostOrderListWithPage:1 successBlock:^(NSArray<CostOrderModel *> *costOrderList) {
//
//    } fail:^(id error) {
//
//    }];
    
//    5afd4d41ce6d2a06a8332341
    
//    [BossOaExamineRequest OaApplyOrderDetailWithOrderId:@"5afd4d41ce6d2a06a8332341" successBlock:^(CostOrderModel *applyOrder) {
//
//    } fail:^(id error) {
//
//    }];
    
//    [BossOaExamineRequest OaExamineRequestAgreeWithExamineFlowId:@"" examineRecordId:@"" note:@"" success:^(BOOL ok) {
//
//    } fail:^(id error) {
//
//    }];
    
//    [BossOaExamineRequest OaExamineRequestRejectWithExamineFlowId:@"" examineRecordId:@"" rejectNodeId:@"" note:@"" success:^(BOOL ok) {
//
//    } fail:^(id error) {
//
//    }];
//
//    [BossOaExamineRequest OaExamineRequestUrgedWithExamineId:@"" success:^(BOOL ok) {
//
//    } fail:^(id error) {
//
//    }];
    
//    BorderView *view = [[BorderView alloc] initWithFrame:CGRectMake(100, 100, 200, 200)];
//    view.backgroundColor = [UIColor grayColor];
//    view.cornerRadius = 10.f;
//    view.borderWidth = 0.5f;
//    view.borderColor = [UIColor redColor];
//    view.rectCorner = BorderDirectionRight | BorderDirectionBottom;
//    [self.view addSubview:view];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
