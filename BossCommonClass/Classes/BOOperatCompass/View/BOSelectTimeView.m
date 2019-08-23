//
//  BOSelectTimeView.m
//  BossKnight
//
//  Created by admin on 2019/7/19.
//  Copyright © 2019 贾远潮. All rights reserved.
//

#import "BOSelectTimeView.h"
#import "JYCMethodDefine.h"
#import "BossMethodDefine.h"

@interface BOSelectTimeView ()

@property (nonatomic, strong) UILabel *timeLab;
@property (nonatomic, strong) UILabel *businessDistrictLab;
@property (nonatomic, strong) UIImageView *arrowView;
@property (nonatomic, strong) UIImageView *districtArrowView;

@end

@implementation BOSelectTimeView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if(self = [super initWithFrame:frame]){
        
        self.backgroundColor = kHexRGB(0xF9FBFC);
        [self setupTimeLabel];
        [self setupBusinessDistrict];
        
    }
    return self;
}

- (void)setupTimeLabel {
    //        self.timeLab = [[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth-140)*0.5, 0, 120, 64)];
    self.timeLab = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, 120, 64)];
    self.timeLab.font = BossBlodFont(24);
    self.timeLab.textColor = kHexRGB(0x1A9CFF);
    NSCalendar *calendar = [[NSCalendar alloc]
                            initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth;
    NSDateComponents *comp = [calendar components: unitFlags fromDate:[NSDate date]];
    self.timeLab.text = [NSString stringWithFormat:@"%02ld-%02ld",2019,6];
    self.timeLab.textAlignment = NSTextAlignmentRight;
    self.timeLab.userInteractionEnabled = true;
    [self addSubview:self.timeLab];
    
    self.arrowView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.timeLab.frame)+10 , (64-14)*0.5, 9, 14)];
    self.arrowView.image = [UIImage imageNamed:@"teamrightIcon"];
    self.arrowView.userInteractionEnabled = true;
    [self addSubview:self.arrowView];
    
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(openSelectePickView)];
    [self.timeLab addGestureRecognizer:tapRecognizer];
    
}

- (void)setupBusinessDistrict {
    self.businessDistrictLab = [[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth-170)*0.5, 0, 120, 64)];
    self.businessDistrictLab  = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, 120, 64)];
    self.businessDistrictLab.font = BossBlodFont(24);
    self.businessDistrictLab.textColor = kHexRGB(0x1A9CFF);
    self.businessDistrictLab.text = [NSString stringWithFormat:@"%@",self.businessDistrictStr];
    self.businessDistrictLab.textAlignment = NSTextAlignmentRight;
    self.businessDistrictLab.userInteractionEnabled = true;
    [self addSubview:self.businessDistrictLab];
    
    self.districtArrowView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.businessDistrictLab.frame)+10 , (64-14)*0.5, 9, 14)];
    self.districtArrowView.image = [UIImage imageNamed:@"teamrightIcon"];
    self.districtArrowView.userInteractionEnabled = true;
    [self addSubview:self.districtArrowView];
    
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(openSelecteDistrictPickView)];
    [self.districtArrowView addGestureRecognizer:tapRecognizer];
    
}

- (void)openSelectePickView
{
    if(self.openSelectBlock)
    {
        self.openSelectBlock();
    }
}

- (void)openSelecteDistrictPickView {
    NSLog(@"点击了选择商圈");
}

- (void)setSelectTimeStr:(NSString *)selectTimeStr
{
    _selectTimeStr = selectTimeStr;
    self.timeLab.text = selectTimeStr;
}

@end
