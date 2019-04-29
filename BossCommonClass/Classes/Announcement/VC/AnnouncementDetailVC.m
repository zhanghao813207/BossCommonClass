//
//  AnnouncementDetailVC.m
//  AFNetworking
//
//  Created by admin on 2019/4/14.
//

#import "AnnouncementDetailVC.h"
#import "AnnouncementDetailHeaderView.h"
#import "AnnouncementDetailFooterView.h"
#import "AnnouncementDetailCell.h"
#import "Masonry.h"
#import "KNPhotoBrowser.h"
#import "AnnouncementRequest.h"
#import "Media_info.h"

@interface AnnouncementDetailVC ()<UITableViewDelegate,UITableViewDataSource,AnnouncementDetailCellDelegate>

/**
 头视图
 */
@property(nonatomic, strong)AnnouncementDetailHeaderView *headerView;

/**
 尾视图
 */
@property(nonatomic, strong)AnnouncementDetailFooterView *footerView;
@property(nonatomic, strong)UITableView *tableview;

/**
 以上为测试数据
 */

@property(nonatomic, strong)NSMutableArray *itemsArr;
@property(nonatomic, strong)NSArray *imgArr;
@end

@implementation AnnouncementDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.title = @"活动详情";
    self.view.backgroundColor = [UIColor whiteColor];
    

    
    [self footerView];
    [self tableview];
    [AnnouncementRequest announcementDetail:self.idStr success:^(AnnouncementDetail * _Nonnull detailModel) {
        self.title = detailModel.title;
        self.headerView.model = detailModel;
        self.footerView.model = detailModel;
        self.imgArr = detailModel.media_info_list;
        for (Media_info *model in self.imgArr) {
            KNPhotoItems *items = [[KNPhotoItems alloc] init];
            items.sourceImage = [UIImage imageNamed:model.url];
            [self.itemsArr addObject:items];
        }
        [self.tableview reloadData];
    } fail:^(NSString * message) {
        
    }];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if (self.block) {
        self.block(self.headerView.model.message_counter_info.read_counter);
    }
}

- (void)imgClick:(NSString *)model {
    KNPhotoBrowser *photoBrower = [[KNPhotoBrowser alloc] init];
    photoBrower.itemsArr = [self.itemsArr copy];
    photoBrower.isNeedPageControl = true;
    photoBrower.isNeedPageNumView = true;
    photoBrower.isNeedRightTopBtn = true;
    photoBrower.isNeedPictureLongPress = true;
    photoBrower.isNeedPrefetch = true;
    photoBrower.isNeedPictureLongPress = false;
    photoBrower.currentIndex = [self.imgArr indexOfObject:model];
    [photoBrower present];
 
}

//-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
//    return nil;
//}
//
//-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{//Grouped风格下底部留白
//    return 0.0001;
//}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return self.headerView;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.imgArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AnnouncementDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.model = self.imgArr[indexPath.row];
    cell.delegate = self;
    KNPhotoItems *items = self.itemsArr[indexPath.row];
    items.sourceView = cell.imgView;
    return cell;
}
- (NSMutableArray *)itemsArr{
    if (!_itemsArr) {
        _itemsArr = [NSMutableArray array];
    }
    return _itemsArr;
}
- (UITableView *)tableview {
    if (_tableview == nil) {
        _tableview = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableview.backgroundColor = [UIColor whiteColor];
        [_tableview registerClass:[AnnouncementDetailCell class] forCellReuseIdentifier:@"cell"];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
        _tableview.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
        _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:_tableview];
        if (self.isMe) {
            [self.tableview mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.left.right.equalTo(self.view);
                make.bottom.equalTo(self.footerView.mas_top);
            }];
        }else {
            [self.tableview mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.bottom.top.equalTo(self.view);
            }];
        }
    }
    return _tableview;
}
- (AnnouncementDetailHeaderView *)headerView {
    if (_headerView == nil) {
        _headerView = [[AnnouncementDetailHeaderView alloc] init];
    }
    return _headerView;
}
- (AnnouncementDetailFooterView *)footerView {
    if (_footerView == nil) {
        _footerView = [[AnnouncementDetailFooterView alloc] init];
        [self.view addSubview:_footerView];
        [_footerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self.view);
            make.height.mas_equalTo(109);
        }];
    }
    return _footerView;
}

@end
