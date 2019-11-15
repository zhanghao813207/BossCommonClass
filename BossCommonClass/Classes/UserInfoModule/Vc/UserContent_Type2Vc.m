//
//  UserContent_Type2Vc.m
//  BossKnight
//
//  Created by 高炀辉 on 2019/7/17.
//  Copyright © 2019 贾远潮. All rights reserved.
//

#import "UserContent_Type2Vc.h"
#import "userContent_Type2HeaderCell.h"
#import "Usercontent_Type2Cell.h"
#import "BossOwnerAccount.h"
#import "HealthCardVc.h"
#import "BankCardVc.h"
#import "UIViewController+StoryBoard.h"
#import "BankCardInfoViewController.h"
#import "MyInfoViewController.h"
#import "IdCardTipVc.h"
#import "IDCardAIVc.h"
#import "BankCardRegistCompleteVc.h"
#import "workerDocumentVc.h"
#import "RegistComplete_Setup2Vc.h"
#import "UserInfoFixVc.h"
#import "NNBBasicRequest.h"
#import "findLatestModel.h"

@interface UserContent_Type2Vc ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong) NSArray *tableArr;
@property (weak, nonatomic) IBOutlet UITableView *usercontentTableView;
@property (weak, nonatomic) IBOutlet UILabel *currentTaskLabel;

@property(nonatomic, assign) IdentityType identityType;

@property(nonatomic, strong) findLatestModel *taskModel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *stateLabelHeight;

// 是否显示右边箭头 根据当前状态判断
@property (weak, nonatomic) IBOutlet UIImageView *isClickedIconImageView;
//
@property (weak, nonatomic) IBOutlet UIView *taskStateView;

@end

