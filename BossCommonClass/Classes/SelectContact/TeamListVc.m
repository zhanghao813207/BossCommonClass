//
//  TeamListVc.m
//  BossCommonClass
//
//  Created by 高炀辉 on 2019/6/17.
//

#import "TeamListVc.h"
#import "NNBBasicRequest.h"
#import "BossMethodDefine.h"
#import "BossCache.h"
#import "BaseTeamListModel.h"
#import "SelectContactCell.h"
#import "BizDistrictTeam.h"
#import "CityVc.h"
#import "UIViewController+StoryBoard.h"
#import "BizDistrictTeamPlatformModel.h"
#import "ContactListVc.h"
#import "BossBasicDefine.h"

@interface TeamListVc ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *customTableView;

// 是否编辑
@property (nonatomic, assign)BOOL isEdit;

@property (nonatomic, strong) NSMutableArray *typeArr;

@property (weak, nonatomic) IBOutlet UIButton *allSelectButton;
// 城市
@property (weak, nonatomic) IBOutlet UIButton *cityTitleButton;

@property (weak, nonatomic) IBOutlet UIButton *subTitleButton;

@property (weak, nonatomic) IBOutlet UIButton *SelectContactButton;

@property (nonatomic, strong)UIButton *finishButton;
// 是否全选
// 0 取消全选 1 全选 2 部分选
@property (nonatomic, assign)int type;
@end

@implementation TeamListVc

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    BizDistrictTeamPlatformModel *F_Model = self.allContentArr[self.SupplierIndex];
    BizDistrictTeamPlatformModel *S_Model = F_Model.PlatformArr[self.cityIndex];
    BizDistrictTeamPlatformModel *C_Model = S_Model.supplierArr[self.index];
    self.contentArr = C_Model.cityArr;
    self.type = [self getType:self.contentArr];
    self.isEdit = [self completeButtonStatus];
}
-(BOOL)completeButtonStatus{
    NSMutableArray *typeArr = [[NSMutableArray alloc] init];
    for (BizDistrictTeamPlatformModel *F_Model in self.allContentArr){
        NSNumber *val = [NSNumber numberWithInteger:F_Model.type];
        [typeArr addObject: val];
        for (BizDistrictTeamPlatformModel *S_Model in F_Model.PlatformArr){
            NSNumber *val = [NSNumber numberWithInteger:S_Model.type];
            [typeArr addObject: val];
            for (BizDistrictTeamPlatformModel *C_Model in S_Model.supplierArr){
                NSNumber *val = [NSNumber numberWithInteger:C_Model.type];
                [typeArr addObject: val];
                for (BizDistrictTeamPlatformModel *D_Model in C_Model.cityArr){
                    NSNumber *val = [NSNumber numberWithInteger:D_Model.type];
                    [typeArr addObject: val];
                }
            }
        }
    }
    if ([typeArr containsObject:@(1)] || [typeArr containsObject:@(2)]) {
        return YES;
    } else {
        return NO;
    }
}
-(void)setUI{
    self.customTableView.estimatedRowHeight = 100;
    self.customTableView.rowHeight = UITableViewAutomaticDimension;
    self.typeArr = [NSMutableArray array];
    self.type = [self getType: self.contentArr];
    // 平台
    [self.SelectContactButton setTitle:self.platformTitle forState:UIControlStateNormal];
    // 团队
    [self.subTitleButton setTitle:self.supplierTitle forState:UIControlStateNormal];
    // 城市
    [self.cityTitleButton setTitle:self.title forState:UIControlStateNormal];
    
    self.finishButton = [UIButton buttonWithType:UIButtonTypeCustom];
    //    self.finishButton.userInteractionEnabled = false;
    self.finishButton.frame = CGRectMake(0, 0, 60, 35);
    self.finishButton.layer.cornerRadius = 4;
    self.finishButton.layer.masksToBounds = true;
    [self.finishButton setTitle:@"完成" forState:UIControlStateNormal];
    self.finishButton.alpha = 0.4;
    [self.finishButton setEnabled:false];
    self.finishButton.backgroundColor = kHexRGB(0x34A9FF);
    [self.finishButton addTarget:self action:@selector(finishAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.finishButton];
}
- (void)finishAction{
    
    // 设置所有关联状态
    [self setTypeOfTeamList];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"selectArrNotification" object:self.allContentArr];
}
// 设置所有关联状态
- (void)setTypeOfTeamList{
    
    BizDistrictTeamPlatformModel *F_Model = self.allContentArr[self.SupplierIndex];
    BizDistrictTeamPlatformModel *S_Model = F_Model.PlatformArr[self.cityIndex];
    BizDistrictTeamPlatformModel *C_Model = S_Model.supplierArr[self.index];
    
    C_Model.type = [self getType: self.contentArr];
    S_Model.type = [self getType: S_Model.supplierArr];
    F_Model.type = [self getType: F_Model.PlatformArr];
    
}
// 返回平台
- (IBAction)backtoSelectContactVc:(UIButton *)sender {
    if (self.selectStatus_type) {
        self.selectStatus_type(self.index, [self getType: self.contentArr]);
    }
    
    for (UIViewController *vc in self.navigationController.viewControllers){
        
        if ([NSStringFromClass([vc class]) isEqualToString:@"SupplierVc"]){
            [self.navigationController popToViewController:vc animated:true];
            return;
        }
    }
}
- (IBAction)backtoSupplierVc:(UIButton *)sender {
    
    if (self.selectStatus_type) {
        self.selectStatus_type(self.index, [self getType: self.contentArr]);
    }
    
    for (UIViewController *vc in self.navigationController.viewControllers){
        
        if ([NSStringFromClass([vc class]) isEqualToString:@"SupplierVc"]){
            [self.navigationController popToViewController:vc animated:true];
            return;
        }
    }
}
- (IBAction)backCityVc:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:true];
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

