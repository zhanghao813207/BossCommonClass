//
//  BOSelectTimeView.m
//  BossKnight
//
//  Created by admin on 2019/7/19.
//

#import "BOSelectTimeView.h"
#import "JYCMethodDefine.h"
#import "BossMethodDefine.h"
#import "Masonry.h"

@interface BOSelectTimeView ()

@property (nonatomic, strong) UILabel *timeLab;
@property (nonatomic, strong) UILabel *businessDistrictLab;
@property (nonatomic, strong) UIImageView *arrowView;
@property (nonatomic, strong) UIImageView *districtArrowView;

@end

@implementation BOSelectTimeView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if(self = [super initWithFrame:frame]){
        self.backgroundColor = kHexRGB(0xf0f2f5);
        [self setupTimeLabel];
#ifdef kBossOwner
        [self setupBusinessDistrict];
#endif
    }
    return self;
}

- (void)setupDefault:(NSString *)title {
    self.businessDistrictLab.text = title;
}

- (void)setupTimeLabel {
#ifdef kBossKnight
    // 骑士
    self.timeLab = [[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth-176)*0.5, 0, 120, 44)];
#elif defined kBossOwner
    // 老板
    self.timeLab = [[UILabel alloc]initWithFrame:CGRectMake(16, 0, 120, 44)];
#else
    // 之家
    self.timeLab = [[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth-176)*0.5, 0, 120, 44)];
#endif
    self.timeLab.font = BossBlodFont(18);
    self.timeLab.textColor = kHexRGB(0x1A9CFF);
    NSCalendar *calendar = [[NSCalendar alloc]
                            initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth;
    NSDateComponents *comp = [calendar components: unitFlags fromDate:[NSDate date]];
    NSDate *date =[NSDate date];//简书 FlyElephant
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];

    [formatter setDateFormat:@"yyyy"];
    // 最大年份为当前年份
    int currentYear = [[formatter stringFromDate:date] intValue];
    [formatter setDateFormat:@"MM"];
    // 最大时间为当前月份 -1
    int currentMonth = [[formatter stringFromDate:date] intValue] - 1;
    
    self.timeLab.text = [NSString stringWithFormat:@"%d-%.2d",currentYear,currentMonth];
    self.timeLab.textAlignment = NSTextAlignmentRight;
    self.timeLab.userInteractionEnabled = true;
    [self addSubview:self.timeLab];
    
    self.arrowView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.timeLab.frame)+10 , (44-14)*0.5, 9, 14)];
    self.arrowView.image = [UIImage imageNamed:@"teamrightIcon"];
    self.arrowView.userInteractionEnabled = true;
    [self addSubview:self.arrowView];
    
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(openSelectePickView)];
    [self.timeLab addGestureRecognizer:tapRecognizer];
    
}

- (void)setupBusinessDistrict {
    self.businessDistrictLab = [[UILabel alloc]init];

    self.businessDistrictLab.font = BossBlodFont(18);
    self.businessDistrictLab.textColor = kHexRGB(0x1A9CFF);
//    self.businessDistrictLab.text = [NSString stringWithFormat:@"%@",self.businessDistrictStr];
    self.businessDistrictLab.textAlignment = NSTextAlignmentRight;
    self.businessDistrictLab.userInteractionEnabled = true;
    [self addSubview:self.businessDistrictLab];
    [self.businessDistrictLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-40);
        make.centerY.equalTo(self);
        make.width.mas_equalTo(200);
    }];
//    mas_makeConstraints
    
    self.districtArrowView = [[UIImageView alloc]init];
    self.districtArrowView.image = [UIImage imageNamed:@"teamrightIcon"];
    self.districtArrowView.userInteractionEnabled = true;
    [self addSubview:self.districtArrowView];
    [self.districtArrowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.businessDistrictLab.mas_right).offset(5);
        make.centerY.equalTo(self);
    }];
    
    
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(openSelecteDistrictPickView)];
    [self.businessDistrictLab addGestureRecognizer:tapRecognizer];
    
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
    if(self.openSelectDistrictBlock)
    {
        self.openSelectDistrictBlock();
    }
   
}

- (void)setSelectTimeStr:(NSString *)selectTimeStr
{
    _selectTimeStr = selectTimeStr;
    self.timeLab.text = selectTimeStr;
}


@end
