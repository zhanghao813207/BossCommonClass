//
//  SelectContactVc.m
//  BossCommonClass
//
//  Created by 高炀辉 on 2019/6/17.
//

#import "SelectContactVc.h"
#import "AnnouncementRequest.h"
#import "NNBBasicRequest.h"
#import "BossMethodDefine.h"
#import "BossCache.h"
#import "BaseTeamListModel.h"
#import "SelectContactCell.h"
#import "BizDistrictTeam.h"
#import "SupplierVc.h"
#import "UIViewController+StoryBoard.h"
#import "BizDistrictTeamPlatformModel.h"

@interface SelectContactVc ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *customTableView;

@property (nonatomic,strong) NSArray *contentArr;

//@property (nonatomic, assign) BOOL allSelect;
@property (weak, nonatomic) IBOutlet UIButton *allSelectButton;

@property (nonatomic, strong) NSMutableArray *typeArr;

// 是否编辑
@property (nonatomic, assign)BOOL isEdit;

// 是否全选
// 0 全不选 1 全选 2 部分选
@property (nonatomic, assign)int type;

// 是否包含内部联系人
// 0 不 1 是
@property (nonatomic, assign)int ContentType;

@property (nonatomic, strong)NSArray *roleTeamdata;

@end

@implementation SelectContactVc

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getList];
    [self setUI];
    
}

-(void)setUI{
    self.customTableView.estimatedRowHeight = 100;
    self.customTableView.rowHeight = UITableViewAutomaticDimension;
    self.isEdit = false;
    self.title = @"选择公告接收人";
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
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}
-(void)getList{
    if (self.wppId) {
        NSDictionary *para = @{
                               @"wpp_id":self.wppId,
                               @"_meta":@{
                                       @"limit":@(0)
                                       }
                               };
        [NNBBasicRequest postJsonWithUrl:kUrl  parameters: para CMD:@"message.address_book.find_wpp_address_book" success:^(id responseObject) {
            NSDictionary *dic = responseObject[@"data"];
            BaseTeamListModel *teamListModel = [[BaseTeamListModel alloc] initWithDictionary:dic];
            
            if (teamListModel.roleTeam.data.count > 0) {
                self.ContentType = 1;
                NSDictionary *dic = @{
                                      @"name": @"趣活内部员工",
                                      @"type": @(0),
                                      };
                self.roleTeamdata = teamListModel.roleTeam.data;
                BizDistrictTeamPlatformModel *teamChildModel =  [[BizDistrictTeamPlatformModel alloc] initWithDictionary:dic];
                [teamListModel.platformList insertObject:teamChildModel atIndex:0];
            } else {
                self.ContentType = 0;
            }
            self.contentArr = teamListModel.platformList;
            
            [self.customTableView reloadData];
        } fail:^(id error) {
            NSLog(@"%@",error);
        }];
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
    cell.model = teamListModel;
    if (self.ContentType == 1){
       cell.titleLabel.text = teamListModel.name;
    } else {
        cell.titleLabel.text = teamListModel.businessExtraField.platformName;
    }
    
    
    cell.selectBlock = ^() {
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
    
    BizDistrictTeamPlatformModel *teamListModel = self.contentArr[indexPath.row];
    
    SupplierVc * supplier = [SupplierVc storyBoardCreateViewControllerWithBundle:@"BossCommonClass" StoryBoardName:@"EntrustAccountRegistration"];
    for (BizDistrictTeamPlatformModel *PlatformModel in teamListModel.PlatformArr){
        if (teamListModel.type == 1) {
            PlatformModel.type = 1;
        }
        if (teamListModel.type == 0) {
            PlatformModel.type = 0;
        }
    }
    if (self.ContentType == 1 && indexPath.row == 0){
        
        for (BizDistrictTeamPlatformModel *PlatformModel in self.roleTeamdata){
            if (teamListModel.type == 1) {
                PlatformModel.type = 1;
            }
            if (teamListModel.type == 0) {
                PlatformModel.type = 0;
            }
        }
        supplier.platformType = @"趣活内部";
        supplier.contentArr = self.roleTeamdata;
    } else {
        supplier.platformType = @"";
        supplier.contentArr = teamListModel.PlatformArr;
    }
    
    supplier.index = indexPath.row;
    if (teamListModel.businessExtraField.platformName) {
        supplier.title = teamListModel.businessExtraField.platformName;
    } else {
        supplier.title = teamListModel.name;
    }
    
    supplier.selectStatus_type = ^(NSInteger index, int type) {
        BizDistrictTeamPlatformModel *teamListModel = self.contentArr[index];
        teamListModel.type = type;
        self.type = type;
        // 控制全选按钮状态
        [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    };
    [self.navigationController pushViewController:supplier animated:true];
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if (touch.view != self.customTableView) {
        return NO;
    }else {
        return YES;
    }
}
@end
