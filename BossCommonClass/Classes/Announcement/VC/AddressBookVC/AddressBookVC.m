
//
//  AddressBookVC.m
//  AFNetworking
//
//  Created by admin on 2019/4/17.
//

#import "AddressBookVC.h"
#import "Masonry.h"
#import "AddressBookCell.h"
#import "PersonAddressBookVC.h"
#import "JYCMethodDefine.h"
#import "ContactsPerson.h"
#import "AnnouncementRequest.h"
#import "MJRefresh.h"
#import "UIView+ShowView.h"
#import "JYCMethodDefine.h"
@interface AddressBookVC ()<UITableViewDelegate,UITableViewDataSource,AddressBookCellDelegate,PersonAddressBookVCDelegate>
@property(nonatomic, strong)UITableView *tableview;

/**
 全选按钮的父视图
 */
@property(nonatomic, strong)UIView *selecBar;
@property(nonatomic, strong)UIView *lineView;
/**
 全选按钮
 */
@property(nonatomic, strong)UIButton *allSelectButton;

/**
 记录点击的哪一行
 */
@property(nonatomic, assign)NSInteger selectIndex;

/**
 个人页面返回被选中的数据
 */
@property(nonatomic, strong)NSArray *personSelectArr;
@property(nonatomic, strong)NSMutableDictionary *selectDic;


@property(nonatomic, strong)NSMutableArray<ContactsGroup *> *arrM;


@property(nonatomic, strong)UIButton *finishButton;

/**
 当前页
 */
@property(nonatomic, assign)NSInteger currentPage;

/**
 被选择的team数组
 */
@property(nonatomic, strong)NSMutableArray<ContactsGroup *> *selectArrM;
@end

@implementation AddressBookVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.currentPage = 1;
    self.arrM = [NSMutableArray array];
    self.selectArrM = [NSMutableArray array];
    
    self.finishButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    self.finishButton.userInteractionEnabled = false;
    self.finishButton.frame = CGRectMake(0, 0, 60, 35);
    self.finishButton.layer.cornerRadius = 4;
    self.finishButton.layer.masksToBounds = true;
    self.finishButton.hidden = !self.isShowSelectBar;
    [self.finishButton setTitle:@"完成" forState:UIControlStateNormal];
    self.finishButton.backgroundColor = kHexRGB(0x34A9FF);
    [self.finishButton addTarget:self action:@selector(finishAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.finishButton];
    [self tableview];
    [self selecBar];
    [self allSelectButton];
    [self lineView];
    
    self.selecBar.hidden = !self.isShowSelectBar;
    self.title = @"通讯录";
//    [self refreshLatestData];
}


/**
 获取数据
 */
- (void)refreshLatestData {
    [self.selectArrM removeAllObjects];
//    [self.view showStatus:@"正在请求数据..."];
    [AnnouncementRequest announcementContactsPage:self.currentPage GroupSuccess:^(NSArray * _Nonnull dataArr) {
        
        self.arrM = [dataArr mutableCopy];
        for (ContactsGroup *model in self.arrM) {
            for (ContactsGroup *selectModel in self.teamArr) {
                if ([model._id isEqualToString:selectModel._id]) {
                    [self.selectArrM addObject:model];
                    model.state = SelectStateAll;
                    model.isShow = !self.isShowSelectBar;
                }
            }
        }
        
        [self.tableview reloadData];
        [self.tableview.mj_header endRefreshingWithCompletionBlock:^{
            self.tableview.mj_header = nil;
        }];
    } fail:^(NSString * message) {
        [self.tableview.mj_header endRefreshingWithCompletionBlock:^{
            self.tableview.mj_header = nil;
            
        }];
    }];
    
    ////test
//    [self.tableview.mj_header endRefreshing];
}
- (void)refreshMoreData {
   
}
- (NSMutableDictionary *)selectDic {
    if (_selectDic == nil) {
        _selectDic = [NSMutableDictionary dictionary];
    }
    return _selectDic;
}

