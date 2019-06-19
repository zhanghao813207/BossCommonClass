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
// 是否全选
// 0 全不选 1 全选 2 部分选
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
}
-(void)setUI{
    self.customTableView.estimatedRowHeight = 100;
    self.customTableView.rowHeight = UITableViewAutomaticDimension;
    self.typeArr = [NSMutableArray array];
    self.type = [self getType];
    // 平台
    [self.SelectContactButton setTitle:self.platformTitle forState:UIControlStateNormal];
    // 团队
    [self.subTitleButton setTitle:self.supplierTitle forState:UIControlStateNormal];
    // 城市
    [self.cityTitleButton setTitle:self.title forState:UIControlStateNormal];
}
// 返回平台
- (IBAction)backtoSelectContactVc:(UIButton *)sender {
    if (self.selectStatus_type) {
        self.selectStatus_type(self.index, [self getType]);
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
        self.selectStatus_type(self.index, [self getType]);
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
        [self.allSelectButton setTitle:@"全不选" forState:UIControlStateNormal];
    } else {
        [self.allSelectButton setTitle:@"全选" forState:UIControlStateNormal];
    }
    _type = type;
}
- (int)getType{
    [self.typeArr removeAllObjects];
    
    for (BizDistrictTeamPlatformModel *teamListModel  in self.contentArr){
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
-(void)popToLastViewController:(UIBarButtonItem *)sender{
    if (self.selectStatus_type) {
        self.selectStatus_type(self.index, [self getType]);
    }
}
- (void)willMoveToParentViewController:(UIViewController*)parent{
    if (self.selectStatus_type) {
        self.selectStatus_type(self.index, [self getType]);
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
    // 是编辑状态 显示 完成&全选
    if (isEdit) {
        
    } else {
        // 不是 隐藏 完成 & 全选 & 编辑 状态
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
        } else if (teamListModel.type == 2){
            teamListModel.type = 1;
        } else {
            teamListModel.type = 1;
        }
        self.type = [self getType];
        [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    };
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

}
@end
