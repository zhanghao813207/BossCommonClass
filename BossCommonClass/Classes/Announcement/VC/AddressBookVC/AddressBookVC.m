
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
#import "BossBasicDefine.h"
#import "NotDateEmptyView.h"
@import boss_common_ios;

@interface AddressBookVC ()<UITableViewDelegate,UITableViewDataSource,AddressBookCellDelegate,PersonAddressBookVCDelegate>
@property(nonatomic, strong)UITableView *tableview;
@property (nonatomic, strong) NotDateEmptyView *emptyView;
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
 这个是当前还能选个人的时候写的属性  用来保存每一组选择的哪几个人
 */
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
    self.view.backgroundColor = [UIColor colorNamed:@"bgcolor_FFFFFF_000000"];
    self.packUpKeybordEnable = false;
    if(!self.isShowSelectBar){
        self.navigationItem.leftBarButtonItem = nil;
    }
    self.navigationItem.hidesBackButton = YES;
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
    self.finishButton.userInteractionEnabled = false;
    self.finishButton.backgroundColor = [UIColor colorNamed:@"button_3589DE_0087FF"];
    self.finishButton.alpha = 0.4;
    [self.finishButton addTarget:self action:@selector(finishAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.finishButton];
    [self tableview];
    [self selecBar];
    [self allSelectButton];
    [self lineView];
    
    self.selecBar.hidden = !self.isShowSelectBar;
    self.title = @"通讯录";
    
//    self.view.backgroundColor = kHexRGB(0xF9FBFC);
}

/**
 获取数据
 */
- (void)refreshLatestData {
    
    // 刷新间隔 强制刷新
    [[TabbarChildVCRefresh share] needRefreshWithIndex:self.tabBarController.selectedIndex forcedRefresh:true];
    
    // 是否启动UMS
    if(!kCache.checkStartUMS){
        [self.tableview.mj_header endRefreshing];
        [self judgeEmptyView];
        return;
    }
    
    [self.selectArrM removeAllObjects];
    //    [self.view showStatus:@"正在请求数据..."];
    if(self.isShowSelectBar){
        [AnnouncementRequest findWPPAdressBook:self.wppId successBlock:^(NSArray * _Nonnull dataArr) {
            [self handleSuccess:dataArr];
            
        } fail:^(NSString * message) {
            [self handleFailed];
        }];
    }else{
        [AnnouncementRequest findAddressBook:^(NSArray * _Nonnull dataArr) {
            [self handleSuccess:dataArr];
            
        } fail:^(NSString * message) {
            [self handleFailed];
        }];
    }
}

- (void)handleSuccess:(NSArray *)dataArr{
    if (dataArr.count > 0) {
        self.arrM = [dataArr mutableCopy];
        for (ContactsGroup *model in self.arrM) {
            for (ContactsGroup *selectModel in self.teamArr) {
                if ([model._id isEqualToString:selectModel._id] || [model.vendor_target_id isEqualToString:selectModel.vendor_target_id]) {
                    [self.selectArrM addObject:model];
                    model.state = SelectStateAll;
                    model.isShow = !self.isShowSelectBar;
                }
            }
        }
        self.tableview.backgroundColor = [UIColor colorNamed:@"bgcolor_F5F5F5_000000"];
    } else {
        [self.arrM removeAllObjects];
        self.tableview.backgroundColor = nil;
    }
    [self.tableview.mj_header endRefreshingWithCompletionBlock:^{
        if (self.isShowSelectBar) {
            self.tableview.mj_header = nil;
        }
    }];
    [self.tableview reloadData];
    // 判断是否添加空页面
    [self judgeEmptyView];
}

- (void)handleFailed {
    self.tableview.backgroundColor = UIColor.clearColor;
    [self.tableview reloadData];
    [self.tableview.mj_header endRefreshingWithCompletionBlock:^{
        
        if (self.isShowSelectBar) {
            self.tableview.mj_header = nil;
        }
    }];
    // 判断是否添加空页面
    [self judgeEmptyView];
}

