//
//  NotDateEmptyView.m
//  Gtyk
//
//  Created by 史华涛 on 2017/9/13.
//  Copyright © 2017年 GTYK. All rights reserved.
//

#import "NotDateEmptyView.h"
#import "JYCBasicDefine.h"


@interface NotDateEmptyView()

@property (copy, nonatomic) NSString *titleString;

@property (copy, nonatomic) NSString *imageNameString;

@property (assign, nonatomic) NSInteger imageAddTitleSpace;

@property (assign, nonatomic) NSInteger originY;


@property (assign, nonatomic) NotDateEmptyViewType emptyViewType;

@end

@implementation NotDateEmptyView


- (instancetype)initWithFrame:(CGRect)frame theImageViewOrigin:(NSInteger)originY theImageAddTitleSpace:(NSInteger)space ImageNamed:(NSString *)iName Title:(NSString *)title isType:(NotDateEmptyViewType)type
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _titleString = @"您还没有数据哦~";
        _imageAddTitleSpace = 20;
        _imageNameString = @"NoDataIcon";
        
        if (title) {
            _titleString = title;
        }
        if (space >0) {
            _imageAddTitleSpace = space;
        }
        if (iName) {
            _imageNameString = iName;
        }
        if (originY >0 ) {
            _originY = originY;
        } else {
            _originY = (kScreenHeight - kIphone6Width(125) - 20 - _imageAddTitleSpace) / 5.0 * 2;
        }
        
        _emptyViewType = type;
        
        if (type == NotDateEmptyViewTypeIsPureColor) {
            
        } else if (type == NotDateEmptyViewTypeIsUpImageDownTitle) {
            [self showNotDateEmptyViewTypeIsUpImageDownTitleUI];
        }
    }
    return self;
}

- (instancetype)initWithImageName:(NSString *)imageName titile:(NSString *)title space:(CGFloat)space
{
   return [self initWithFrame:[UIScreen mainScreen].bounds theImageViewOrigin:0 theImageAddTitleSpace:space ImageNamed:imageName Title:title isType:NotDateEmptyViewTypeIsUpImageDownTitle];
}


-(void)showNotDateEmptyViewTypeIsUpImageDownTitleUI
{
    
    UIImageView *imageIcon = [[UIImageView alloc]initWithFrame:CGRectMake((kScreenWidth - kIphone6Width(125)) / 2.0, _originY, kIphone6Width(125), kIphone6Width(125))];
    imageIcon.image = [UIImage imageNamed:_imageNameString];
    [self addSubview:imageIcon];
    
    UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(imageIcon.frame)+_imageAddTitleSpace, kScreenWidth, 20)];
    titleLab.textColor = kHexRGB(0X666666);
    titleLab.font = [UIFont systemFontOfSize:14.f];
    titleLab.text = _titleString;
    titleLab.textAlignment = NSTextAlignmentCenter;
    [self addSubview:titleLab];

}




@end
