
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

@interface AddressBookVC ()<UITableViewDelegate,UITableViewDataSource,AddressBookCellDelegate>
@property(nonatomic, strong)UITableView *tableview;
@property(nonatomic, strong)UIView *selecBar;
////以下为测试
@property(nonatomic, strong)NSMutableArray<TestGroupModel *> *arrM;
@property(nonatomic, strong)NSMutableArray<TestGroupModel *> *selectArrM;
@end

@implementation AddressBookVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBarHidden = false;
    self.arrM = [NSMutableArray array];
    self.selectArrM = [NSMutableArray array];
    for (NSInteger i = 0; i < 100; i ++) {
        TestGroupModel *model = [[TestGroupModel alloc] init];
        model.isSelect = false;
        model.name = [NSString stringWithFormat:@"%ld",i];
        [self.arrM addObject:model];
    }
    [self tableview];
    [self selecBar];
}
//AddressBookCellDelegate
- (void)didSelectCell:(AddressBookCell *)cell model:(TestGroupModel *)model {
    [self.selectArrM addObject:model];
    [self.tableview reloadData];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%@",self.selectArrM);
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
- (UITableView *)tableview {
    if (_tableview == nil) {
        _tableview = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableview.rowHeight = 60;
        _tableview.delegate = self;
        _tableview.dataSource = self;
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
        [self.view addSubview:_selecBar];
        [_selecBar mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self.view);
            make.height.mas_equalTo(78);
        }];
    }
    return _selecBar;
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = true;
}


@end
