
//
//  InputMessageVC.m
//  AFNetworking
//
//  Created by admin on 2019/3/27.
//

#import "InputMessageVC.h"
#import "InputMessageModel.h"
#import "InputCell.h"
#import "Masonry.h"
#import "InputMessageVC+InputContent.h"
#import "ReferralFeeRequest.h"



@interface InputMessageVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic, strong)NSArray *dataArr;
@property(nonatomic, strong)UITableView *tableview;
@property(nonatomic, strong)FooterView *footerView;

@property(nonatomic,strong)NSArray *listArr;
@end

@implementation InputMessageVC
static NSString *idt = @"cell";
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

//        self.dataArr = @[@[@"骑士"],@[@"姓名",@"年龄",@"所在区域",@"详细地址",@"联系方式",@"工作状态",@"经验",@"身份证"]];
    
    self.dataArr = [InputMessageModel getModelArr];
    
    self.model = [[InputMessageModel alloc] init];
    [self tableview];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHiden:) name:UIKeyboardWillHideNotification object:nil];
//    self.tableview.backgroundColor = UIColor.orangeColor;
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"编辑" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(rightAction) forControlEvents:UIControlEventTouchUpInside];
    button.hidden = self.isDetail ? false : true;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.title = self.isDetail ? @"推荐信息":@"我要推荐";
    if (self.isDetail) {
        [self getRecommendDetail];
    }
}

- (void)getRecommendDetail {
    [ReferralFeeRequest recommendDetail:self.listModel._id success:^(NSArray * _Nonnull list) {
        self.dataArr = list;
        self.listArr = list;
        [self.tableview reloadData];
    } fail:^{
        
    }];
}

- (void)cityView {
    GetCityView *view = [[GetCityView alloc] init];
    view.delegate = self;
}
- (void)rightAction {
    self.isDetail = !self.isDetail;
    if (self.isDetail) {
        self.dataArr = self.listArr;
    }else {
        self.dataArr = [InputMessageModel getModelArr];
    }
    [self.tableview reloadData];
}
- (void)setIsDetail:(BOOL)isDetail {
    _isDetail = isDetail;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.title = self.isDetail ? @"推荐信息":@"我要推荐";
        self.footerView.hidden = self.isDetail ? true : false;
        self.tableview.userInteractionEnabled = !self.footerView.hidden;
    });
}

- (void)keyboardHiden:(NSNotification *)aNotification  {
    [UIView animateWithDuration:0.1 animations:^{
        [self.footerView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.view).offset(-10);
        }];
        [self.view layoutIfNeeded];
    }];
}
- (void)keyboardShow:(NSNotification *)aNotification {
    NSDictionary *userInfo = [aNotification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    NSInteger height = keyboardRect.size.height;
    [UIView animateWithDuration:0.1 animations:^{
        [self.footerView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.view).offset(-(height + 10));
        }];
        [self.view layoutIfNeeded];
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArr.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataArr[section] count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    InputCell *cell = [tableView dequeueReusableCellWithIdentifier:idt forIndexPath:indexPath];
    cell.model = self.dataArr[indexPath.section][indexPath.row];
    cell.delegate = self;
    return cell;
}

- (UITableView *)tableview {
    if (_tableview == nil) {
        _tableview = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableview.tableFooterView = [[UIView alloc] init];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.rowHeight = 44;
        [_tableview registerClass:[InputCell class] forCellReuseIdentifier:idt];
        [self.view addSubview:_tableview];
        [_tableview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(self.view);
            make.bottom.equalTo(self.footerView.mas_top).offset(-10);
        }];
    }
    return _tableview;
}
- (FooterView *)footerView {
    if (_footerView == nil) {
        _footerView = [[FooterView alloc] init];
        _footerView.delegate = self;
        [self.view addSubview:_footerView];
        [_footerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view).offset(10);
            make.right.equalTo(self.view).offset(-10);
            make.bottom.equalTo(self.view).offset(-10);
            make.height.mas_equalTo(44);
        }];
    }
    return _footerView;
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
