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
#import "BossAssistantRequest.h"
#import "BossNoticeRequest.h"
#import "BorderView.h"
@interface ViewController ()

@property (nonatomic, strong) CostOrderModel *applyModel;


@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

//    [BossAccount userIsLoginSuccess:^(BOOL isSuccess, BOOL isFirstLogin) {
//    } withController:self];
    
//    [BossAssistantRequest BossAssistantRequestFindAssistantWithPage:1 Limit:1 Success:^(NSArray *messageList, NSInteger totalCount) {
//
//    } fail:^(id error) {
//
//    }];
    
//    [BossNoticeRequest noticeRequsetFindListWithPage:1 limit:10 Success:^(NSArray *noticeList, NSInteger totalCount) {
//        for (NoticeModuleModel *model in noticeList) {
//            DLog(@"%ld,%ld",model.examineFlowBriefModel.state,totalCount);
//        }
//    } fail:^(id error) {
//
//    }];
    
//    [BossOaExamineRequest OaExamineRequestGetExamineListWithType:1 page:1 successBlock:^(NSArray<ExamineOrderModel *> *examineFlowList) {
//
//    } fail:^(id error) {
//
//    }];
    
//    5afd4d41ce6d2a06a8332345 状态100的单子 5b74db05ce6d2a63b4ac77e2 状态10的单子
    
//    [BossOaExamineRequest OaExamineRequestGetExamineDetailWithExamineId:@"5b8266c9421aa92abb5b91a9" successBlock:^(ExamineOrderModel *examineFlowList) {
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
