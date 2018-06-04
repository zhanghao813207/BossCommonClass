//
//  EmptyView.m
//  Gtyk
//
//  Created by 贾远潮 on 2016/11/17.
//  Copyright © 2016年 GTYK. All rights reserved.
//

#import "EmptyView.h"
#import "JYCBasicDefine.h"

#define kCurrentViewWidth (self.bounds.size.width)

#define kCurrentViewHeight (self.bounds.size.height)

#define kCurrentWidth(w) (((w) * kCurrentViewWidth) / 375.0f)

// 176 * 122
#define kEmptyImageViewWidth kCurrentWidth(83)
#define kEmptyImageViewHeight kCurrentWidth(61)

#define kEmptyButtonHeight kCurrentWidth(32)

@interface EmptyView ()

@property (nonatomic, strong) UIImageView *emptyImageView;

@property (nonatomic, strong) UILabel *emptyLabel;

@property (nonatomic, strong) UILabel *emptyDetailLabel;

@property (nonatomic, strong) UIButton *emptyButton;

@end

@implementation EmptyView

- (UIImageView *)emptyImageView
{
    if (!_emptyImageView) {
        _emptyImageView = [[UIImageView alloc] init];
        
        _emptyImageView.image = self.emptyImage;
    }
    return _emptyImageView;
}

- (UILabel *)emptyLabel
{
    if (!_emptyLabel) {
        _emptyLabel = [[UILabel alloc] init];
        _emptyLabel.text = self.emptyString;
        _emptyLabel.textColor = kHexRGB(0x666666);
        _emptyLabel.font = [UIFont systemFontOfSize:13.f];
        _emptyLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _emptyLabel;
}

- (UILabel *)emptyDetailLabel
{
    if (!_emptyDetailLabel) {
        _emptyDetailLabel = [[UILabel alloc] init];
        _emptyDetailLabel.text = self.emptyDetailString;
        _emptyDetailLabel.font = [UIFont systemFontOfSize:13.f];
        _emptyDetailLabel.textColor = kHexRGB(0x999999);
        _emptyDetailLabel.numberOfLines = 0;
        _emptyDetailLabel.textAlignment = NSTextAlignmentCenter;

    }
    return _emptyDetailLabel;
}

- (UIButton *)emptyButton
{
    if (!_emptyButton) {
        _emptyButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [_emptyButton setTitleColor:kHexRGB(0x666666) forState:UIControlStateNormal];
        _emptyButton.titleLabel.font = [UIFont systemFontOfSize:15.f];
        _emptyButton.layer.cornerRadius = 2.f;
        _emptyButton.layer.borderWidth = 1.f;
        _emptyButton.layer.borderColor = kHexRGB(0xa0a0a0).CGColor;
        [_emptyButton addTarget:self action:@selector(emptyButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [_emptyButton setTitle:self.emptyButtonTitle forState:UIControlStateNormal];
    }
    return _emptyButton;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        _emptyImage = [UIImage imageNamed:@""];
        _emptyString = @"当前页面为空";
        _emptyButtonTitle = @"点我啊";
    }
    return self;
}

- (void)setEmptyViewType:(EmptyViewType)emptyViewType
{
    _emptyViewType = emptyViewType;
    
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    if (emptyViewType == EmptyViewTypeNoButton) {
        
        [self addSubview:self.emptyImageView];
        [self addSubview:self.emptyLabel];
        [self addSubview:self.emptyDetailLabel];
        
    } else if (emptyViewType == EmptyViewTypeHasButton){
        
        [self addSubview:self.emptyImageView];
        [self addSubview:self.emptyLabel];
        [self addSubview:self.emptyDetailLabel];
        [self addSubview:self.emptyButton];
    }
    [self resetViewLayout];
}

- (void)emptyButtonAction:(UIButton *)sender
{
    if (_emptyButtonIsSelect) {
        self.emptyButtonIsSelect(YES);
    }
}

- (void)setEmptyImage:(UIImage *)emptyImage
{
    if (_emptyImage != emptyImage) {
        _emptyImage = emptyImage;
        self.emptyImageView.image = emptyImage;
        [self resetViewLayout];
    }
}

- (void)setEmptyString:(NSString *)emptyString
{
    if (_emptyString != emptyString) {
        _emptyString = emptyString;
        self.emptyLabel.text = self.emptyString;
        [self resetViewLayout];
    }
}

- (void)setEmptyDetailString:(NSString *)emptyDetailString
{
    if (_emptyDetailString != emptyDetailString) {
        _emptyDetailString = emptyDetailString;
        self.emptyDetailLabel.text = self.emptyDetailString;
        [self resetViewLayout];
    }
}

- (void)setEmptyButtonTitle:(NSString *)emptyButtonTitle
{
    if (_emptyButtonTitle != emptyButtonTitle) {
        _emptyButtonTitle = emptyButtonTitle;
        [self.emptyButton setTitle:self.emptyButtonTitle forState:UIControlStateNormal];
        [self resetViewLayout];
    }
}

- (void)resetViewLayout
{
    if (self.emptyViewType == EmptyViewTypeHasButton) {
        
        self.emptyImageView.frame = CGRectMake((kCurrentViewWidth - kEmptyImageViewWidth) / 2.0, kCurrentViewHeight / 3.0 - 20, kEmptyImageViewWidth, kEmptyImageViewHeight);
        
        self.emptyLabel.frame = CGRectMake(0, CGRectGetMaxY(self.emptyImageView.frame) + 18, kCurrentViewWidth, 17);
        
        self.emptyDetailLabel.frame = CGRectMake(0, CGRectGetMaxY(self.emptyLabel.frame) + 13, kCurrentViewWidth, 17);
        CGSize emptyDetailSize = [self.emptyDetailString sizeOfStringWithFont:self.emptyDetailLabel.font maxSize:CGSizeMake(kCurrentViewWidth, 100)];
        [self.emptyDetailLabel setHeight:emptyDetailSize.height];

        
        CGSize buttonSize =  [self.emptyButtonTitle sizeOfStringWithFont:self.emptyButton.titleLabel.font maxSize:CGSizeMake(kCurrentViewWidth, kEmptyButtonHeight)];
        self.emptyButton.frame = CGRectMake((kCurrentViewWidth - buttonSize.width - 10) / 2.0f, (CGFloat)[@(CGRectGetMaxY(self.emptyDetailLabel.frame) + 10) integerValue], buttonSize.width + 10, kEmptyButtonHeight);
        
    } else if (self.emptyViewType == EmptyViewTypeNoButton){
        
        self.emptyImageView.frame = CGRectMake((kCurrentViewWidth - kEmptyImageViewWidth) / 2.0, (kCurrentViewHeight - kEmptyImageViewHeight) / 2.0 - 20, kEmptyImageViewWidth, kEmptyImageViewHeight);
        
        self.emptyLabel.frame = CGRectMake(0, CGRectGetMaxY(self.emptyImageView.frame) + 18, kCurrentViewWidth, 17);
        
        self.emptyDetailLabel.frame = CGRectMake(0, CGRectGetMaxY(self.emptyLabel.frame) + 13, kCurrentViewWidth, 17);
        CGSize emptyDetailSize = [self.emptyDetailString sizeOfStringWithFont:self.emptyDetailLabel.font maxSize:CGSizeMake(kCurrentViewWidth, 100)];
        [self.emptyDetailLabel setHeight:emptyDetailSize.height];

        
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
