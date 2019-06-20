//
//  CityVc.m
//  BossCommonClass
//
//  Created by 高炀辉 on 2019/6/17.
//

#import "CityVc.h"
#import "NNBBasicRequest.h"
#import "BossMethodDefine.h"
#import "BossCache.h"
#import "BaseTeamListModel.h"
#import "SelectContactCell.h"
#import "BizDistrictTeam.h"
#import "TeamListVc.h"
#import "UIViewController+StoryBoard.h"
#import "BizDistrictTeamPlatformModel.h"
#import "NSMutableArray+SelectType.h"
#import "SelectContactVc.h"
#import "BossBasicDefine.h"

@interface CityVc ()<UITableViewDelegate,UITableViewDataSource>
// 平台名


@property (weak, nonatomic) IBOutlet UITableView *customTableView;

@property (nonatomic, strong) NSMutableArray *typeArr;
// 是否编辑
@property (nonatomic, assign)BOOL isEdit;

@property (weak, nonatomic) IBOutlet UIButton *allSelectButton;
// 城市
@property (weak, nonatomic) IBOutlet UIButton *cityTitleButton;

@property (nonatomic, strong)UIButton *finishButton;
// 是否全选
// 0 全不选 1 全选 2 部分选
@property (nonatomic, assign)int type;
@end

@implementation CityVc

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
    self.type = [self getType: self.contentArr];
}

