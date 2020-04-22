//
//  NotDateEmptyView.m
//  Gtyk
//
//  Created by 史华涛 on 2017/9/13.
//  Copyright © 2017年 欧客云. All rights reserved.
//

#import "NotDateEmptyView.h"
#import "BossBasicDefine.h"

#define kTitleFont (BossRegularFont(14.f))

#define kTitleWidth (kScreenWidth)

@interface NotDateEmptyView()

@property (copy, nonatomic) NSString *titleString;

@property (copy, nonatomic) NSString *imageNameString;

@property (assign, nonatomic) NSInteger imageAddTitleSpace;

@property (nonatomic, assign) CGFloat noticeTitleHeight;

@property (assign, nonatomic) NSInteger originY;

@property (assign, nonatomic) NotDateEmptyViewType emptyViewType;

@property (nonatomic, assign) CGSize imageSize;

@end

@implementation NotDateEmptyView


- (instancetype)initWithFrame:(CGRect)frame theImageViewOrigin:(NSInteger)originY theImageAddTitleSpace:(NSInteger)space imageName:(NSString *)iName imageSize:(CGSize)size title:(NSString *)title isType:(NotDateEmptyViewType)type
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorNamed:@"bgcolor_FFFFFF_000000"];
        _titleString = @"您还没有数据哦~";
        _imageAddTitleSpace = 20;
        _imageNameString = @"NoDataIcon";
        
        if (title) {
            _titleString = title;
        }
        CGSize titleSize = [_titleString sizeOfStringWithFont:kTitleFont maxSize:CGSizeMake(kTitleWidth, 200)];
        self.noticeTitleHeight = titleSize.height;
        
        if (space >0) {
            _imageAddTitleSpace = space;
        }
        if (iName) {
            _imageNameString = iName;
        }
        
        DLog(@"NSStringFromCGSize = %@",NSStringFromCGSize(size));
        
        if (size.width > 0 && size.height > 0) {
            self.imageSize = size;
        } else {
             #if kBossManager
             self.imageSize = CGSizeMake(kIphone6Width(68), kIphone6Width(69));
             #else
             self.imageSize = CGSizeMake(kIphone6Width(90), kIphone6Width(90));
             #endif
        }
        
        if (originY > 0) {
            _originY = originY;
        } else {
            _originY = (frame.size.height - self.imageSize.height - _noticeTitleHeight - _imageAddTitleSpace) / 5.0 * 2;
        }
        
        
        _emptyViewType = type;
        
        if (type == NotDateEmptyViewTypeIsPureColor) {
            
        } else if (type == NotDateEmptyViewTypeIsUpImageDownTitle) {
            [self showNotDateEmptyViewTypeIsUpImageDownTitleUI];
        }
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame imageName:(NSString *)imageName imageSize:(CGSize)size titile:(NSString *)title space:(CGFloat)space
{
    DLog(@"NSStringFromCGSize = %@",NSStringFromCGSize(size));
    return [self initWithFrame:frame theImageViewOrigin:0 theImageAddTitleSpace:space imageName:imageName imageSize:size title:title isType:NotDateEmptyViewTypeIsUpImageDownTitle];
}


-(void)showNotDateEmptyViewTypeIsUpImageDownTitleUI
{
    
    UIImageView *imageIcon = [[UIImageView alloc]initWithFrame:CGRectMake((kScreenWidth - self.imageSize.width) / 2.0, _originY, self.imageSize.width, self.imageSize.height)];
    imageIcon.image = [UIImage imageNamed:_imageNameString];
    [self addSubview:imageIcon];
    
    
    UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(imageIcon.frame)+_imageAddTitleSpace, kTitleWidth, self.noticeTitleHeight)];
    titleLab.numberOfLines = 0;
    titleLab.textColor = [UIColor colorNamed:@"boss_000000-60_FFFFFF-60"];
    titleLab.font = kTitleFont;
    titleLab.textAlignment = NSTextAlignmentCenter;
    titleLab.text = _titleString;
    [self addSubview:titleLab];
}

- (void)setBackgroundView:(UIView *)backgroundView
{
    if (_backgroundView == backgroundView) {
        return;
    }
    _backgroundView = backgroundView;
    if (backgroundView) {
        [self insertSubview:backgroundView atIndex:0];
    }
}




@end
