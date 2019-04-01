
//
//  GetCityView.m
//  AFNetworking
//
//  Created by admin on 2019/3/29.
//

#import "GetCityView.h"
#import "MJExtension.h"
#import "Masonry.h"
typedef NS_ENUM(NSInteger,AddressType) {
    AddressTypeProvince,
    AddressTypeCity,
    AddressTypeArear
};
@interface GetCityView()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic, strong)NSArray *datArr;
@property(nonatomic, strong)UITableView *tableview;
@property(nonatomic, strong)UIView *heaerView;
@property(nonatomic, assign)BOOL isProvince;
@property(nonatomic, assign)BOOL isCity;
@property(nonatomic, assign)BOOL isArear;
@property(nonatomic, strong)ProvinceModel *provinceModel;
@property(nonatomic, strong)QH_CityModel *cityModel;
@property(nonatomic, strong)QH_ArearModel *arearModel;

@property(nonatomic, strong)NSArray *provinceArr;
@property(nonatomic, strong)NSArray *cityArr;
@property(nonatomic, assign)AddressType type;
@property(nonatomic, strong)UIButton *cancelButton;
@property(nonatomic, strong)UIButton *confirmButton;
@property(nonatomic, strong)UILabel *titleLabel;

@property(nonatomic, strong)UIButton *provinceButton;
@property(nonatomic, strong)UIButton *cityButton;
@property(nonatomic, strong)UIButton *arearButton;

@end

@implementation GetCityView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"cities" ofType:@"json"];
        NSData *data = [[NSData alloc] initWithContentsOfFile:path];
        NSArray *arr = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        //    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:path];
        self.datArr = [ProvinceModel mj_objectArrayWithKeyValuesArray:arr];
        
        self.type = AddressTypeProvince;
        
        self.provinceArr = self.datArr;
        self.isProvince = true;
        self.isCity = false;
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        window.frame = [UIScreen mainScreen].bounds;
        window.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.5];
        self.frame = window.bounds;
        [window addSubview:self];
        [self tableview];
        [self confirmButton];
        [self cancelButton];
        [self titleLabel];
    }
    return self;
}
- (UIButton *)provinceButton {
    if (_provinceButton == nil) {
        _provinceButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_provinceButton];
    }
    return _provinceButton;
}
- (UIButton *)cancelButton {
    if (_cancelButton == nil) {
        _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [_cancelButton addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
        [self.heaerView addSubview:_cancelButton];
        [_cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.heaerView).offset(7.5);
            make.centerY.equalTo(self.heaerView);
            make.size.mas_equalTo(CGSizeMake(40, 40));
        }];
    }
    return _cancelButton;
}
- (void)cancelAction {
    [self dimiss];
}
- (void)dimiss {
    [self removeFromSuperview];
}
- (void)confirmAction {
    if (self.delegate) {
        [self.delegate provice:self.provinceModel city:self.cityModel area:self.arearModel];
    }
    if (self.type == AddressTypeCity) {
        self.datArr = self.provinceArr;
        self.isProvince = true;
    }else if (self.type == AddressTypeArear) {
        self.datArr = self.cityArr;
        self.isCity = true;
        self.type = AddressTypeCity;
    }
    [self.tableview reloadData];
    [self dimiss];
}
- (UIButton *)confirmButton {
    if (_confirmButton == nil) {
        _confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_confirmButton setTitle:@"确定" forState:UIControlStateNormal];
        [_confirmButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_confirmButton addTarget:self action:@selector(confirmAction) forControlEvents:UIControlEventTouchUpInside];
        [self.heaerView addSubview:_confirmButton];
        [_confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.heaerView).offset(-7.5);
            make.centerY.equalTo(self.cancelButton);
            make.size.equalTo(self.cancelButton);
        }];
    }
    return _confirmButton;
}
- (UILabel *)titleLabel {
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = @"选择城市";
        [self.heaerView addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.heaerView);
        }];
    }
    return _titleLabel;
}
- (UIView *)heaerView {
    if (_heaerView == nil) {
        _heaerView = [[UIView alloc] init];
        _heaerView.backgroundColor = [UIColor orangeColor];
        [self addSubview:_heaerView];
        [_heaerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.height.equalTo(@44);
            make.top.equalTo(self).offset(100);
        }];
    }
    return _heaerView;
}
- (UITableView *)tableview {
    if (_tableview == nil) {
        _tableview = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        [_tableview registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        [self addSubview:_tableview];
        [_tableview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self);
            make.top.equalTo(self.heaerView.mas_bottom);
        }];
    }
    return _tableview;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datArr.count;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.isProvince) {
        ProvinceModel *provinceModel = self.datArr[indexPath.row];
        self.datArr = provinceModel.children;
        self.cityArr = self.datArr;
        self.isCity = true;
        self.isProvince = false;
        self.provinceModel = provinceModel;
        self.type = AddressTypeCity;
    }else if(self.isCity) {
        QH_CityModel *cityModel = self.datArr[indexPath.row];
        self.datArr = cityModel.children;
        self.isCity = false;
        self.cityModel = cityModel;
        self.type = AddressTypeArear;
    }else {
        QH_ArearModel *arearModel = self.datArr[indexPath.row];
        self.isArear = true;
        self.arearModel = arearModel;
    }
    [tableView reloadData];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if (self.isProvince) {
        ProvinceModel *model = self.datArr[indexPath.row];
        cell.textLabel.text = model.value;
    }else if (self.isCity) {
        QH_CityModel *model = self.datArr[indexPath.row];
        cell.textLabel.text = model.value;
    }else {
        QH_ArearModel *model = self.datArr[indexPath.row];
        cell.textLabel.text = model.value;
    }
    return cell;
}
@end
