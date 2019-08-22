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
@property (nonatomic, strong) UIImageView *arrowView;

@end

@implementation BOSelectTimeView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if(self = [super initWithFrame:frame]){
        
        self.backgroundColor = kHexRGB(0xF9FBFC);
        
        self.timeLab = [[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth-140)*0.5, 0, 120, 64)];
        
        self.timeLab.font = BossBlodFont(24);
        
        self.timeLab.textColor = kHexRGB(0x1A9CFF);
        NSCalendar *calendar = [[NSCalendar alloc]
                                initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth;
        NSDateComponents *comp = [calendar components: unitFlags fromDate:[NSDate date]];
        self.timeLab.text = [NSString stringWithFormat:@"%02ld-%02ld",2019,6];
        self.timeLab.textAlignment = NSTextAlignmentRight;
        [self addSubview:self.timeLab];
        
        self.arrowView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.timeLab.frame)+10 , (64-14)*0.5, 9, 14)];
        self.arrowView.image = [UIImage imageNamed:@"teamrightIcon"];
        [self addSubview:self.arrowView];
        
        UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(openSelectePickView)];
        [self addGestureRecognizer:tapRecognizer];
    }
    return self;
}

- (void)openSelectePickView
{
    if(self.openSelectBlock)
    {
        self.openSelectBlock();
    }
}

- (void)setSelectTimeStr:(NSString *)selectTimeStr
{
    _selectTimeStr = selectTimeStr;
    self.timeLab.text = selectTimeStr;
}

@end
