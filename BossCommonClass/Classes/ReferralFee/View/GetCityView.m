
//
//  GetCityView.m
//  AFNetworking
//
//  Created by admin on 2019/3/29.
//

#import "GetCityView.h"
#import "MJExtension.h"
#import "Masonry.h"
#import "JYCMethodDefine.h"
#import "BossMethodDefine.h"
#import "UIView+ShowView.h"

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

/**
 用于显示省市区
 */
@property(nonatomic, strong)UIView *contentView;
@property(nonatomic, strong)UIView *lineView;

@property(nonatomic, strong)UIView *indexView;

@property(nonatomic, assign)NSInteger index;

@end

@implementation GetCityView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        NSString *cityPath = [[NSBundle bundleForClass:[self class]].resourcePath stringByAppendingPathComponent:@"/BossCommonClass.bundle"];
        
        NSString *path = [QH_Bundle pathForResource:@"cities" ofType:@"json"];
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
        self.frame = window.bounds;
        self.backgroundColor = [UIColor colorWithWhite:0.2 alpha:0.5];
        [window addSubview:self];
        [self tableview];
        [self confirmButton];
        [self cancelButton];
        [self titleLabel];
        [self contentView];
        [self provinceButton];
        [self cityButton];
        [self arearButton];
        [self lineView];
