//
//  BOOpenSelectTimeView.m
//  BossKnight
//
//  Created by admin on 2019/7/21.
//  Copyright © 2019 贾远潮. All rights reserved.
//

#import "BOOpenSelectbusinessDistrictView.h"
#import "BossBasicDefine.h"

@interface BOOpenSelectbusinessDistrictView()<UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate>

{
    NSInteger yearIndex;
    
    NSInteger monthIndex;
    
    UIView *topV;
}
@property (nonatomic, strong) UIPickerView *pickerView;

@property (nonatomic, strong) NSMutableArray *yearArray;

@property (nonatomic, strong) NSMutableArray *monthArray;
@property (nonatomic, strong) NSMutableArray *firstMonthArray;


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

-(void)sureButtonAction
{
    [self remove];
    if (self.sureSelectBlock)
    {
        NSString *year = [self.yearArray objectAtIndex:0];
        NSString *mouth = [self.monthArray objectAtIndex:monthIndex];
        //        if(yearIndex == 0)
        //        {
        //            mouth = [self.firstMonthArray objectAtIndex:monthIndex];
        //        }
        year = [year stringByReplacingOccurrencesOfString:@"年" withString:@""];
        mouth = [mouth stringByReplacingOccurrencesOfString:@"月" withString:@""];
        self.sureSelectBlock(year, mouth);
    }
}

- (NSMutableArray *)yearArray {
    
    if (_yearArray == nil) {
        
        _yearArray = [NSMutableArray array];
        
        for (int year = 2019; year <= 2019; year++) {
            
            NSString *str = [NSString stringWithFormat:@"%d年", year];
            
            [_yearArray addObject:str];
        }
    }
    
    return _yearArray;
}
- (NSMutableArray *)monthArray
{
    
    if (_monthArray == nil) {
        
        _monthArray = [NSMutableArray array];
        
        for (int month = 5; month <= 6; month++)
        {
            
            NSString *str = [NSString stringWithFormat:@"%02d月", month];
            
            [_monthArray addObject:str];
        }
        
    }
    
    return _monthArray;
}

- (NSMutableArray *)firstMonthArray
{
    
    if (_firstMonthArray == nil) {
        
        _firstMonthArray = [NSMutableArray array];
        
        for (int month = 5; month <= 6; month++)
        {
            
            NSString *str = [NSString stringWithFormat:@"%02d月", month];
            
            [_firstMonthArray addObject:str];
        }
        
    }
    
    return _firstMonthArray;
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
        /*
         
         [cancelBtn click:^(UIView *view) {
         
         if (_block) {
         _block(nil);
         }
         
         [self remove];
         }];
         
         [yesBtn click:^(UIView *view) {
         
         if (_block) {
         
         NSString *timeStr = [NSString stringWithFormat:@"%@%@%@",((UILabel *)[_pickerView viewForRow:yearIndex forComponent:0]).text, ((UILabel *)[_pickerView viewForRow:monthIndex forComponent:1]).text, ((UILabel *)[_pickerView viewForRow:dayIndex forComponent:2]).text];
         
         
         timeStr = [timeStr stringByReplacingOccurrencesOfString:@"年" withString:@"/"];
         
         timeStr = [timeStr stringByReplacingOccurrencesOfString:@"月" withString:@"/"];
         
         timeStr = [timeStr stringByReplacingOccurrencesOfString:@"日" withString:@""];
         
         _block(timeStr);
         
         }
         [self remove];
         }];
         
         [self click:^(UIView *view) {
         
         if (_block) {
         _block(nil);
         }
         [self remove];
         }];
         */
        
        _pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(topV.frame), kScreenWidth, 207)];
        _pickerView.dataSource = self;
        _pickerView.delegate = self;
        _pickerView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_pickerView];
        
        NSCalendar *calendar = [[NSCalendar alloc]
                                initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        // 定义一个时间字段的旗标，指定将会获取指定年、月、日、时、分、秒的信息
        unsigned unitFlags = NSCalendarUnitYear |
        NSCalendarUnitMonth |  NSCalendarUnitDay |
        NSCalendarUnitHour |  NSCalendarUnitMinute |
        NSCalendarUnitSecond | NSCalendarUnitWeekday;
        // 获取不同时间字段的信息
        NSDateComponents *comp = [calendar components: unitFlags fromDate:[NSDate date]];
        
        yearIndex = [self.yearArray indexOfObject:[NSString stringWithFormat:@"%ld年", comp.year]];
        monthIndex = [self.firstMonthArray indexOfObject:[NSString stringWithFormat:@"%02ld月", comp.month]];
        
        [_pickerView selectRow:yearIndex inComponent:0 animated:YES];
        [_pickerView selectRow:0 inComponent:1 animated:YES];
        
        [self pickerView:_pickerView didSelectRow:yearIndex inComponent:0];
        [self pickerView:_pickerView didSelectRow:monthIndex inComponent:1];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            UILabel *label = (UILabel *)[_pickerView viewForRow:yearIndex forComponent:0];
            label.textColor =kHexRGB(0x1A9CFF);
            label.font = BossRegularFont(16);
            
            label = (UILabel *)[_pickerView viewForRow:monthIndex forComponent:1];
            label.textColor = kHexRGB(0x1A9CFF);
            label.font = BossRegularFont(16);
            
            
        });
        
        //        [UIView animateWithDuration:0.25 animations:^{
        //
        //            topV.frame = CGRectMake(0, kScreenHeight - 44-207, kScreenWidth, 44);
        //            _pickerView.frame = CGRectMake(0, CGRectGetMaxY(topV.frame), kScreenWidth, 207);
        //        }];
        
    }
    return self;
}