- (IBAction)backtoSelectContactVc:(UIButton *)sender {
    
    if (self.selectStatus_type) {
        self.selectStatus_type(self.index, [self getType: self.contentArr]);
    }
    
    for (UIViewController *vc in self.navigationController.viewControllers){

        if ([NSStringFromClass([vc class]) isEqualToString:@"SelectContactVc"]){
            [self.navigationController popToViewController:vc animated:true];
            return;
        }
    }
}
- (IBAction)backSupplierVc:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:true];
}
- (void)finishAction{
    BizDistrictTeamPlatformModel *F_Model = self.allContentArr[self.SupplierIndex];
    BizDistrictTeamPlatformModel *S_Model = F_Model.PlatformArr[self.index];
    S_Model.type = [self getType: self.contentArr];
    F_Model.type = [self getType: F_Model.PlatformArr];
[[NSNotificationCenter defaultCenter] postNotificationName:@"selectArrNotification" object:self.allContentArr];
}
// 是否全选
- (void)setType:(int)type{
    if (type == 1) {
        [self.allSelectButton setTitle:@"全不选" forState:UIControlStateNormal];
    } else {
        [self.allSelectButton setTitle:@"全选" forState:UIControlStateNormal];
    }
    _type = type;
}
- (IBAction)allSelect:(UIButton *)sender {
    if (self.type == 0 || self.type == 2) {
        self.type = 1;
        for (BizDistrictTeamPlatformModel *teamListModel in self.contentArr) {
            teamListModel.type = 1;
        }
    } else {
        self.type = 0;
        for (BizDistrictTeamPlatformModel *teamListModel in self.contentArr) {
            teamListModel.type = 0;
        }
    }
    [self.customTableView reloadData];
}
-(void)setUI{
    self.customTableView.estimatedRowHeight = 100;
    self.customTableView.rowHeight = UITableViewAutomaticDimension;
    self.typeArr = [NSMutableArray array];
    
    
    self.finishButton = [UIButton buttonWithType:UIButtonTypeCustom];
    //    self.finishButton.userInteractionEnabled = false;
    self.finishButton.frame = CGRectMake(0, 0, 60, 35);
    self.finishButton.layer.cornerRadius = 4;
    self.finishButton.layer.masksToBounds = true;
    [self.finishButton setTitle:@"完成" forState:UIControlStateNormal];
    self.finishButton.backgroundColor = kHexRGB(0x34A9FF);
    [self.finishButton addTarget:self action:@selector(finishAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.finishButton];
    
}
-(void)popToLastViewController:(UIBarButtonItem *)sender{
    
    if (self.selectStatus_type) {
        self.selectStatus_type(self.index, [self getType:self.contentArr]);
    }
    [self.navigationController popViewControllerAnimated:true];
}
- (void)willMoveToParentViewController:(UIViewController*)parent{
    if (self.selectStatus_type) {
        self.selectStatus_type(self.index, [self getType: self.contentArr]);
    }
}
- (void)didMoveToParentViewController:(UIViewController*)parent{
    
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    BizDistrictTeamPlatformModel *F_Model = self.allContentArr[self.SupplierIndex];
    // 设置标题
    [self.supplierTitleButton setTitle:F_Model.businessExtraField.platformName forState:UIControlStateNormal];
    
    [self.cityTitleButton setTitle:F_Model.businessExtraField.supplierName forState:UIControlStateNormal];
    
    self.title = F_Model.businessExtraField.supplierName;
    // 获取城市
    BizDistrictTeamPlatformModel *S_Model = F_Model.PlatformArr[self.index];
    
    if (self.contentArr.count == 0){

        if (self.fatherType == 1 || self.fatherType == 0) {
            // 1
            for (BizDistrictTeamPlatformModel *supplierModel in S_Model.supplierArr) {
                supplierModel.type = self.fatherType;
            }
        }

        self.contentArr = S_Model.supplierArr;
    }
}
// 监听编辑状态
-(void)setIsEdit:(BOOL)isEdit{
    // 是编辑状态 显示 完成&全选
    if (isEdit) {
        
    } else {
        // 不是 隐藏 完成 & 全选 & 编辑 状态
    }
}
-(int)getType:(NSArray *)contentArr{
    
    [self.typeArr removeAllObjects];
    
    for (BizDistrictTeamPlatformModel *teamListModel in contentArr){
        [self.typeArr addObject:[NSNumber numberWithInteger:teamListModel.type]];
    }
    if (([self.typeArr containsObject:[NSNumber numberWithInteger:0]] && [self.typeArr containsObject:[NSNumber numberWithInteger:1]]) || [self.typeArr containsObject:[NSNumber numberWithInteger:2]] ){
        return 2;
        
    }  else if (![self.typeArr containsObject:[NSNumber numberWithInteger:1]]) {
        return 0;
        
    } else if (![self.typeArr containsObject:[NSNumber numberWithInteger:0]]){
        return 1;
    }
    return 0;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.contentArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SelectContactCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    BizDistrictTeamPlatformModel *teamListModel = self.contentArr[indexPath.row];
    cell.model = teamListModel;
    cell.selectBlock = ^{
        if (teamListModel.type == 0) {
            teamListModel.type = 1;
        } else if (teamListModel.type == 1) {
            teamListModel.type = 0;
        } else if (teamListModel.type == 2){
            teamListModel.type = 1;
        } else {
            teamListModel.type = 1;
        }
        self.type = [self getType :self.contentArr];
        [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    };
    cell.titleLabel.text = teamListModel.businessExtraField.cityName;
    return cell;
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if (touch.view != self.customTableView) {
        return NO;
    }else {
        return YES;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    BizDistrictTeamPlatformModel *teamListModel = self.contentArr[indexPath.row];
    TeamListVc * supplier = [TeamListVc storyBoardCreateViewControllerWithBundle:@"BossCommonClass" StoryBoardName:@"EntrustAccountRegistration"];
    
    for (BizDistrictTeamPlatformModel *PlatformModel in teamListModel.cityArr){
        if (teamListModel.type == 1) {
            PlatformModel.type = 1;
        }
        if (teamListModel.type == 0) {
            PlatformModel.type = 0;
        }
    }
//    supplier.contentArr = teamListModel.cityArr;
    supplier.index = indexPath.row;
    supplier.supplierTitle = self.title;
    supplier.platformTitle = self.supplierTitle;
    supplier.allContentArr = self.allContentArr;
    supplier.SupplierIndex = self.SupplierIndex;
    supplier.cityIndex = self.index;
    supplier.title = teamListModel.businessExtraField.cityName;
    supplier.selectStatus_type = ^(NSInteger index, int type) {
        BizDistrictTeamPlatformModel *teamListModel = self.contentArr[index];
        teamListModel.type = type;
        self.type = type;
        [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    };
    [self.navigationController pushViewController:supplier animated:true];
    
}
@end
