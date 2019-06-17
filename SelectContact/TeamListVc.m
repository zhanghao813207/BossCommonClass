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

@interface TeamListVc ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *customTableView;

// 是否编辑
@property (nonatomic, assign)BOOL isEdit;
@end

@implementation TeamListVc

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
    
}
-(void)setUI{
    self.customTableView.estimatedRowHeight = 100;
    self.customTableView.rowHeight = UITableViewAutomaticDimension;
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
    NSArray * supplierListarr = self.contentArr[indexPath.row];
    if (supplierListarr.count > 0) {
        BizDistrictTeam *teamListModel = supplierListarr[0];
        cell.titleLabel.text = teamListModel.name;
    }
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSMutableArray *platformArr = self.contentArr[indexPath.row];
    NSMutableArray *IDArr = [NSMutableArray array];
    for (BizDistrictTeam *teamListModel in platformArr){
        [IDArr addObject:teamListModel.businessExtraField.cityCode];
    }
    IDArr = [IDArr valueForKeyPath:@"@distinctUnionOfObjects.self"];
    NSMutableArray *supplierList = [NSMutableArray array];
    for(NSString * supplierId in IDArr) {
        NSMutableArray *supplierArr = [NSMutableArray array];
        for (BizDistrictTeam *teamListModel in platformArr) {
            if ([supplierId isEqualToString:teamListModel.businessExtraField.cityCode]){
                [supplierArr addObject:teamListModel];
            }
        }
        [supplierList addObject:supplierArr];
    }
    NSLog(@"%@", supplierList);
    
//    CityVc * supplier = [CityVc storyBoardCreateViewControllerWithBundle:@"BossCommonClass" StoryBoardName:@"EntrustAccountRegistration"];
//    supplier.contentArr = supplierList;
//    [self.navigationController pushViewController:supplier animated:true];
    
}
@end
