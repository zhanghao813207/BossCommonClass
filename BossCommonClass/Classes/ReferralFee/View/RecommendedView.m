
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


@interface RecommendedView ()<UITableViewDelegate,UITableViewDataSource,RecommendedCellDelegate,SelectTabbarViewDelegate>

@property(nonatomic, strong)UITableView *tableview;

/**
 保存选中的数据
 */
@property(nonatomic, strong)NSMutableArray *selecArr;
@property(nonatomic, strong)SelectTabbarView *selectView;
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
    NSLog(@"%@",self.selecArr);
    NSMutableArray *tempArr = [NSMutableArray array];
    for (RecommendedModel *model in self.selecArr) {
        [tempArr addObject:model._id];
    }
    [ReferralFeeRequest deleteRecommend:tempArr success:^{
        [self.dataArr removeObjectsInArray:self.selecArr];
        [self.tableview reloadData];
    } fail:^{
        
    }];
}
- (void)selectModel:(SelectTabbarView *)view {
    for (RecommendedModel *model in self.dataArr) {
        model.isSelected = true;
        [self.selecArr addObject:model];
    }
    [self.tableview reloadData];
}
///// RecommendedCellDelegate
- (void)didSelect:(RecommendedModel *)model cell:(RecommendedCell *)cell {
    if (model.isSelected) {
        [self.selecArr addObject:model];
    }else {
        [self.selecArr removeObject:model];
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
        [ReferralFeeRequest deleteRecommend:arr success:^{
            [self.dataArr removeObjectAtIndex:indexPath.row];
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationRight];
        } fail:^{
            
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
        [_tableview registerClass:[RecommendedCell class] forCellReuseIdentifier:identifier];
        [self addSubview:_tableview];
        [_tableview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(self);
            make.bottom.equalTo(self);
        }];
    }
    return _tableview;
}

- (void)setDataArr:(NSMutableArray *)dataArr {
    _dataArr = dataArr;
    [self.tableview reloadData];
}
@end