//        [self indexView];
    }
    self.index = -1;
    return self;
}
- (UIView *)contentView {
    if (_contentView == nil) {
        _contentView = [[UIView alloc] init];
        _contentView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_contentView];
        [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.height.equalTo(@44);
            make.top.equalTo(self.heaerView.mas_bottom);
        }];
    }
    return _contentView;
}
- (UIView *)lineView {
    if (_lineView == nil) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:_lineView];
        [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(self.contentView);
            make.height.equalTo(@(1 / UIScreen.mainScreen.scale));
        }];
    }
    return _lineView;
}
- (UIButton *)provinceButton {
    if (_provinceButton == nil) {
        _provinceButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _provinceButton.tag = 10;
        [_provinceButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [_provinceButton setTitleColor:[UIColor colorWithRed:53/255.0 green:137/255.0 blue:222/255.0 alpha:1.0] forState:UIControlStateNormal];
        [_provinceButton setTitle:@"请选择" forState:UIControlStateNormal];
        [self.contentView addSubview:_provinceButton];
        [_provinceButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(10);
            make.centerY.equalTo(self.contentView);
        }];
    }
    return _provinceButton;
}
- (UIButton *)cityButton {
    if (_cityButton == nil) {
        _cityButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _cityButton.tag = 20;
        [_cityButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [_cityButton setTitleColor:kHexRGB(0x3589DE) forState:UIControlStateNormal];
        [_cityButton setTitle:@"请选择" forState:UIControlStateNormal];
        _cityButton.hidden = true;
        [self.contentView addSubview:_cityButton];
        [_cityButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.provinceButton.mas_right).offset(10);
            make.centerY.equalTo(self.provinceButton);
        }];
    }
    return _cityButton;
}
- (UIButton *)arearButton {
    if (_arearButton == nil) {
        _arearButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _arearButton.tag = 30;
        [_arearButton setTitleColor:kHexRGB(0x3589DE) forState:UIControlStateNormal];
        [_arearButton setTitle:@"请选择" forState:UIControlStateNormal];
        _arearButton.hidden = true;
        [_arearButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_arearButton];
        [_arearButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.provinceButton);
            make.left.equalTo(self.cityButton.mas_right).offset(10);
        }];
    }
    return _arearButton;
}
- (void)buttonAction:(UIButton *)button {
    if (button.tag == 10) {//省
        self.provinceButton.hidden = false;
        self.cityButton.hidden = true;
        self.arearButton.hidden = true;
        self.datArr = self.provinceArr;
        self.isProvince = true;
        self.isCity = false;
        self.isArear = false;
    }else if (button.tag == 20) {//市
        self.provinceButton.hidden = false;
        self.cityButton.hidden = false;
        self.arearButton.hidden = true;
        self.datArr = self.cityArr;
        self.isProvince = false;
        self.isCity = true;
        self.isArear = false;
    }else {//区
        self.provinceButton.hidden = false;
        self.cityButton.hidden = false;
        self.arearButton.hidden = false;
        self.isProvince = false;
        self.isCity = false;
        self.isArear = true;
    }
    [self.tableview reloadData];
}
- (UIView *)indexView {
    if (_indexView == nil) {
        _indexView = [[UIView alloc] init];
        _indexView.backgroundColor = kHexRGB(0xD8D8D8);
        [self.contentView addSubview:_indexView];
        [_indexView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.provinceButton);
            make.width.equalTo(self.provinceButton);
            make.height.equalTo(@1);
            make.bottom.equalTo(self.contentView);
        }];
    }
    return _indexView;
}
- (UIButton *)cancelButton {
    if (_cancelButton == nil) {
        _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        _cancelButton.titleLabel.font = [UIFont systemFontOfSize:14];
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
    NSLog(@"%@",self.cityModel.code);
    if (!self.cityModel.code ) {
//        self.cityModel.code = @"0";
//        self.cityModel.value = @"";
        
        if ([self.provinceModel.label containsString:@"香港"] || [self.provinceModel.label containsString:@"澳门"]) {
            self.cityModel.code = @"0";
//            self.cityModel.label = @"";
//            self.cityModel.value = @"";
        }else {
           [self showSuccessStaus:@"请选择市"];
            return;
        }
        
    }
    if (!self.arearModel.code) {
//        self.arearModel.code = @"0";
//        self.arearModel.value = @"";
        if ([self.provinceModel.label containsString:@"香港"] || [self.provinceModel.label containsString:@"澳门"]) {
            self.arearModel.code = @"0";
//            self.arearModel.label = @"";
//            self.arearModel.value = @"";
        }else {
            [self showSuccessStaus:@"请选择区"];
            return;
        }
        
    }
    NSLog(@"%@",self.arearModel.value);
    if (self.delegate) {
        NSLog(@"%@",self.cityModel.value);
        NSLog(@"%@",self.cityModel.label);
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
        _confirmButton.titleLabel.font = [UIFont systemFontOfSize:14];
        _confirmButton.enabled = false;
        [_confirmButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [_confirmButton setTitle:@"确定" forState:UIControlStateNormal];
//        [_confirmButton setTitleColor:kHexRGB(0x1FB1FF) forState:UIControlStateNormal];
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
        _heaerView.backgroundColor = [UIColor whiteColor];
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
        _tableview.tableFooterView = [UIView new];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        [_tableview registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        [self addSubview:_tableview];
        [_tableview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self);
            make.top.equalTo(self.contentView.mas_bottom);
        }];
    }
    return _tableview;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datArr.count;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.confirmButton.enabled = true;
    [self.confirmButton setTitleColor:kHexRGB(0x1FB1FF) forState:UIControlStateNormal];
    if (self.isProvince) {
        ProvinceModel *provinceModel = self.datArr[indexPath.row];
        self.datArr = provinceModel.children;
        self.cityArr = self.datArr;
        self.isCity = true;
        self.isProvince = false;
        self.provinceModel = provinceModel;
        self.type = AddressTypeCity;
        self.cityButton.hidden = true;
        self.arearButton.hidden = true;
        [self.provinceButton setTitle:provinceModel.value forState:UIControlStateNormal];
    }else if(self.isCity) {
        QH_CityModel *cityModel = self.datArr[indexPath.row];
        self.datArr = cityModel.children;
        self.isCity = false;
        self.cityModel = cityModel;
        self.type = AddressTypeArear;
        self.cityButton.hidden = false;
        [self.cityButton setTitle:cityModel.value forState:UIControlStateNormal];
//        self.provinceButton.hidden = true;
        self.arearButton.hidden = true;
    }else {
        QH_ArearModel *arearModel = self.datArr[indexPath.row];
        self.isArear = true;
        self.arearModel = arearModel;
        self.arearButton.hidden = false;
        [self.arearButton setTitle:arearModel.value forState:UIControlStateNormal];
    }
    self.index = indexPath.row;
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
    UIImage *markImage = [UIImage imageNamed:@"checkmark" inBundle:QH_Bundle  compatibleWithTraitCollection:nil];
    
    UIImageView *imgView = [[UIImageView alloc] init];
    imgView.image = markImage;
    imgView.frame = CGRectMake(0, 0, 15, 15);
    cell.accessoryView = imgView;
    if (self.index == indexPath.row) {
        [cell setSelected:true];
    }
    cell.accessoryView.hidden = !cell.selected;
    return cell;
}
@end
