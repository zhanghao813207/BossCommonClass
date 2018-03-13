//
//  NNBBottomAlertView.m
//  NNBarKnight
//
//  Created by 贾远潮 on 2017/10/9.
//  Copyright © 2017年 贾远潮. All rights reserved.
//

#import "NNBBottomAlertView.h"
#import "JYCAlertView.h"
#import "NNBButton.h"
#import "BossBasicDefine.h"
@interface NNBBottomAlertView()<JYCAlertViewDatasource>

@property (nonatomic, strong) JYCAlertView *alertView;

@property (nonatomic, strong) UIView *alertContentView;

@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *subTitleLabel;
@property (nonatomic, strong) NNBButton *mainButton;
@property (nonatomic, strong) NNBButton *cancelButton;

@property (nonatomic, strong) UILabel *leftNoticeLabel;
@property (nonatomic, strong) UILabel *leftTitleLabel;
@property (nonatomic, strong) UILabel *rightNoticeLabel;
@property (nonatomic, strong) UILabel *rightTitleLabel;

@property (nonatomic, strong) NSString *icon;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *subTitle;
@property (nonatomic, strong) NSString *leftTitle;
@property (nonatomic, strong) NSString *rightTitle;
@property (nonatomic, strong) NSString *btnTitle;
@property (nonatomic, strong) NSString *cancelTitle;
@property (nonatomic, copy) void(^btnClickBlock)(NNBBottomAlertView *view);
@property (nonatomic, copy) void(^cancelBtnClickBlock)(NNBBottomAlertView *view);
@end

@implementation NNBBottomAlertView

- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title buttonTitle:(NSString *)btnTitle buttonClicked:(void(^)(NNBBottomAlertView *view))btnClickBlock
{
    return [self initWithFrame:frame icon:nil name:nil title:title buttonTitle:btnTitle buttonClicked:btnClickBlock];
}

- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title cancelButtonTitle:(NSString *)cancelTitle buttonTitle:(NSString *)btnTitle cancelBtnClick:(void(^)(NNBBottomAlertView *view))cancelBtnClickBlock buttonClicked:(void(^)(NNBBottomAlertView *view))btnClickBlock
{
    if (self = [super initWithFrame:frame]) {
        self.title = title;
        self.btnTitle = btnTitle;
        self.cancelTitle = cancelTitle;
        self.cancelBtnClickBlock = cancelBtnClickBlock;
        self.btnClickBlock = btnClickBlock;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame icon:(NSString *)icon name:(NSString *)name title:(NSString *)title buttonTitle:(NSString *)btnTitle buttonClicked:(void(^)(NNBBottomAlertView *view))btnClickBlock
{
    if (self = [super initWithFrame:frame]) {
        self.icon = icon ? : @"station_store";
        self.name = name;
        self.title = title;
        self.btnTitle = btnTitle;
        self.btnClickBlock = btnClickBlock;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title subTitle:(NSString *)subTitle buttonTitle:(NSString *)btnTitle buttonClicked:(void(^)(NNBBottomAlertView *view))btnClickBlock
{
    if (self = [super initWithFrame:frame]) {
        self.title = title;
        self.subTitle = subTitle;
        self.btnTitle = btnTitle;
        self.btnClickBlock = btnClickBlock;
    }
    return self;
}

/**
 带图标且标题分左右的弹框初始化方法
 
 @param frame 位置
 @param icon 图标
 @param name 名字
 @param leftTitle 左标题
 @param rightTitle 右标题
 @param btnTitle 按钮标题
 @param btnClickBlock 按钮点击
 @return 实例对象
 */
- (instancetype)initWithFrame:(CGRect)frame icon:(NSString *)icon name:(NSString *)name leftTitle:(NSString *)leftTitle rightTitle:(NSString *)rightTitle buttonTitle:(NSString *)btnTitle buttonClicked:(void(^)(NNBBottomAlertView *view))btnClickBlock
{
    if (self = [super initWithFrame:frame]) {
        self.icon = icon ? : @"station_store";
        self.name = name;
        self.leftTitle = leftTitle;
        self.rightTitle = rightTitle;
        self.btnTitle = btnTitle;
        self.btnClickBlock = btnClickBlock;
    }
    return self;
}




#pragma mark -- view的展示取消
- (void)show
{
    [self.alertView showJYCAlertView];
}

- (void)dismissWithCompletion:(void(^)(BOOL complete))completionBlcok
{
    [self.alertView dismissJYCAlertViewWithCompletion:^(BOOL finish) {
        [self removeFromSuperview];
        self.alertView = nil;
        if (completionBlcok) {
            completionBlcok(finish);
        }
    }];
}

#pragma mark -- clickMethod

- (void)cancelTitleAciton:(UIButton *)btn
{
    DLog(@"取消按钮被点击");
    if (self.cancelBtnClickBlock) {
        self.cancelBtnClickBlock(self);
    }
}

- (void)mainButtonAciton:(UIButton *)btn
{
    DLog(@"按钮被点击");
    if (self.btnClickBlock) {
        self.btnClickBlock(self);
    }
}

- (void)setBottomAlertType:(NNBBottomAlertViewType)bottomAlertType
{
    _bottomAlertType = bottomAlertType;
    [self addSubview:self.alertView];
}

- (UIView *)JYCAlertView:(JYCAlertView *)alertView
{
    return self.alertContentView;
}

#pragma makr -- lazy property
- (JYCAlertView *)alertView
{
    if (!_alertView) {
        _alertView = [[JYCAlertView alloc] initWithFrame:self.bounds];
        _alertView.datasource = self;
        _alertView.animationType = JYCAlertViewAnimationTypeBottom;
    }
    return _alertView;
}

- (UIView *)alertContentView
{
    if (!_alertContentView) {
        _alertContentView = [[UIView alloc] initWithFrame:CGRectMake(0, self.height - 400, self.width, 400)];
        _alertContentView.backgroundColor = [UIColor whiteColor];
        switch (self.bottomAlertType) {
            case NNBBottomAlertViewTypeNormal:{
                [_alertContentView addSubview:self.titleLabel];
                [_alertContentView addSubview:self.mainButton];
                break;
            }
            case NNBBottomAlertViewTypeCancelBtn:
                [_alertContentView addSubview:self.titleLabel];
                [_alertContentView addSubview:self.cancelButton];
                self.mainButton.frame = CGRectMake(self.width / 2.0, 400 - 44, self.width / 2.0, 44);
                [_alertContentView addSubview:self.mainButton];
                break;
            case NNBBottomAlertViewTypeHasIcon:
            {
                [_alertContentView addSubview:self.iconImageView];
                [_alertContentView addSubview:self.nameLabel];
                [self.titleLabel sizeToFit];
                self.titleLabel.frame = CGRectMake(0, 223, self.width, self.titleLabel.height);
                [_alertContentView addSubview:self.titleLabel];
                [_alertContentView addSubview:self.mainButton];
                break;
            }
            case NNBBottomAlertViewTypeHasSubtitle:
            {
                self.titleLabel.frame = CGRectMake(0, 157, self.width, 25);
                [_alertContentView addSubview:self.titleLabel];
                [_alertContentView addSubview:self.subTitleLabel];
                [_alertContentView addSubview:self.mainButton];
                break;
            }
            case NNBBottomAlertViewTypeTwoTitle:
            {
                [_alertContentView addSubview:self.iconImageView];
                [_alertContentView addSubview:self.nameLabel];
                [_alertContentView addSubview:self.leftNoticeLabel];
                [_alertContentView addSubview:self.leftTitleLabel];
                [_alertContentView addSubview:self.rightNoticeLabel];
                [_alertContentView addSubview:self.rightTitleLabel];
                [_alertContentView addSubview:self.mainButton];
                break;
            }
            default:
                break;
        }
    }
    return _alertContentView;
}

- (UIImageView *)iconImageView
{
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake((self.width - 60) / 2.0, 117, 60, 60)];
        _iconImageView.image = [UIImage imageNamed:self.icon];
    }
    return _iconImageView;
}

- (UILabel *)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 187, self.width, 16)];
        _nameLabel.text = self.name ? : @"";
        _nameLabel.font = BossBlodFont(16.f);
        _nameLabel.textColor = kHexRGBA(0x00000, 0.87);
        _nameLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _nameLabel;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.width, self.alertContentView.height - 44)];
        _titleLabel.textColor = kHexRGB(0xFF6000);
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = BossBlodFont(25.f);
        _titleLabel.text = self.title;
        _titleLabel.numberOfLines = 0;
    }
    return _titleLabel;
}

