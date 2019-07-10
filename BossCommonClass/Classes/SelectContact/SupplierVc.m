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
#import "ContactListVc.h"
#import "BossBasicDefine.h"

@interface SupplierVc ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *customTableView;

@property (nonatomic, strong) NSMutableArray *typeArr;
// 是否编辑
@property (nonatomic, assign)BOOL isEdit;

@property (weak, nonatomic) IBOutlet UIButton *subTitleButton;

@property (weak, nonatomic) IBOutlet UIButton *allSelectButton;

// 是否全选
// 0 取消全选 1 全选 2 部分选
@property (nonatomic, assign)int type;

@property (nonatomic, strong)UIButton *finishButton;
@end

@implementation SupplierVc

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    // 获取
    BizDistrictTeamPlatformModel *F_Model = self.allContentArr[self.index];
    if (self.contentArr.count == 0){
        
        if (F_Model.businessExtraField.platformName) {
            
            [self.subTitleButton setTitle:F_Model.businessExtraField.platformName forState:UIControlStateNormal];
            
            self.title = F_Model.businessExtraField.platformName;
            
            if (self.fatherType == 1 || self.fatherType == 0) {
                // 1
                for (BizDistrictTeamPlatformModel *supplierModel in F_Model.PlatformArr) {
                    supplierModel.type = self.fatherType;
                }
            }
            self.type = self.fatherType;
            self.contentArr = F_Model.PlatformArr;
        } else {
            // 趣活内部员工
            [self.subTitleButton setTitle:F_Model.name forState:UIControlStateNormal];
            self.title = F_Model.name;
            if (self.fatherType == 1 || self.fatherType == 0) {
                // 1
                for (BizDistrictTeamPlatformModel *supplierModel in self.roleTeamdata) {
                    supplierModel.type = self.fatherType;
                }
            }
            self.contentArr = self.roleTeamdata;
        }
    }
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
            if (S_Model.type == 1 || S_Model.type == 2) {
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
    }
    if ([typeArr containsObject:@(1)] || [typeArr containsObject:@(2)]) {
        return YES;
    } else {
        return NO;
    }
}

- (void)finishAction{
    BizDistrictTeamPlatformModel *F_Model = self.allContentArr[self.index];
    F_Model.type = [self getType:self.contentArr];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"selectArrNotification" object:self.allContentArr];
}

-(void)setUI{
    self.customTableView.estimatedRowHeight = 100;
    self.customTableView.rowHeight = UITableViewAutomaticDimension;
    self.typeArr = [NSMutableArray array];
    
    self.type = [self getType: self.contentArr];
    
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
    
    
//    self.contentArr = supplierModel.PlatformArr;
}
// 是否全选
- (void)setType:(int)type{
    if (type == 1) {
        [self.allSelectButton setTitle:@"取消全选" forState:UIControlStateNormal];
    } else {
        [self.allSelectButton setTitle:@"全选" forState:UIControlStateNormal];
    }
    _type = type;
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
-(void)popToLastViewController:(UIBarButtonItem *)sender{
    
    if (self.selectStatus_type) {
        self.selectStatus_type(self.index, [self getType: self.contentArr]);
    }
    
    [self.navigationController popViewControllerAnimated:true];
    
}
// 获取类型
- (int)getType:(NSArray *)contentArr{
    
    [self.typeArr removeAllObjects];
    
    for (BizDistrictTeamPlatformModel *teamListModel  in contentArr){
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
    BizDistrictTeamPlatformModel *F_Model = self.allContentArr[self.index];
    F_Model.type = [self getType:self.contentArr];
    
    if (self.selectStatus_type) {
        self.selectStatus_type(self.index, [self getType:self.contentArr]);
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.contentArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SelectContactCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
//    BizDistrictTeamPlatformModel *supplierModel = self.allContentArr[self.index];
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
        self.type = [self getType: self.contentArr];
        self.isEdit = [self completeButtonStatus];
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
    BizDistrictTeamPlatformModel *supplierModel = self.allContentArr[self.index];
    BizDistrictTeamPlatformModel *teamListModel = supplierModel.PlatformArr[indexPath.row];
    
    if (teamListModel.businessExtraField.supplierName){
        CityVc * supplier = [CityVc storyBoardCreateViewControllerWithBundle:@"BossCommonClass" StoryBoardName:@"EntrustAccountRegistration"];
//        supplier.contentArr = teamListModel.supplierArr;
        
        supplier.title = teamListModel.businessExtraField.supplierName;
        // 平台Index
        supplier.SupplierIndex = self.index;
        // 团队Index
        supplier.index = indexPath.row;
        
        supplier.fatherType = teamListModel.type;
        supplier.supplierTitle = self.title;
        supplier.allContentArr = self.allContentArr;
        
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
