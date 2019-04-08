
//
//  RecommendedView.m
//  AFNetworking
//
//  Created by admin on 2019/3/26.
//

#import "RecommendedView.h"
#import "Masonry.h"
#import "RecommendedCell.h"
#import "SelectTabbarView.h"
#import "ReferralFeeRequest.h"
#import "UIView+GetVC.h"
#import "MJRefresh.h"


@interface RecommendedView ()<UITableViewDelegate,UITableViewDataSource,RecommendedCellDelegate,SelectTabbarViewDelegate>

@property(nonatomic, strong)UITableView *tableview;

/**
 保存选中的数据
 */
@property(nonatomic, strong)NSMutableArray *selecArr;
@property(nonatomic, strong)SelectTabbarView *selectView;
@property(nonatomic, strong)UILabel *nodataLabel;
@end

@implementation RecommendedView
static NSString *identifier = @"cell";
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.selecArr = [NSMutableArray array];
        [self tableview];
        self.backgroundColor = UIColor.orangeColor;
    }
    return self;
}
- (void)headerFresh {
    [self.tableview.mj_header beginRefreshingWithCompletionBlock:^{
        [self.tableview.mj_header endRefreshing];
    }];
}

- (void)setIsEditing:(BOOL)isEditing {
    _isEditing = isEditing;
    NSLog(@"%d",isEditing);
    if (isEditing) {
        [self selectView];
        [self.tableview mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self).offset(-44);
        }];
    }
}
//SelectTabbarViewDelegate
- (void)deleteModel:(SelectTabbarView *)view {
    /**
    NSMutableArray *tempArr = [NSMutableArray array];
    for (RecommendedModel *model in self.dataArr) {
        [tempArr addObject:model._id];
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(deleteAll:)]) {
        [self.delegate deleteAll:self.dataArr];
    }**/
    if (view.isAll) {
        self.selecArr = self.dataArr;
    }
    NSMutableArray *tempArr = [NSMutableArray array];
    for (RecommendedModel *model in self.selecArr) {
        [tempArr addObject:model._id];
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(deleteAll:)]) {
        [self.delegate deleteAll:self.selecArr];
    }
    [self.tableview reloadData];

}
- (void)selectModel:(SelectTabbarView *)view {
  /**  NSMutableArray *idsArr = [NSMutableArray array];
    for (RecommendedModel *model in self.dataArr) {
        model.isSelected = true;
        [idsArr addObject:model._id];
        [self.selecArr addObject:model];
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(submitAll:)]) {
        [self.delegate submitAll:idsArr];
    }
    [self.tableview reloadData];
    **/
    
    NSLog(@"%d",view.isAll);
    NSMutableArray *idsArr = [NSMutableArray array];
    if (view.isAll) {
        self.selecArr = self.dataArr;
    }
    for (RecommendedModel *model in self.selecArr) {
        model.isSelected = true;
        [idsArr addObject:model._id];
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(submitAll:)]) {
        [self.delegate submitAll:idsArr];
    }
    [self.tableview reloadData];
}

- (void)setIsFinish:(BOOL)isFinish {
    _isFinish = isFinish;
    if (self.isFinish) {
        self.selectView.isFinish = isFinish;
    }
}

///// RecommendedCellDelegate
- (void)didSelect:(RecommendedModel *)model cell:(RecommendedCell *)cell {
    if (model.isSelected) {
        [self.selecArr addObject:model];
    }else {
        [self.selecArr removeObject:model];
    }
    self.selectView.seletcArr = self.selecArr;
    if (self.selecArr.count == self.dataArr.count) {
        self.selectView.isAll = true;
    }else {
        self.selectView.isAll = false;
    }
    [self.tableview reloadData];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectModel:)]) {
        [self.delegate didSelectModel:self.dataArr[indexPath.row]];
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}
- (nullable NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath  {
    RecommendedModel *model = self.dataArr[indexPath.row];
    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        NSArray *arr = @[model._id];
        
        
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"" message:@"删除后信息将从你的列表当中清除,是否继续删除?" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *no = [UIAlertAction actionWithTitle:@"否" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        UIAlertAction *yes = [UIAlertAction actionWithTitle:@"是" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            [ReferralFeeRequest deleteRecommend:arr success:^{
                [self.dataArr removeObjectAtIndex:indexPath.row];
                [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationRight];
            } fail:^{
                
            }];
        }];
        [alertVC addAction:no];
        [alertVC addAction:yes];
        [self.viewController presentViewController:alertVC animated:true completion:^{
            
        }];
    }];
    if (self.isEditing) {
        return @[];
    }
    return @[deleteAction];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RecommendedCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    cell.delegate = self;
    RecommendedModel *model = self.dataArr[indexPath.row];
    model.isEditing = self.isEditing;
    model.isWait = self.isWait;
    cell.model = model;
    return cell;
}
- (SelectTabbarView *)selectView {
    if (_selectView == nil) {
        _selectView = [[SelectTabbarView alloc] init];
        _selectView.delegate = self;
        [self addSubview:_selectView];
        [_selectView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.bottom.equalTo(self).offset(0);
            make.height.mas_equalTo(44);
        }];
    }
    return _selectView;
}
- (UITableView *)tableview {
    if (_tableview == nil) {
        _tableview = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.tableFooterView = [[UIView alloc] init];
        _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshLatestData)];
        _tableview.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(refreshMoreData)];
        [_tableview registerClass:[RecommendedCell class] forCellReuseIdentifier:identifier];
        [self addSubview:_tableview];
        [_tableview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(self);
            make.bottom.equalTo(self);
        }];
    }
    return _tableview;
}
- (void)refreshMoreData {
    if (self.delegate && [self.delegate respondsToSelector:@selector(getMore)]) {
        [self.delegate getMore];
        [self.tableview.mj_footer endRefreshing];
    }
}
- (void)refreshLatestData {
    if (self.delegate && [self.delegate respondsToSelector:@selector(refresh)]) {
        [self.delegate refresh];
        [self.tableview.mj_header endRefreshing];
    }
}
- (void)setDataArr:(NSMutableArray *)dataArr {
    _dataArr = dataArr;
    if (self.isEditing) {
        self.selectView.modelArr = dataArr;
    }
    if (dataArr.count > 0) {
        self.nodataLabel.hidden = true;
        [self.tableview mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self).offset(0);
        }];
    }
    [self.tableview reloadData];
}
- (void)noDataView {
    _tableview.mj_footer = nil;
    self.nodataLabel.hidden = false;
    [self.tableview mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self).offset(-20);
    }];
}
- (UILabel *)nodataLabel {
    if (_nodataLabel == nil) {
        _nodataLabel = [[UILabel alloc] init];
        _nodataLabel.backgroundColor = [UIColor whiteColor];
        _nodataLabel.hidden = true;
        _nodataLabel.textAlignment = NSTextAlignmentCenter;
        _nodataLabel.text = @"没有更多数据";
        [self addSubview:_nodataLabel];
        [_nodataLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.bottom.equalTo(self).offset(-40);
        }];
    }
    return _nodataLabel;
}
@end
