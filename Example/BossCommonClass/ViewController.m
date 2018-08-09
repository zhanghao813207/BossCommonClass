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
@interface ViewController ()

@property (nonatomic, strong) ApplyOrderModel *applyModel;


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
    
//    [BossOaExamineRequest OaExamineRequestGetExamineListWithType:MOBILE_WAIT_EXAMINE successBlock:^(NSArray<ExamineFlowModel *> *examineFlowList) {
//        
//    } fail:^(id error) {
//        
//    }];
    
//    5b6aa308636d0735fb4c2ea1
    
//    [BossOaExamineRequest OaExamineRequestGetExamineDetailWithExamineId:@"5b6aa308636d0735fb4c2ea1" successBlock:^(ExamineFlowModel *examineFlowList) {
//
//    } fail:^(id error) {
//
//    }];
    
//    5b6aa320636d0735fb4c2eb3
    
    [BossOaExamineRequest OaApplyOrderDetailWithOrderId:@"5b6aa320636d0735fb4c2eb3" successBlock:^(ApplyOrderModel *applyOrder) {
        self.applyModel = applyOrder;
        DLog(@"%@",applyOrder);
    } fail:^(id error) {
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
