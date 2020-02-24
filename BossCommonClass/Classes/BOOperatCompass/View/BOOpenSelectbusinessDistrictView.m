//
//  BOOpenSelectTimeView.m
//  BossKnight
//
//  Created by admin on 2019/7/21.
//

#import "BOOpenSelectbusinessDistrictView.h"
#import "BossBasicDefine.h"
#import "TeamListModel.h"
@interface BOOpenSelectbusinessDistrictView()<UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate>

{
    UIView *topV;
}
@property (nonatomic, strong) UIPickerView *pickerView;
@property (nonatomic,strong)NSArray *dataArr;
@property NSInteger currentRow;

@end

@implementation BOOpenSelectbusinessDistrictView


-(void)canCelBtnAction
{
    [self remove];
    if(self.cancelSelectBlock)
    {
        self.cancelSelectBlock();
    }
}

- (void)setupData:(NSArray *)showData {
    self.dataArr = showData;
    [self.pickerView reloadAllComponents];
}

-(void)sureButtonAction
{
    [self remove];
    if (self.sureSelectBlock)
    {
        TeamListModel *list  = self.dataArr[self.currentRow];
 
        self.sureSelectBlock(list.bizDistrictName, list.biz_district_id);
    }
}

- (instancetype)init
{
    self = [super initWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth, kScreenHeight)];
    if (self) {
        
        self.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.3];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(canCelBtnAction)];
        [self addGestureRecognizer:tap];
        topV = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight - 44-207+kScreenHeight, kScreenWidth, 44)];
        topV.backgroundColor = kHexRGBA(0xFBFBFB, 1.0);
        [self addSubview:topV];
        
        UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        cancelBtn.frame = CGRectMake(0, 0, 100, 44);
        [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [cancelBtn setTitleColor:kHexRGB(0x1A9CFF) forState:UIControlStateNormal];
        [cancelBtn addTarget:self action:@selector(canCelBtnAction) forControlEvents:UIControlEventTouchUpInside];
        
        [cancelBtn.titleLabel setFont: BossRegularFont(16)];
        [topV addSubview:cancelBtn];
        
        UIButton *yesBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        yesBtn.frame = CGRectMake(kScreenWidth - 100, 0, 100, 44);
        [yesBtn setTitle:@"完成" forState:UIControlStateNormal];
        [yesBtn setTitleColor:kHexRGB(0x1A9CFF) forState:UIControlStateNormal];
        [yesBtn.titleLabel setFont:BossRegularFont(16)];
        [yesBtn addTarget:self action:@selector(sureButtonAction) forControlEvents:UIControlEventTouchUpInside];
        
        [topV addSubview:yesBtn];
       
        
        _pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(topV.frame), kScreenWidth, 207)];
        _pickerView.dataSource = self;
        _pickerView.delegate = self;
        _pickerView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_pickerView];
        
    }
    return self;
}

#pragma mark -UIPickerView
#pragma mark UIPickerView的数据源
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.dataArr.count;
}

-(void)show
{
    [UIView animateWithDuration:0.25 animations:^{
        self.frame =  CGRectMake(0, 0, kScreenWidth, kScreenHeight);
        topV.frame = CGRectMake(0, kScreenHeight - 44-207, kScreenWidth, 44);
        _pickerView.frame = CGRectMake(0, CGRectGetMaxY(topV.frame), kScreenWidth, 207);
    }];
}

- (void)remove
{
    [UIView animateWithDuration:0.25 animations:^{
        self.frame =  CGRectMake(0, kScreenHeight, kScreenWidth, kScreenHeight);
        topV.frame = CGRectMake(0, kScreenHeight, kScreenWidth, 44);
        _pickerView.frame = CGRectMake(0, CGRectGetMaxY(topV.frame), kScreenWidth,207);
        
    } completion:^(BOOL finished) {
        
        //        [self removeFromSuperview];
    }];
    
}
#pragma mark -UIPickerView的代理

// 滚动UIPickerView就会调用
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    self.currentRow = row;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{

    //设置文字的属性
    UILabel *genderLabel = [[UILabel alloc] init];
    genderLabel.textAlignment = NSTextAlignmentCenter;
    
//    genderLabel.textColor = kHexRGB(0x1A9CFF);
    genderLabel.textColor = [UIColor colorWithRed:41/255.0f green:49/255.0f blue:77/255.0f alpha:1];
    
    genderLabel.font = BossRegularFont(16);
   
    TeamListModel *list  = self.dataArr[row];
    
    genderLabel.text = list.bizDistrictName;
    
    return genderLabel;
}

@end
