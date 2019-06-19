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
#import "ContactListVc.h"

@interface SupplierVc ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *customTableView;

@property (nonatomic, strong) NSMutableArray *typeArr;
// 是否编辑
@property (nonatomic, assign)BOOL isEdit;

@property (weak, nonatomic) IBOutlet UIButton *subTitleButton;

@property (weak, nonatomic) IBOutlet UIButton *allSelectButton;
// 是否全选
// 0 全不选 1 全选 2 部分选
@property (nonatomic, assign)int type;
@end

@implementation SupplierVc

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}
-(void)setUI{
    self.customTableView.estimatedRowHeight = 100;
    self.customTableView.rowHeight = UITableViewAutomaticDimension;
    self.typeArr = [NSMutableArray array];
    [self.subTitleButton setTitle:self.title forState:UIControlStateNormal];
    self.type = [self getType];
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
// 返回
- (IBAction)backpVc:(UIButton *)sender {
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

// 监听编辑状态
-(void)setIsEdit:(BOOL)isEdit{
    // 是编辑状态 显示 完成&全选
    if (isEdit) {
        
    } else {
        // 不是 隐藏 完成 & 全选 & 编辑 状态
    }
}
-(void)popToLastViewController:(UIBarButtonItem *)sender{
    
    if (self.selectStatus_type) {
        self.selectStatus_type(self.index, [self getType]);
    }
    
}
// 获取类型
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
- (void)willMoveToParentViewController:(UIViewController*)parent{
    
    if (self.selectStatus_type) {
        self.selectStatus_type(self.index, [self getType]);
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.contentArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SelectContactCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    BizDistrictTeamPlatformModel *teamListModel = self.contentArr[indexPath.row];
    cell.model = teamListModel;
    if (teamListModel.businessExtraField.supplierName) {
        cell.titleLabel.text = teamListModel.businessExtraField.supplierName;
    } else {
        cell.titleLabel.text = teamListModel.name;
    }
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

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if (touch.view != self.customTableView) {
        return NO;
    }else {
        return YES;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (![self.platformType isEqualToString:@"趣活内部"]){
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
        
        supplier.title = teamListModel.businessExtraField.supplierName;
        supplier.index = indexPath.row;
        supplier.supplierTitle = self.title;
        supplier.selectStatus_type = ^(NSInteger index, int type) {
            BizDistrictTeamPlatformModel *teamListModel = self.contentArr[index];
            teamListModel.type = type;
            self.type = type;
            [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        };
        
        [self.navigationController pushViewController:supplier animated:true];
    } else {
        BizDistrictTeamPlatformModel *teamListModel = self.contentArr[indexPath.row];
        ContactListVc *vc = [ContactListVc storyBoardCreateViewControllerWithBundle:@"BossCommonClass" StoryBoardName:@"EntrustAccountRegistration"];
        vc.group_id = teamListModel.idField;
        vc.title = teamListModel.name;
        [self.navigationController pushViewController:vc animated:true];
    }
    
}
@end
