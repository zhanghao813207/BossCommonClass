
//
//  PersonAddressBookVC.m
//  AFNetworking
//
//  Created by admin on 2019/4/17.
//

#import "PersonAddressBookVC.h"
#import "ContactsPerson.h"
#import "PersonAddressBookCell.h"
#import "Masonry.h"
#import "JYCMethodDefine.h"
#import "AnnouncementRequest.h"
#import "UIView+ShowView.h"

@interface PersonAddressBookVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic, strong)UITableView *tableview;

/**
 全选的父视图
 */
@property(nonatomic, strong)UIView *selecBar;
@property(nonatomic, strong)UIView *lineView;

/**
 全选按钮
 */
@property(nonatomic, strong)UIButton *allSelectButton;

/**
 完成按钮
 */
@property(nonatomic, strong)UIButton *finishButton;
@property(nonatomic, assign)BOOL isSelecAll;
@property(nonatomic, strong)NSMutableArray<ContactsPerson *> *arrM;
@property(nonatomic, strong)NSArray *allDataArr;
@property(nonatomic, strong)NSMutableArray<ContactsPerson *> *selectArrM;
@end

@implementation PersonAddressBookVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBarHidden = false;
    self.title = self.group.name;
    self.arrM = [NSMutableArray array];
    self.selectArrM = [NSMutableArray array];
  
    [self addSubviews];
    ////先隐藏掉
//    [self setSelectModel];
    [self getData];
}
- (void)addSubviews {
    [self tableview];
    [self selecBar];
//    [self lineView];
//    [self allSelectButton];
//    self.finishButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    self.finishButton.enabled = false;
//    self.finishButton.frame = CGRectMake(0, 0, 60, 35);
//    self.finishButton.layer.cornerRadius = 4;
//    self.finishButton.layer.masksToBounds = true;
//    [self.finishButton setTitle:@"完成" forState:UIControlStateNormal];
//    self.finishButton.backgroundColor = kHexRGB(0x34A9FF);
//    [self.finishButton addTarget:self action:@selector(finishAction) forControlEvents:UIControlEventTouchUpInside];
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.finishButton];
}
- (void)getData {
    [AnnouncementRequest announcementContactsMembersId:self.group.vendor_target_id Success:^(NSArray * _Nonnull dataArr) {
        self.arrM = [dataArr mutableCopy];
        [self setSelectModel];
        [self.tableview reloadData];  
    } fail:^(NSString * _Nonnull message) {
        
    }];
}
/**
 处理上一个界面带回来的数据
 */
- (void)setSelectModel {
    [self.selectArrM removeAllObjects];
    if (self.isAll) {
        for (ContactsPerson *model in self.arrM) {
            model.isSelect = true;
            [self.selectArrM addObject:model];
        }
        self.isSelecAll = true;
        [self.tableview reloadData];
    }else {
        for (ContactsPerson *model in self.personSelectArr) {
            for (ContactsPerson *tempModel in self.arrM) {
                if ([model.nick_name isEqualToString:tempModel.nick_name]) {
                    tempModel.isSelect = true;
                    [self.selectArrM addObject:tempModel];
                }
            }
            
        }
        if (self.selectArrM.count == self.arrM.count && self.arrM.count != 0) {
            self.isSelecAll = true;
        }
        [self.tableview reloadData];
    }
    
}
- (void)finishAction {
   
    if (self.delegate && [self.delegate respondsToSelector:@selector(selectPerson:isAll:)]) {
        [self.delegate selectPerson:self.selectArrM isAll:self.isSelecAll];
        [self.navigationController popViewControllerAnimated:true];
    }
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = false;
}
/////先隐藏掉
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    ContactsPerson *model = self.arrM[indexPath.row];
//    model.isSelect = !model.isSelect;
//    if (model.isSelect) {
//        [self.selectArrM addObject:model];
//    }else {
//        [self.selectArrM removeObject:model];
//    }
//    NSLog(@"%ld",self.selectArrM.count);
//    if (self.selectArrM.count > 0) {
//        self.finishButton.enabled = true;
//    }else {
//        self.finishButton.enabled = false;
//    }
//    if (self.selectArrM.count == self.arrM.count) {
//        self.isSelecAll = true;
//    }else {
//        self.isSelecAll = false;
//    }
//    NSLog(@"%@",self.selectArrM);
//    [tableView reloadData];
//}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrM.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PersonAddressBookCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.model = self.arrM[indexPath.row];
    return cell;
}
- (UITableView *)tableview {
    if (_tableview == nil) {
        _tableview = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableview.rowHeight = 60;
        _tableview.delegate = self;
        _tableview.dataSource = self;
//        _tableview.separatorInset = UIEdgeInsetsMake(0, 50, 0, 0);
        _tableview.tableFooterView = [[UIView alloc] init];
        [_tableview registerClass:[PersonAddressBookCell class] forCellReuseIdentifier:@"cell"];
        [self.view addSubview:_tableview];
        [_tableview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.view);
            make.top.equalTo(self.view);
//            make.bottom.equalTo(self.selecBar.mas_top);
            make.bottom.equalTo(self.view);
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
- (UIButton *)allSelectButton {
    if (_allSelectButton == nil) {
        _allSelectButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_allSelectButton setTitle:@"全选" forState:UIControlStateNormal];
        _allSelectButton.titleLabel.textColor = kHexRGB(0x0A86F9);
//        _allSelectButton.backgroundColor = [UIColor purpleColor];
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
    for (ContactsPerson *model in self.arrM) {
        model.isSelect = true;
    }
    [self.selectArrM  removeAllObjects];
    [self.selectArrM addObjectsFromArray:self.arrM];
    self.isSelecAll = true;
    self.finishButton.enabled = true;
    [self.tableview reloadData];
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
//    self.navigationController.navigationBarHidden = true;
}


@end
