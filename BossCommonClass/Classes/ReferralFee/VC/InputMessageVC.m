
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
#import "BossMethodDefine.h"



@interface InputMessageVC ()<UITableViewDelegate,UITableViewDataSource>




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
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"编辑" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(rightAction) forControlEvents:UIControlEventTouchUpInside];
    button.hidden = self.isDetail ? false : true;
    if (self.index == 0) {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    }else {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:[UIView new]];
    }
    self.title = self.isDetail ? @"推荐信息":@"我要推荐";
    if (self.isDetail) {
        [self getRecommendDetail];
    }
    
}

- (void)getRecommendDetail {
  
    [ReferralFeeRequest recommendDetail:self.listModel._id isEntry: self.isEntry success:^(NSArray * _Nonnull list) {
        self.dataArr = list;
        self.listArr = list;
       
        [self.tableview reloadData];
    } detailModel:^(RecommendDetailModel * _Nonnull model) {
        self.model.app_type = model.app_type;
        self.model.position_id = model.position_id;
        self.model.name = model.name;
        self.model.age = model.age;
        self.model.phone = model.phone;
        self.model.province = model.province;
        self.model.city = model.city;
        self.model.area = model.area;
        self.model.detailed_address = model.detailed_address;
        self.model.position_id = model.position_id;
        self.model.working_state = model.working_state;
        self.model.work_experience = model.work_experience;
        self.model.identity_card_id = model.identity_card_id;
        self.model._id = model._id;
    } fail:^{
        
    }];
}

- (void)cityView {
    GetCityView *view = [[GetCityView alloc] init];
    view.delegate = self;
}
- (void)rightAction {
    self.isDetail = !self.isDetail;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:[UIView new]];
    if (self.isDetail) {
        self.dataArr = self.listArr;
       
    }else {

        self.dataArr = [InputMessageModel getModelArr];
        for (NSArray *arr in self.dataArr) {
            for (InputMessageModel *model in arr) {
                switch (model.type) {
                    case InputTypeRole:
                        model.text = @"骑士";
                        break;
                    case InputTypeName:
                        model.text = self.model.name;
//                        model.text = @"姓名";
                        break;
                    case InputTypeAge:{
                        if (self.model.age == 0) {
                            model.text = @"未填写";
                        }else {
                            model.text = [NSString stringWithFormat:@"%ld",self.model.age];
                        }
                        
                    }
                        
//                        model.text = @"年龄";
                        break;
                    case InputTypeAddress: {

                        NSString *path = [QH_Bundle pathForResource:@"cities" ofType:@"json"];
                        NSData *data = [[NSData alloc] initWithContentsOfFile:path];
                        NSArray *arr = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                        NSString *addStr = @"";
                        for (NSDictionary *dic in arr) {
                            if ([dic[@"code"] integerValue] == self.model.province) {
                                addStr = dic[@"value"];
                                NSArray *cities = dic[@"children"];
                                for (NSDictionary *cityDic in cities) {
                                    if ([cityDic[@"code"] integerValue] == self.model.city) {
                                        
                                        addStr = [addStr stringByAppendingString:cityDic[@"value"]];
                                        NSArray *areas = cityDic[@"children"];
                                        
                                        for (NSDictionary *areaDic in areas) {
                                            NSLog(@"%@",areaDic[@"code"]);
                                            if ([areaDic[@"code"] integerValue] == self.model.area) {
                                                NSLog(@"%@",areaDic[@"value"]);
                                                addStr = [addStr stringByAppendingString:areaDic[@"value"]];
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        model.text = addStr;
                    }
                        
//                        model.text = @"地址";
                        break;
                    case InputTypeDetailAddress:
                        model.text = self.model.detailed_address;
                        break;
                    case InputTypePhone:
                        model.text = self.model.phone;
                        break;
                    case InputTypeWorkState: {
                        if (self.model.working_state == 100) {
                            model.text = @"在职";
                        }else if (self.model.working_state == -100) {
                            model.text = @"离职";
                        }else {
                            model.text = @"未填写";
                        }
                       
                    }
                        
                        break;
                    case InputTypeWorkingExperience: {
                        if (self.model.work_experience == 50) {
                            model.text = @"有";
                        }else if (self.model.work_experience == -50) {
                            model.text = @"无";
                        }else {
                            model.text = @"未填写";
                        }
                    }
                        
                        
                        break;
                    case InputTypeIdNumber:
                        model.text = self.model.identity_card_id;
                        break;
                    default:
                        break;
                }
            }
        }
        NSLog(@"%@",self.listArr);
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
        [self.tableview mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.footerView.mas_top).offset( -10);
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
//        [self.footerView mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.bottom.equalTo(self.view).offset(-(height + 10));
//        }];
        [self.tableview mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.footerView.mas_top).offset(-(height  - 58));
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
//        _tableview.scrollEnabled = false;
        _tableview.tableFooterView = [[UIView alloc] init];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.rowHeight = 52;
        UITapGestureRecognizer *tapgesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
        [_tableview addGestureRecognizer:tapgesture];
        [_tableview registerClass:[InputCell class] forCellReuseIdentifier:idt];
        [self.view addSubview:_tableview];
        [_tableview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(self.view);
            make.bottom.equalTo(self.footerView.mas_top).offset(-10);
        }];
    }
    return _tableview;
}
- (void)tapAction {
    [self.view endEditing:YES];
}
- (FooterView *)footerView {
    if (_footerView == nil) {
        _footerView = [[FooterView alloc] init];
        _footerView.delegate = self;
        [self.view addSubview:_footerView];
        [_footerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view).offset(10);
            make.right.equalTo(self.view).offset(-10);
            make.bottom.equalTo(self.view).offset(-16);
            make.height.mas_equalTo(44);
        }];
    }
    return _footerView;
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
