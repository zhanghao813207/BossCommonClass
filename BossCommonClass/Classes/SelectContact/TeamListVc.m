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

@end

@implementation TeamListVc

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
    
}
-(void)setUI{
    self.customTableView.estimatedRowHeight = 100;
    self.customTableView.rowHeight = UITableViewAutomaticDimension;
//    BizDistrictTeamPlatformModel * model = self.contentArr[self.index];
//    self.contentArr = model.cityArr;
    self.typeArr = [NSMutableArray array];
}
-(void)popToLastViewController:(UIBarButtonItem *)sender{
    
    for (BizDistrictTeamPlatformModel *teamListModel  in self.contentArr){
        [self.typeArr addObject:[NSNumber numberWithInteger:teamListModel.type]];
        
    }
    if (![self.typeArr containsObject:[NSNumber numberWithInteger:0]]){
        // 包含 1 or 2 但是 最里层没有2 只有 0 1
        if (self.selectStatus_type) {
            self.selectStatus_type(self.index, 1);
        }

    } else if (![self.typeArr containsObject:[NSNumber numberWithInteger:1]]) {
        if (self.selectStatus_type) {
            self.selectStatus_type(self.index, 0);
        }
    } else {
        if (self.selectStatus_type) {
            self.selectStatus_type(self.index, 2);
        }
    }
}
- (void)willMoveToParentViewController:(UIViewController*)parent{
    

}
- (void)didMoveToParentViewController:(UIViewController*)parent{

    [self.typeArr removeAllObjects];
    
    for (BizDistrictTeamPlatformModel *teamListModel  in self.contentArr){
        [self.typeArr addObject:[NSNumber numberWithInteger:teamListModel.type]];
    }
    if (([self.typeArr containsObject:[NSNumber numberWithInteger:0]] && [self.typeArr containsObject:[NSNumber numberWithInteger:1]]) ){
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
        [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    };
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

}
@end
