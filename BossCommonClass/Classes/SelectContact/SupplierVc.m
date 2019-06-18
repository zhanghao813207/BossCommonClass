//
//  SupplierVc.m
//  BossCommonClass
//
//  Created by 高炀辉 on 2019/6/17.
//

#import "SupplierVc.h"
#import "NNBBasicRequest.h"
#import "BossMethodDefine.h"
#import "BossCache.h"
#import "BaseTeamListModel.h"
#import "SelectContactCell.h"
#import "BizDistrictTeam.h"
#import "CityVc.h"
#import "UIViewController+StoryBoard.h"
#import "BizDistrictTeamPlatformModel.h"

@interface SupplierVc ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *customTableView;

@property (nonatomic, strong) NSMutableArray *typeArr;
// 是否编辑
@property (nonatomic, assign)BOOL isEdit;
@end

@implementation SupplierVc

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
    
}
-(void)setUI{
    self.customTableView.estimatedRowHeight = 100;
    self.customTableView.rowHeight = UITableViewAutomaticDimension;
    self.typeArr = [NSMutableArray array];
}

// 监听编辑状态
-(void)setIsEdit:(BOOL)isEdit{
    // 是编辑状态 显示 完成&全选
    if (isEdit) {
        
    } else {
        // 不是 隐藏 完成 & 全选 & 编辑 状态
    }
}
-(void)popToLastViewController:(UIBarButtonItem *)sender{
    
    [self.typeArr removeAllObjects];
    
    for (BizDistrictTeamPlatformModel *teamListModel  in self.contentArr){
        [self.typeArr addObject:[NSNumber numberWithInteger:teamListModel.type]];
    }
    if (([self.typeArr containsObject:[NSNumber numberWithInteger:0]] && [self.typeArr containsObject:[NSNumber numberWithInteger:1]]) || [self.typeArr containsObject:[NSNumber numberWithInteger:2]] ){
        // 包含 1 并且包含 0
        if (self.selectStatus_type) {
            self.selectStatus_type(self.index, 2);
        }
        
    }  else if (![self.typeArr containsObject:[NSNumber numberWithInteger:1]]) {
        if (self.selectStatus_type) {
            self.selectStatus_type(self.index, 0);
        }
    } else if (![self.typeArr containsObject:[NSNumber numberWithInteger:0]]){
        if (self.selectStatus_type) {
            self.selectStatus_type(self.index, 1);
        }
    }
}
- (void)willMoveToParentViewController:(UIViewController*)parent{
    
    [self.typeArr removeAllObjects];
    
    for (BizDistrictTeamPlatformModel *teamListModel  in self.contentArr){
        [self.typeArr addObject:[NSNumber numberWithInteger:teamListModel.type]];
    }
    if (([self.typeArr containsObject:[NSNumber numberWithInteger:0]] && [self.typeArr containsObject:[NSNumber numberWithInteger:1]]) || [self.typeArr containsObject:[NSNumber numberWithInteger:2]] ){
        // 包含 1 并且包含 0
        if (self.selectStatus_type) {
            self.selectStatus_type(self.index, 2);
        }
        
    }  else if (![self.typeArr containsObject:[NSNumber numberWithInteger:1]]) {
        if (self.selectStatus_type) {
            self.selectStatus_type(self.index, 0);
        }
    } else if (![self.typeArr containsObject:[NSNumber numberWithInteger:0]]){
        if (self.selectStatus_type) {
            self.selectStatus_type(self.index, 1);
        }
    }
}
//- (void)didMoveToParentViewController:(UIViewController*)parent

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.contentArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SelectContactCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    BizDistrictTeamPlatformModel *teamListModel = self.contentArr[indexPath.row];
    cell.model = teamListModel;
    cell.titleLabel.text = teamListModel.businessExtraField.supplierName;
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
        [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    };
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
    
    for (BizDistrictTeamPlatformModel *PlatformModel in teamListModel.supplierArr){
        if (teamListModel.type == 1) {
            PlatformModel.type = 1;
        }
        if (teamListModel.type == 0) {
            PlatformModel.type = 0;
        }
    }
    
    CityVc * supplier = [CityVc storyBoardCreateViewControllerWithBundle:@"BossCommonClass" StoryBoardName:@"EntrustAccountRegistration"];
    supplier.contentArr = teamListModel.supplierArr;
    supplier.index = indexPath.row;
    supplier.selectStatus_type = ^(NSInteger index, int type) {
        BizDistrictTeamPlatformModel *teamListModel = self.contentArr[index];
        teamListModel.type = type;
        [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    };
    
    [self.navigationController pushViewController:supplier animated:true];
}
@end