/// 判断是否添加空页面
- (void)judgeEmptyView {
#ifdef kBossManager
    if (self.arrM.count > 0) {
        self.tableview.tableFooterView = [[UIView alloc] init];
    }else {
        self.tableview.tableFooterView = self.emptyView;
    }
#else
    self.tableview.backgroundView.backgroundColor = self.arrM.count > 0 ? [UIColor colorNamed:@"bgcolor_F5F5F5_000000"] : UIColor.clearColor ;
#endif
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
    
    /*这是选择的人数  先注释掉
     NSMutableArray *tempArr = [NSMutableArray array];
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
        if (self.delegate && [self.delegate respondsToSelector:@selector(selectModelDelegate:)]) {
            [self.delegate selectModelDelegate:self.selectArrM];
        }
        [self.navigationController popViewControllerAnimated:true];
    }else {
        [self.view showStatus:@"请选择联系人"];
    }
    
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = false;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
#ifdef kBossManager
    [self.tableview.mj_header beginRefreshing];
#else
    /// 刷新间隔
    if ([[TabbarChildVCRefresh share] needRefreshWithIndex:self.tabBarController.selectedIndex forcedRefresh:false] == true) {
        [self.tableview.mj_header beginRefreshing];
    }
#endif
    // 从后台回到app
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appDidBecomeActive) name:UIApplicationDidBecomeActiveNotification object:nil];
}

/// app从后台返回到前台
- (void)appDidBecomeActive {
    /// 刷新间隔
    if ([[TabbarChildVCRefresh share] needRefreshWithIndex:self.tabBarController.selectedIndex forcedRefresh:false] == true) {
        [self.tableview.mj_header beginRefreshing];
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
    [self.tableview reloadData];
    [self updateFinishButton];
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
    if (self.arrM.count > 0){
        UIView *headerView = [[UIView alloc] init];
        headerView.backgroundColor = [UIColor colorNamed:@"boss_F3F3F3_000000"];
        [headerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(35);
            make.width.mas_equalTo(kScreenWidth);
        }];
        UILabel *label = [[UILabel alloc] init];
        label.text = @"我的群组";
        label.font = [UIFont systemFontOfSize:12];
        [headerView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(headerView).offset(16);
            make.centerY.equalTo(headerView);
        }];
        return headerView;
    }
    return nil;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ContactsGroup *model = self.arrM[indexPath.row];
    PersonAddressBookVC *vc = [[PersonAddressBookVC alloc] init];
    vc.group = model;
    vc.iscloseTalk = !self.iscloseTalk;
    if (model.state == SelectStateAll) {
        vc.isAll = true;
    }else {
        //        vc.personSelectArr = self.personSelectArr;
        vc.personSelectArr = self.selectDic[[NSNumber numberWithInteger:indexPath.row]];
    }
    vc.delegate = self;
    
    self.selectIndex = indexPath.row;
    vc.hidesBottomBarWhenPushed = true;
    [self.navigationController pushViewController:vc animated:true];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrM.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (self.arrM.count > 0) {
        return 35;
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AddressBookCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    if (self.arrM.count > 0) {
        cell.model = self.arrM[indexPath.row];
    }
    if(indexPath.row == self.arrM.count - 1){
        cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, cell.bounds.size.width);
    }
    cell.isSelctHidden = !self.isShowSelectBar;
    cell.delegate = self;
    return cell;
}

- (void)updateFinishButton {
    if (self.selectArrM.count > 0) {
        self.finishButton.userInteractionEnabled = true;
        self.finishButton.alpha = 1.0;
    }else {
        self.finishButton.userInteractionEnabled = false;
        self.finishButton.alpha = 0.4;
    }
}

- (UIButton *)allSelectButton {
    if (_allSelectButton == nil) {
        _allSelectButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_allSelectButton setTitle:@"全选" forState:UIControlStateNormal];
//        _allSelectButton.titleLabel.textColor = kHexRGB(0x0A86F9);
        [_allSelectButton setTitleColor:[UIColor colorNamed:@"button_3589DE_0087FF"] forState:UIControlStateNormal];
        [_allSelectButton addTarget:self action:@selector(allSelect:) forControlEvents:UIControlEventTouchUpInside];
        [self.selecBar addSubview:_allSelectButton];
        [_allSelectButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.selecBar).offset(16);
            make.top.equalTo(self.selecBar).offset(10);
//            make.centerY.equalTo(self.selecBar);
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
    [self updateFinishButton];
}
- (UITableView *)tableview {
    if (_tableview == nil) {
        _tableview = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableview.backgroundColor = [UIColor colorNamed:@"bgcolor_FFFFFF_000000"];
        _tableview.rowHeight = 60;
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.separatorColor = [UIColor colorNamed:@"linecolor_E8E8E8_2B2B2B"];
        _tableview.backgroundColor = [UIColor colorNamed:@"bgcolor_F5F5F5_000000"];
        //        _tableview.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(refreshMoreData)];
        if (self.isShowSelectBar) {
            _tableview.separatorInset = UIEdgeInsetsMake(0, 58, 0, 0);
        }else {
            _tableview.separatorInset = UIEdgeInsetsMake(0, 16, 0, 0);
        }
        _tableview.tableFooterView = [[UIView alloc] init];
        [_tableview registerClass:[AddressBookCell class] forCellReuseIdentifier:@"cell"];
        
        // 设置下拉刷新 header view 并 设置回调
        MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshLatestData)];
//        header.lastUpdatedTimeLabel.hidden = YES;
//        header.stateLabel.hidden = YES;
        [header.loadingView setColor:[UIColor colorNamed:@"boss_000000_FFFFFF"]];
        _tableview.mj_header = header;
        
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
        _selecBar.backgroundColor = [UIColor colorNamed:@"boss_FFFFFF_1A1A1A"];
        [self.view addSubview:_selecBar];
        [_selecBar mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.view);
            if (kIsiPhoneX) {
                make.height.mas_equalTo(80);
            }else {
                make.height.mas_equalTo(45);
            }
            make.bottom.equalTo(self.view);
        }];
    }
    return _selecBar;
}
- (UIView *)lineView {
    if (_lineView == nil) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = [UIColor colorNamed:@"linecolor_E8E8E8_2B2B2B"];
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

- (NotDateEmptyView *)emptyView
{
    if (!_emptyView) {
        CGRect rect = self.view.bounds;
        _emptyView = [[NotDateEmptyView alloc] initWithFrame:rect theImageViewOrigin:0 theImageAddTitleSpace:0 imageName:nil imageSize:CGSizeZero title:@"暂无群组" isType:NotDateEmptyViewTypeIsUpImageDownTitle];
    }
    return _emptyView;
}

@end