// 是否全选
- (void)setType:(int)type{
    if (type == 1) {
//        self.isEdit = true;
        
        [self.allSelectButton setTitle:@"取消全选" forState:UIControlStateNormal];
    } else {
//        self.isEdit = false;
//        self.isEdit = [self completeButtonStatus];
        [self.allSelectButton setTitle:@"全选" forState:UIControlStateNormal];
    }
    self.isEdit = [self completeButtonStatus];
    _type = type;
}
- (int)getType:(NSArray *)contentArr{
    [self.typeArr removeAllObjects];
    
    for (BizDistrictTeamPlatformModel *teamListModel  in contentArr){
        [self.typeArr addObject:[NSNumber numberWithInteger:teamListModel.type]];
    }
    if (([self.typeArr containsObject:[NSNumber numberWithInteger:0]] && [self.typeArr containsObject:[NSNumber numberWithInteger:1]]) || [self.typeArr containsObject:[NSNumber numberWithInteger:2]] ){
//        self.isEdit = true;
        return 2;
        
    }  else if (![self.typeArr containsObject:[NSNumber numberWithInteger:1]]) {
//        self.isEdit = false;
        return 0;
        
    } else if (![self.typeArr containsObject:[NSNumber numberWithInteger:0]]){
//        self.isEdit = true;
        return 1;
    }
    return 0;
}
-(void)popToLastViewController:(UIBarButtonItem *)sender{
    if (self.selectStatus_type) {
        self.selectStatus_type(self.index, [self getType:self.contentArr]);
    }
    [self.navigationController popViewControllerAnimated:true];
}
- (void)willMoveToParentViewController:(UIViewController*)parent{
    if (self.selectStatus_type) {
        self.selectStatus_type(self.index, [self getType:self.contentArr]);
    }
}

- (void)didMoveToParentViewController:(UIViewController*)parent{
    
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if (touch.view != self.customTableView) {
        return NO;
    }else {
        return YES;
    }
}
// 监听编辑状态
-(void)setIsEdit:(BOOL)isEdit{
    // 是编辑状态 完成可点击
    if (isEdit) {
        // 不是 隐藏 完成 & 全选 & 编辑 状态
        self.finishButton.alpha = 1;
        [self.finishButton setEnabled:true];
        
    } else {
        self.finishButton.alpha = 0.4;
        [self.finishButton setEnabled:false];
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.contentArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SelectContactCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    BizDistrictTeamPlatformModel *teamListModel = self.contentArr[indexPath.row];
    cell.titleLabel.text = teamListModel.name;
    cell.model = teamListModel;
    cell.selectBlock = ^{
        if (teamListModel.type == 0) {
            teamListModel.type = 1;
        } else if (teamListModel.type == 1) {
            teamListModel.type = 0;
        }
        self.isEdit = [self completeButtonStatus];
        self.type = [self getType: self.contentArr];
        [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    };
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    BizDistrictTeamPlatformModel *teamListModel = self.contentArr[indexPath.row];
    ContactListVc *vc = [ContactListVc storyBoardCreateViewControllerWithBundle:@"BossCommonClass" StoryBoardName:@"EntrustAccountRegistration"];
    vc.group_id = teamListModel.idField;
    vc.title = teamListModel.name;
    [self.navigationController pushViewController:vc animated:true];
}
@end
