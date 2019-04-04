
//
//  FooterView.m
//  AFNetworking
//
//  Created by admin on 2019/3/27.
//

#import "FooterView.h"
#import "Masonry.h"
#import "JYCMethodDefine.h"


@interface FooterView()

/**
 保存
 */
@property(nonatomic, strong)UIButton *saveButton;

/**
 提交
 */
@property(nonatomic, strong)UIButton *commitButton;
@end

@implementation FooterView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self saveButton];
    }
    return self;
}
- (UIButton *)saveButton {
    if (_saveButton == nil) {
        _saveButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_saveButton setTitle:@"保存" forState:UIControlStateNormal];
        _saveButton.backgroundColor = kHexRGB(0xADADBD);
        [_saveButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        _saveButton.titleLabel.font = [UIFont systemFontOfSize:16];
        _saveButton.layer.cornerRadius = 3;
        _saveButton.layer.masksToBounds = true;
        [self addSubview:_saveButton];
        [_saveButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(20);
            make.height.equalTo(self);
            make.right.equalTo(self.commitButton.mas_left).offset(-5);
            make.width.equalTo(self.commitButton);
            make.bottom.equalTo(self);
        }];
    }
    return _saveButton;
}
- (void)buttonAction:(UIButton *)button {
    if (self.delegate && [self.delegate respondsToSelector:@selector(didButton:view:)]) {
        [self.delegate didButton:button.currentTitle view:self];
    }
}
- (UIButton *)commitButton {
    if (_commitButton == nil) {
        _commitButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_commitButton setTitle:@"提交" forState:UIControlStateNormal];
        [_commitButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        _commitButton.layer.cornerRadius = 3;
        _commitButton.layer.masksToBounds = true;
        _commitButton.backgroundColor = kHexRGB(0x1173E4);
        _commitButton.titleLabel.font = [UIFont systemFontOfSize:16];
        [self addSubview:_commitButton];
        [_commitButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).offset(-20);
            make.height.equalTo(self.saveButton);
            make.bottom.equalTo(self);
        }];
    }
    return _commitButton;
}
- (void)setIsEnable:(BOOL)isEnable {
    _isEnable = isEnable;
    self.commitButton.enabled = isEnable;
}
@end
