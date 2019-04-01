
//
//  SelectTabbarView.m
//  AFNetworking
//
//  Created by admin on 2019/3/26.
//

#import "SelectTabbarView.h"
#import "Masonry.h"

@interface SelectTabbarView ()

/**
 删除按钮
 */
@property(nonatomic, strong)UIButton *deleteButton;
@property(nonatomic, strong)UIButton *selectButton;
@end

@implementation SelectTabbarView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor orangeColor];
        [self deleteButton];
        [self selectButton];
    }
    return self;
}

- (UIButton *)deleteButton {
    if (_deleteButton == nil) {
        _deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_deleteButton setTitle:@"全部删除" forState:UIControlStateNormal];
        [_deleteButton addTarget:self action:@selector(deleteAction) forControlEvents:UIControlEventTouchUpInside];
        [_deleteButton setTitleColor:[UIColor purpleColor] forState:UIControlStateNormal];
        [self addSubview:_deleteButton];
        [_deleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.bottom.top.equalTo(self);
            make.width.mas_equalTo(60);
        }];
    }
    return _deleteButton;
}
- (UIButton *)selectButton {
    if (_selectButton == nil) {
        _selectButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_selectButton setTitle:@"全选" forState:UIControlStateNormal];
        [_selectButton setTitleColor:[UIColor purpleColor] forState:UIControlStateNormal];
        [_selectButton addTarget:self action:@selector(select) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_selectButton];
        [_selectButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(self.deleteButton);
            make.left.bottom.top.equalTo(self);
        }];
    }
    return _selectButton;
}

- (void)select {
    if (self.delegate && [self.delegate respondsToSelector:@selector(selectModel:)]) {
        [self.delegate selectModel:self];
    }
}

- (void)deleteAction {
    if (self.delegate && [self.delegate respondsToSelector:@selector(deleteModel:)]) {
        [self.delegate deleteModel:self];
    }
}

@end