#pragma mark -UIPickerView
#pragma mark UIPickerView的数据源
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0) {
        return self.yearArray.count;
        
    }else {
        if(yearIndex == 0)
        {
            return self.firstMonthArray.count;
        }
        return self.monthArray.count;
    }
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
    if (component == 0) {
        yearIndex = 0;
        //        yearIndex = row;
        //        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //
        //
        //            UILabel *label = (UILabel *)[pickerView viewForRow:row forComponent:component];
        //            label.textColor = kHexRGB(0x1A9CFF);
        //            label.font = BossRegularFont(16);
        //
        //        });
        //
        //        [pickerView reloadComponent:1];
        
        
    } else
    {
        if (monthIndex > 1){
            monthIndex = 0;
        }else {
            monthIndex = row;
        }
        //        [pickerView reloadComponent:2];
        
    }
    /*
     else if (component == 1) {
     
     monthIndex = row;
     
     [pickerView reloadComponent:2];
     
     
     if (monthIndex + 1 == 4 || monthIndex + 1 == 6 || monthIndex + 1 == 9 || monthIndex + 1 == 11) {
     
     if (dayIndex + 1 == 31) {
     
     dayIndex--;
     }
     }else if (monthIndex + 1 == 2) {
     
     if (dayIndex + 1 > 28) {
     dayIndex = 27;
     }
     }
     [pickerView selectRow:dayIndex inComponent:2 animated:YES];
     
     dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
     
     UILabel *label = (UILabel *)[pickerView viewForRow:row forComponent:component];
     label.textColor = RGBACOLOR(26, 174, 135, 1.0);
     label.font = regularFontWithSize(16);
     
     label = (UILabel *)[pickerView viewForRow:dayIndex forComponent:2];
     label.textColor = RGBACOLOR(26, 174, 135, 1.0);
     label.font = regularFontWithSize(16);
     
     });
     }else {
     
     dayIndex = row;
     dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
     
     UILabel *label = (UILabel *)[pickerView viewForRow:row forComponent:component];
     label.textColor = RGBACOLOR(26, 174, 135, 1.0);
     label.font = regularFontWithSize(16);
     
     });
     }
     
     */
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    //    //设置分割线的颜色
    //    for(UIView *singleLine in pickerView.subviews)
    //    {
    //        if (singleLine.frame.size.height < 1)
    //        {
    //            singleLine.backgroundColor = kSingleLineColor;
    //        }
    //    }
    
    //设置文字的属性
    UILabel *genderLabel = [[UILabel alloc] init];
    genderLabel.textAlignment = NSTextAlignmentCenter;
    
    genderLabel.textColor = kHexRGB(0x1A9CFF);
    
    genderLabel.font = BossRegularFont(16);
    if (component == 0)
    {
        genderLabel.text = self.yearArray[row];
    }else
    {
        if (yearIndex == 0)
        {
            genderLabel.text = self.firstMonthArray[row];
            
        }else
        {
            genderLabel.text = self.monthArray[row];
            
        }
        
    }
    
    return genderLabel;
}

@end
