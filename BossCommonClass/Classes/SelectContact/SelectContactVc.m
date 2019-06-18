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

@property (nonatomic, assign) BOOL allSelect;

// 是否编辑
@property (nonatomic, assign)BOOL isEdit;
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
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    self.navigationItem
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
    cell.titleLabel.text = teamListModel.businessExtraField.platformName;
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
        [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    };
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    // 所有子项数组
    NSMutableArray *allSelectType = [NSMutableArray array];
    
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
    supplier.contentArr = teamListModel.PlatformArr;
    supplier.index = indexPath.row;
    supplier.selectStatus_type = ^(NSInteger index, int type) {
        BizDistrictTeamPlatformModel *teamListModel = self.contentArr[index];
        teamListModel.type = type;
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