- (UILabel *)subTitleLabel
{
    if (!_subTitleLabel) {
        _subTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 192, self.width, 18)];
        _subTitleLabel.text = self.subTitle ? : @"";
        _subTitleLabel.font = BossBlodFont(18.f);
        _subTitleLabel.textColor = kHexRGBA(0x00000, 1.0);
        _subTitleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _subTitleLabel;
}

- (UILabel *)leftNoticeLabel
{
    if (!_leftNoticeLabel) {
        _leftNoticeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.nameLabel.frame) + 20, self.width / 2.0, 12)];
        _leftNoticeLabel.text = @"货品袋数（袋）";
        _leftNoticeLabel.textColor = kHexRGBA(0x000000, 0.3);
        _leftNoticeLabel.font = BossRegularFont(12.f);
        _leftNoticeLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _leftNoticeLabel;
}

- (UILabel *)rightNoticeLabel
{
    if (!_rightNoticeLabel) {
        _rightNoticeLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.width / 2.0, CGRectGetMaxY(self.nameLabel.frame) + 20, self.width / 2.0, 12)];
        _rightNoticeLabel.text = @"商品数量（件）";
        _rightNoticeLabel.textColor = kHexRGBA(0x000000, 0.3);
        _rightNoticeLabel.font = BossRegularFont(12.f);
        _rightNoticeLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _rightNoticeLabel;
}

- (UILabel *)leftTitleLabel
{
    if (!_leftTitleLabel) {
        _leftTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.leftNoticeLabel.frame) + 20, self.width / 2.0, 42)];
        _leftTitleLabel.text = self.leftTitle;
        _leftTitleLabel.textColor = kHexRGBA(0x000000, 0.8);
        _leftTitleLabel.font = BossRegularFont(30.f);
        _leftTitleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _leftTitleLabel;
}

- (UILabel *)rightTitleLabel
{
    if (!_rightTitleLabel) {
        _rightTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.width / 2.0, CGRectGetMaxY(self.leftNoticeLabel.frame) + 20, self.width / 2.0, 42)];
        _rightTitleLabel.text = self.rightTitle;
        _rightTitleLabel.textColor = kHexRGBA(0x000000, 0.8);
        _rightTitleLabel.font = BossRegularFont(30.f);
        _rightTitleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _rightTitleLabel;
}

- (NNBButton *)cancelButton
{
    if (!_cancelButton) {
        _cancelButton = [NNBButton grayButtonWithFrame:CGRectMake(0, self.alertContentView.height - 44, self.width / 2.0, 44)];
        [_cancelButton setTitle:self.cancelTitle forState:UIControlStateNormal];
        [_cancelButton addTarget:self action:@selector(cancelTitleAciton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelButton;
}

- (NNBButton *)mainButton
{
    if (!_mainButton) {
        _mainButton = [NNBButton buttonWithFrame:CGRectMake(0, self.alertContentView.height - 44, self.width, 44)];
        [_mainButton setTitle:self.btnTitle forState:UIControlStateNormal];
        [_mainButton addTarget:self action:@selector(mainButtonAciton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _mainButton;
}

@end