@implementation UserContent_Type2Vc
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self getCurrentState];
    // 第0个是header站位
    self.identityType = kCurrentBossOwnerAccount.accountModel.idcardType;
    if (self.identityType == IdentityTypeNormal){
        self.tableArr = @[
                             @{@"name": @"身份证信息", @"content": @(kCurrentBossOwnerAccount.accountModel.identityStatus) },
                             @{@"name": @"银行卡信息",@"content": @(kCurrentBossOwnerAccount.accountModel.bankCardStatus)},
                             // 健康证
#ifdef kBossKnight
                             @{@"name": @"工作证件",@"content": [NSNumber numberWithBool:kCurrentBossOwnerAccount.accountModel.workCardIsDone]}
#endif
                             ];
    }else{
        self.tableArr = @[
                             @{@"name": @"身份证信息(临时)", @"content": @(kCurrentBossOwnerAccount.accountModel.identityStatus) },
                             @{@"name": @"银行卡信息",@"content": @(kCurrentBossOwnerAccount.accountModel.bankCardStatus)},
                             // 健康证
#ifdef kBossKnight
                             @{@"name": @"工作证件",@"content": [NSNumber numberWithBool:kCurrentBossOwnerAccount.accountModel.workCardIsDone]}
#endif
                             ];
    }
   
    [self.usercontentTableView reloadData];
}
- (void)viewDidLoad {
    [super viewDidLoad];

    [self setUI];
    
}
- (void)setUI{
    self.title = @"个人信息";
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tableArr.count + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        userContent_Type2HeaderCell * cell = [tableView dequeueReusableCellWithIdentifier:@"header" forIndexPath:indexPath];
        return cell;
    } else {
        Usercontent_Type2Cell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        NSDictionary *dic = self.tableArr[indexPath.row - 1];
        cell.nameLabel.text = dic[@"name"];
        NSNumber *numStatue = dic[@"content"];
        if(indexPath.row == 1 || indexPath.row == 2)
        {
            if(numStatue.intValue != 3 )
            {
                cell.contentLabel.textColor = kHexRGBA(0x29314D, 0.2);
                cell.contentLabel.text = @"未完善";
            }else
            {
                cell.contentLabel.text = @"已完善";
                cell.contentLabel.textColor = kHexRGB(0x59DB6F);
            }
        }else
        {
            if(numStatue.boolValue == YES )
            {
                cell.contentLabel.text = @"已完善";
                cell.contentLabel.textColor = kHexRGB(0x59DB6F);
            }else
            {
                cell.contentLabel.textColor = kHexRGBA(0x29314D, 0.2);
                cell.contentLabel.text = @"未完善";
            }
        }
        
        return cell;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row != 0)
    {
        NSDictionary *dic = self.tableArr[indexPath.row - 1];
        NSString *name = dic[@"name"];
        NSNumber *numbStatue = dic[@"content"];
        if ([name containsString:@"身份证信息"])
        {
            if (self.taskStateView.hidden) {
                if ([numbStatue intValue] == IdentityStatusFew)
                {
                    //正反面照片任一面缺少,未完善 -- 实名认证流程
                    IdCardTipVc *vc = [IdCardTipVc storyBoardCreateViewControllerWithBundle:@"BossOwnerLogin" StoryBoardName:@"BossOwnerLogin"];
                    vc.notShowSuccess = YES;
                    vc.isUploadUserContent = YES;
                    [self.navigationController pushViewController:vc animated:true];
                    
                }else if ([numbStatue intValue] == IdentityStatusMissSome)
                {
                    //只缺手持证件照,未完善 -- 上传手持照片
                    IDCardAIVc * VC = (IDCardAIVc*)[IDCardAIVc storyBoardCreateViewControllerWithBundle:@"BossOwnerLogin" StoryBoardName:@"BossOwnerLogin"];
                    VC.isUploadUserContent = TRUE;
                    VC.notShowSuccess = YES;
                    [self.navigationController pushViewController:VC animated: true];
                }else
                {
                    //身份信息完善
                    MyInfoViewController *archivesVC = [[MyInfoViewController alloc] initWithNibName:@"MyInfoViewController" bundle:[self getCurrentBundle]];
                    archivesVC.canUpdateTempID = YES;
                    [self.navigationController pushViewController:archivesVC animated:true];
                    
                }
            } else {
                UserInfoFixVc * vc = [UserInfoFixVc storyBoardCreateViewControllerWithBundle:@"BossCommonClass" StoryBoardName:@"BossCommonClass"];
                vc.fixType = self.taskModel.type;
                vc.taskID = self.taskModel.idField;
                vc.fixState = self.taskModel.state;
                [self.navigationController pushViewController:vc animated:true];
            }
            
        }else if ([name isEqualToString:@"银行卡信息"])
        {
            if ([numbStatue intValue] == BankCardStatusNOCardId)
            {
                //缺少银行卡号,未完善 -- 跳转银行卡提示页
                RegistComplete_Setup2Vc *vc = [RegistComplete_Setup2Vc storyBoardCreateViewControllerWithBundle:@"BossOwnerLogin" StoryBoardName:@"BossOwnerLogin"];
                vc.notShowJump = YES;
                [self.navigationController pushViewController:vc animated:true];
                
            }else if ([numbStatue intValue] == BankCardStatusNOSome)
            {
                //缺少除银行卡号之外的其他字段,未完善
                BankCardRegistCompleteVc *vc = [BankCardRegistCompleteVc storyBoardCreateViewControllerWithBundle:@"BossOwnerLogin" StoryBoardName:@"BossOwnerLogin"];
                vc.isedit = YES;
                vc.notShowSuccess = YES;
                vc.bankCardId = kCurrentBossOwnerAccount.accountModel.bankCardId;
                vc.bankName = kCurrentBossOwnerAccount.accountModel.bankName;
                NSData *data = [NSData dataWithContentsOfURL:[NSURL  URLWithString:kCurrentBossOwnerAccount.accountModel.bankCardFrontUrl]];
                vc.bankCardImage = [UIImage imageWithData:data];
                [self.navigationController pushViewController:vc animated:true];

            }else
            {
                //银行卡信息完善
                BankCardInfoViewController *archivesVC = [[BankCardInfoViewController alloc] initWithNibName:@"BankCardInfoViewController" bundle:[self getCurrentBundle]];
                archivesVC.canChangeCard = YES;
                [self.navigationController pushViewController:archivesVC animated:true];
                
            }
        }else if ([name isEqualToString:@"工作证件"])
        {
            workerDocumentVc *vc = [workerDocumentVc storyBoardCreateViewControllerWithBundle:@"BossOwnerLogin" StoryBoardName:@"BossOwnerLogin"];
            vc.isFromCenterInfo = YES;
            [self.navigationController pushViewController:vc animated:true];
        }
    }
 
}
- (NSBundle *)getCurrentBundle {
    NSBundle *baseBundle = [NSBundle bundleForClass:[self class]];
    
    NSURL *bundleUrl = [baseBundle URLForResource:@"BossWorkFileModule" withExtension:@"bundle"];
    if(!bundleUrl){
        
        [self.navigationController.view showStatus:@"文件路径有误!"];
    }
    NSBundle *bundle = [NSBundle bundleWithURL:bundleUrl];
    
    return bundle;
}
- (void)getCurrentState{
    if (kCurrentBossOwnerAccount.accountModel.accountId) {
        NSDictionary *dic = @{
//            @"state": @[@(normalState),@(auditState),@(rejectedState)],
            @"account_id": kCurrentBossOwnerAccount.accountModel.accountId
        };
        
        [NNBBasicRequest postJsonWithUrl:kUrl parameters: dic CMD:@"account.idcard_change.find_latest" success:^(id responseObject) {
            // TODO: 处理返回结果
            NSDictionary *dic = responseObject;
            
            if (dic.count <= 0) {
                // 当前没有可执行任务
                self.taskStateView.hidden = true;
                self.stateLabelHeight.constant = 0;
            } else {
                // 任务正在执行
                self.taskModel = [[findLatestModel alloc] initWithDictionary:dic];
                self.taskStateView.hidden = false;
                self.stateLabelHeight.constant = 44;
                self.currentTaskLabel.text = self.taskModel.currentState;
                
                if (self.taskModel.updatestate == normalState || self.taskModel.updatestate == rejectedState || self.taskModel.updatestate == throughState){
                    self.taskStateView.backgroundColor = kHexRGB(0xFFF6E8);
                    self.currentTaskLabel.textColor = kHexRGB(0xDB8800);
                    self.isClickedIconImageView.hidden = false;
                } else if (self.taskModel.updatestate == auditState){
                    self.taskStateView.backgroundColor = kHexRGB(0xF6F6F6);
                    self.currentTaskLabel.textColor = kHexRGB(0xBFBFBF);
                    self.isClickedIconImageView.hidden = true;
                }
                
            }
        } fail:^(id error) {
            NSLog(@"%@", error);
        }];
    }
    
}
- (IBAction)fixUserInfoTipClicked:(id)sender {
    UserInfoFixVc * vc = [UserInfoFixVc storyBoardCreateViewControllerWithBundle:@"BossCommonClass" StoryBoardName:@"BossCommonClass"];
    vc.fixState = self.taskModel.state;
    vc.fixType = self.taskModel.type;
    vc.taskID = self.taskModel.idField;
    [self.navigationController pushViewController:vc animated:true];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if (touch.view != self.usercontentTableView) {
        return NO;
    }else {
        return YES;
    }
}





@end
