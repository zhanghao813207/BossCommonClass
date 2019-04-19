
//
//  AddressBookVC.m
//  AFNetworking
//
//  Created by admin on 2019/4/17.
//

#import "AddressBookVC.h"
#import "TestGroupModel.h"
#import "Masonry.h"
#import "AddressBookCell.h"
#import "PersonAddressBookVC.h"
#import "JYCMethodDefine.h"
#import "TestPersonModel.h"
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

/**
 最终选择的总人数
 */
@property(nonatomic, strong)NSMutableSet *allPersonSetM;
////以下为测试
@property(nonatomic, strong)NSMutableArray<TestGroupModel *> *arrM;
@property(nonatomic, strong)NSMutableArray<TestGroupModel *> *selectArrM;
@property(nonatomic, strong)UIButton *finishButton;
@end

@implementation AddressBookVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.arrM = [NSMutableArray array];
    self.selectArrM = [NSMutableArray array];
    for (NSInteger i = 0; i < 100; i ++) {
        TestGroupModel *model = [[TestGroupModel alloc] init];
        model.state = SelectStateNo;
        model.name = [NSString stringWithFormat:@"%ld",i];
        [self.arrM addObject:model];
    }
    self.finishButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.finishButton.enabled = false;
    self.finishButton.frame = CGRectMake(0, 0, 60, 35);
    [self.finishButton setTitle:@"完成" forState:UIControlStateNormal];
    self.finishButton.backgroundColor = kHexRGB(0x34A9FF);
    [self.finishButton addTarget:self action:@selector(finishAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.finishButton];
    [self tableview];
    [self selecBar];
    [self allSelectButton];
    [self lineView];
}
- (NSMutableSet *)allPersonSetM {
    if (_allPersonSetM == nil) {
        _allPersonSetM = [NSMutableSet set];
    }
    return _allPersonSetM;
}
- (void)finishAction {
    if (self.delegate && [self.delegate respondsToSelector:@selector(select:)]) {
        [self.delegate select:self.selectArrM];
    }
    [self.navigationController popViewControllerAnimated:true];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = false;
}
//AddressBookCellDelegate
- (void)didSelectCell:(AddressBookCell *)cell model:(TestGroupModel *)model {
    [self.selectArrM addObject:model];
    if (self.selectArrM.count > 0) {
        self.finishButton.enabled = true;
    }else {
        self.finishButton.enabled = false;
    }
    [self.tableview reloadData];
}
//PersonAddressBookVCDelegate
- (void)selectPerson:(NSArray *)modelArr isAll:(BOOL)select {
    self.personSelectArr = modelArr;
    NSMutableSet *tempSet = [NSMutableSet set];
    for (TestPersonModel *tempModel in modelArr) {
        [tempSet addObject:tempModel.name];
    }
    [self.allPersonSetM minusSet:tempSet];
    for (NSString *str in self.allPersonSetM) {
        [self.allPersonSetM removeObject:str];
    }
    [self.allPersonSetM unionSet:tempSet];
    NSLog(@"%@",self.allPersonSetM);
    TestGroupModel *model = self.arrM[self.selectIndex];
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
    TestGroupModel *model = self.arrM[indexPath.row];
    PersonAddressBookVC *vc = [[PersonAddressBookVC alloc] init];
    if (model.state == SelectStateAll) {
        vc.isAll = true;
    }
    vc.delegate = self;
    vc.personSelectArr = self.personSelectArr;
    self.selectIndex = indexPath.row;
    [self.navigationController pushViewController:vc animated:true];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrM.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AddressBookCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.model = self.arrM[indexPath.row];
    cell.delegate = self;
    return cell;
}
- (UIButton *)allSelectButton {
    if (_allSelectButton == nil) {
        _allSelectButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_allSelectButton setTitle:@"全选" forState:UIControlStateNormal];
        _allSelectButton.titleLabel.textColor = kHexRGB(0x0A86F9);
        [_allSelectButton setTitleColor:kHexRGB(0x0A86F9) forState:UIControlStateNormal];
        [_allSelectButton addTarget:self action:@selector(allSelect) forControlEvents:UIControlEventTouchUpInside];
        [self.selecBar addSubview:_allSelectButton];
        [_allSelectButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.selecBar).offset(16);
            make.top.equalTo(self.selecBar).offset(10);
        }];
    }
    return _allSelectButton;
}
- (void)allSelect {
    for (TestGroupModel *model in self.arrM) {
        model.state = SelectStateAll;
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
        _tableview.separatorInset = UIEdgeInsetsMake(0, 50, 0, 0);
        _tableview.tableFooterView = [[UIView alloc] init];
        [_tableview registerClass:[AddressBookCell class] forCellReuseIdentifier:@"cell"];
        [self.view addSubview:_tableview];
        [_tableview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.view);
            make.top.equalTo(self.view);
            make.bottom.equalTo(self.selecBar.mas_top);
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
            make.left.right.bottom.equalTo(self.view);
            make.height.mas_equalTo(78);
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
    self.navigationController.navigationBarHidden = true;
}


@end