- (void)finishAction {
    NSMutableArray *tempArr = [NSMutableArray array];
    
/*这是选择的人数  先注释掉
    if (self.delegate && [self.delegate respondsToSelector:@selector(select:)]) {
        NSArray *keys = self.selectDic.allKeys;
        for (NSInteger i = 0; i < keys.count; i ++) {
            for (ContactsPerson *model in self.selectDic[keys[i]]) {
                [tempArr addObject:model.nick_name];
            }
        }
        [self.delegate select:tempArr];
//    }*/
    NSLog(@"%@",self.selectArrM);
    if (self.selectArrM.count > 0) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(select:)]) {
            [self.delegate select:self.selectArrM];
        }
        [self.navigationController popViewControllerAnimated:true];
    }else {
        [self.view showStatus:@"请选择联系人"];
    }
   
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = false;
//    [self.arrM removeAllObjects];
    
    [self getNewToken];
}
- (void)getNewToken {
//    [kUserDefault removeObjectForKey:@"newToken"];
//    [kUserDefault removeObjectForKey:@"uploadImage"];
    if ([kUserDefault objectForKey:@"newToken"]) {
        [self.tableview.mj_header beginRefreshing];
    }else {
        [AnnouncementRequest getNewtokenSuccess:^(id response) {
            NSLog(@"%@",response);
            [self.tableview.mj_header beginRefreshing];
        }];
    }
    
}
//AddressBookCellDelegate
- (void)didSelectCell:(AddressBookCell *)cell model:(ContactsGroup *)model {
    if (model.state == SelectStateAll) {
       [self.selectArrM addObject:model];
    }else if (model.state == SelectStateNo) {
        [self.selectArrM removeObject:model];
    }
    NSLog(@"%@",self.selectArrM);
    if (self.selectArrM.count > 0) {
//        self.finishButton.userInteractionEnabled = true;
    }else {
//        self.finishButton.userInteractionEnabled = false;
    }
    [self.tableview reloadData];
}
//PersonAddressBookVCDelegate
- (void)selectPerson:(NSArray *)modelArr isAll:(BOOL)select {
    self.personSelectArr = modelArr;
    [self.selectDic setValue:modelArr forKey:[NSNumber numberWithInteger:self.selectIndex]];
    ContactsGroup *model = self.arrM[self.selectIndex];
    if (select) {
        model.state = SelectStateAll;
    }else {
        model.state = SelectStateSubAll;
    }
    
    [self.tableview reloadData];
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView = [[UIView alloc] init];
    headerView.backgroundColor = kHexRGB(0xF3F3F3);
    [headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(35);
        make.width.mas_equalTo(kScreenWidth);
    }];
    UILabel *label = [[UILabel alloc] init];
    label.text = @"我的分组";
    label.font = [UIFont systemFontOfSize:12];
    [headerView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headerView).offset(16);
        make.centerY.equalTo(headerView);
    }];
    return headerView;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ContactsGroup *model = self.arrM[indexPath.row];
    PersonAddressBookVC *vc = [[PersonAddressBookVC alloc] init];
    vc.group = model;
    if (model.state == SelectStateAll) {
        vc.isAll = true;
    }else {
//        vc.personSelectArr = self.personSelectArr;
        vc.personSelectArr = self.selectDic[[NSNumber numberWithInteger:indexPath.row]];
    }
    vc.delegate = self;
    
    self.selectIndex = indexPath.row;
    [self.navigationController pushViewController:vc animated:true];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrM.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AddressBookCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if (self.arrM.count > 0) {
        cell.model = self.arrM[indexPath.row];
    }
    
    cell.isSelctHidden = !self.isShowSelectBar;
    cell.delegate = self;
    return cell;
}
- (UIButton *)allSelectButton {
    if (_allSelectButton == nil) {
        _allSelectButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_allSelectButton setTitle:@"全选" forState:UIControlStateNormal];
        _allSelectButton.titleLabel.textColor = kHexRGB(0x0A86F9);
        [_allSelectButton setTitleColor:kHexRGB(0x0A86F9) forState:UIControlStateNormal];
        [_allSelectButton addTarget:self action:@selector(allSelect:) forControlEvents:UIControlEventTouchUpInside];
        [self.selecBar addSubview:_allSelectButton];
        [_allSelectButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.selecBar).offset(16);
            make.centerY.equalTo(self.selecBar);
        }];
    }
    return _allSelectButton;
}
- (void)allSelect:(UIButton *)button {
    if (self.selectArrM.count == self.arrM.count) {
        button.selected = true;
    }
    button.selected = !button.isSelected;
   
    [self.selectArrM removeAllObjects];
    if (button.selected) {
        for (ContactsGroup *model in self.arrM) {
            model.state = SelectStateAll;
            [self.selectArrM addObject:model];
        }
    }else {
        for (ContactsGroup *model in self.arrM) {
            model.state = SelectStateNo;
        }
    }
    [self.tableview reloadData];
}
- (UITableView *)tableview {
    if (_tableview == nil) {
        _tableview = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableview.backgroundColor = [UIColor whiteColor];
        _tableview.rowHeight = 60;
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.separatorColor = kHexRGB(0xE5E5EE);
        _tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshLatestData)];
//        _tableview.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(refreshMoreData)];
        if (self.isShowSelectBar) {
            _tableview.separatorInset = UIEdgeInsetsMake(0, 58, 0, 0);
        }else {
            _tableview.separatorInset = UIEdgeInsetsMake(0, 16, 0, 0);
        }
        _tableview.tableFooterView = [[UIView alloc] init];
        [_tableview registerClass:[AddressBookCell class] forCellReuseIdentifier:@"cell"];
        [self.view addSubview:_tableview];
        [_tableview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.view);
            make.top.equalTo(self.view);
            if (self.isShowSelectBar) {
               make.bottom.equalTo(self.selecBar.mas_top);
            }else {
                make.bottom.equalTo(self.view);
            }
            
        }];
    }
    return _tableview;
}
- (UIView *)selecBar {
    if (_selecBar == nil) {
        _selecBar = [[UIView alloc] init];
        _selecBar.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:_selecBar];
        [_selecBar mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.view);
            make.height.mas_equalTo(45);
            if (kIsiPhoneX) {
                make.bottom.mas_equalTo(-33);
            }else {
                make.bottom.equalTo(self.view);
            }
        }];
    }
    return _selecBar;
}
- (UIView *)lineView {
    if (_lineView == nil) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = [UIColor lightGrayColor];
        [self.selecBar addSubview:_lineView];
        [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.selecBar);
            make.height.mas_equalTo(1 / UIScreen.mainScreen.scale);
        }];
    }
    return _lineView;
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if (self.isShowSelectBar) {
        self.navigationController.navigationBarHidden = true;
    }
    
}



@end
