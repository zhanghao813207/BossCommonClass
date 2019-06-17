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
    
    NSArray *platformListArr = self.contentArr[indexPath.row];
    if (platformListArr.count > 0) {
        BizDistrictTeam *teamListModel = platformListArr[0];
        cell.titleLabel.text = teamListModel.businessExtraField.platformName;
        cell.model = teamListModel;
        
        cell.selectBlock = ^(BOOL selectStatus) {
            teamListModel.isSelect = selectStatus;
            [tableView reloadData];
        };
    }
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSMutableArray *platformArr = self.contentArr[indexPath.row];
    NSMutableArray *IDArr = [NSMutableArray array];
    for (BizDistrictTeam *teamListModel in platformArr){
        [IDArr addObject:teamListModel.businessExtraField.supplierId];
    }
    IDArr = [IDArr valueForKeyPath:@"@distinctUnionOfObjects.self"];
    NSMutableArray *supplierList = [NSMutableArray array];
    for(NSString * supplierId in IDArr) {
        NSMutableArray *supplierArr = [NSMutableArray array];
        for (BizDistrictTeam *teamListModel in platformArr) {
            if ([supplierId isEqualToString:teamListModel.businessExtraField.supplierId]){
                [supplierArr addObject:teamListModel];
            }
        }
        [supplierList addObject:supplierArr];
    }
    NSLog(@"%@", supplierList);
    
    SupplierVc * supplier = [SupplierVc storyBoardCreateViewControllerWithBundle:@"BossCommonClass" StoryBoardName:@"EntrustAccountRegistration"];
    supplier.contentArr = supplierList;
    [self.navigationController pushViewController:supplier animated:true];
    
}
@end
