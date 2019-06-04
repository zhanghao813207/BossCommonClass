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
#import "BossPresentVc.h"
#import "BossDismissTranstion.h"
#import "BossPayrollRequest.h"
#import "NNBUtilRequest.h"
#import "NNBAuthRequest.h"
#import "BossManagerAccount.h"
#import "MyRecommendationVC.h"
#import "RecommendedVC.h"
#import "AnnouncementVC.h"

@interface ViewController ()<UIViewControllerTransitioningDelegate>

@property(nonatomic,strong) BossDismissTranstion *bossDismissTranstion;

@end

@implementation ViewController

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.navigationController pushViewController:[AnnouncementVC new] animated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    [BossPayrollRequest payrollGetBizDistrictByCityList:@[@"beijing_elem"] success:^(NSArray * _Nonnull bizDistrictList) {
//
//    } fail:^(id  _Nonnull error) {
//
//    }];
    
    
//    [BossPayrollRequest payrollFindWithPlatform:@"elem" supplierId:@[@"ww"] city:@[@"beijing_elem"] workType:@[@(3001)] state:@[@(50)] success:^(NSArray * _Nonnull payrollStatementArray) {
//
//    } fail:^(id  _Nonnull error) {
//
//    }];
    
//    [BossPayrollRequest payrollFindPayrollWithPage:1 statementId:@"5bda72d735587a9665ed16f5" bizDistrictId:@"" name:@"" paySalaryState:PaySalaryStateNormal success:^(BOOL hasMore, NSArray * _Nonnull payroll_list) {
//
//    } fail:^(id  _Nonnull error) {
//
//    }];
    
//    [BossSalaryRuleRequest salaryRuleRequestGetSalaryPlaneDetailWithVersionId:@"5bdfbd2f5ac78482d13c76d6" success:^(SalaryPlaneModel * _Nonnull salaryPlaneModel) {
//
//    } fail:^(id  _Nonnull error) {
//
//    }];

//    [BossSalaryRuleRequest salaryRuleRequestFindSalaryRuleListWithRuleCollectionId:@"5bdfb85935587ae1d2855f86" salarRuleCollectionType:SalaryRuleCollectionTypeManage success:^(NSArray<ManageTemplateModel *> * _Nonnull templateList) {
//        DLog(@"%@",templateList);
//    } fail:^(id  _Nonnull error) {
//
//    }];
//    [BossSalaryRuleRequest salaryComputeFindSalaryComputeDataSetWithPage:1 taskID:@"5bdff5035ac7848c45778339" type:SalaryComputeTaskTypeStaff success:^(BOOL hasMore, NSArray<SalaryComputeDatasetModel *> * _Nonnull salaryComputeList) {
//
//    } fail:^(id  _Nonnull error) {
//
//    }];
//    [BossSalaryRuleRequest salaryRequestFindSalaryVarListWithPlatformCode:@"elem" success:^(NSArray<IndexInfoModel *> * _Nonnull indexList) {
//
//    } fail:^(id  _Nonnull error) {
//
//    }];
    
//
    [BossManagerAccount userIsLoginSuccess:^(BOOL isSuccess, BOOL isFirstLogin) {
        
    } withController:self];
    
//    [BossMessageRequest msgRequestGetBaChannelMessageWithPage:1 limit:30 success:^(NSArray<BossAssistantMessageModel *> *msgList) {
//
//    } fail:^(id error) {
//
//    }];
    
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
    
//    BorderView *view = [[BorderView alloc] initWithFrame:CGRectMake(100.3, 100, 20, 20)];
//    view.backgroundColor = kHexRGBA(0x000000, 0.1);
//    view.cornerRadius = 10.f;
//    view.borderWidth = 0.5f;
//    view.borderColor = [UIColor redColor];
//    view.rectCorner = BorderDirectionRight | BorderDirectionBottom;
//    [self.view addSubview:view];
//
//
//    [self performSelector:@selector(changeRect:) withObject:view afterDelay:10];
    
//    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
//    btn.frame = CGRectMake(0, 200, 200, 50);
//    btn.backgroundColor = [UIColor redColor];
//    [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
//    
////    NSString *bundlePath = [[NSBundle bundleForClass:[self class]].resourcePath stringByAppendingPathComponent:@"/BossCommonClass.bundle"];
//    NSLog(@"------ %@",bundlePath);
//    
//    NSBundle *bundle = [NSBundle bundleWithPath:bundlePath];
//    
//    UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 100, 50, 50)];
//    UIImage *image = [UIImage imageNamed:@"icon_new_1" inBundle:bundle  compatibleWithTraitCollection:nil];
//    iv.image = image;
//    [self.view addSubview:iv];
//    [self.view addSubview:btn];

}

- (void)btnAction:(UIButton *)sender
{
//    BossPresentVc *vc = [[BossPresentVc alloc] init];
//    vc.transitioningDelegate = self;
//    NSLog(@"self.navigationController = %@",self.navigationController);
//    self.bossDismissTranstion = [[BossDismissTranstion alloc] initWithPressentViewController:vc];
//    vc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
//    [self.navigationController presentViewController:vc animated:YES completion:nil];
    
    // 发送验证码
    // [self sendSmsWithChangePhone:NO];
    
    // 获取审批单列表
    [self findOrderList];
}

- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator
{
    return self.bossDismissTranstion.interactionInProgress ? self.bossDismissTranstion : nil;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 查询审批单列表
 */
- (void)findOrderList {
    MOBILE_EXAMINE_TYPES type = MOBILE_PUT_EXAMINE_ALL;
    NSInteger page = 1;
    [BossOaExamineRequest OaExamineRequestGetExamineListWithType:type page:page successBlock:^(BOOL hasMore, NSArray<ExamineOrderModel *> *examineFlowList) {
    } fail:^(id error) {
    }];
}

@end
