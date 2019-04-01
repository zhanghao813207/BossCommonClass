
//
//  RecommendedCell.m
//  AFNetworking
//
//  Created by admin on 2019/3/26.
//

#import "RecommendedCell.h"
#import "Masonry.h"
#import "UIView+Corner.h"


@interface RecommendedCell ()

@property(nonatomic, strong)UIView *containerView;

/**
 姓名
 */
@property(nonatomic, strong)UILabel *nameLabel;

/**
 电话号码
 */
@property(nonatomic, strong)UILabel *phoneLabel;

/**
 地址
 */
@property(nonatomic, strong)UILabel *addressLabel;

/**
 提示
 */
@property(nonatomic, strong)UILabel *hintLabel;

/**
 角色
 */
@property(nonatomic, strong)UILabel *roleLabel;

/**
 时间
 */
@property(nonatomic, strong)UILabel *timeLabel;

/**
 选中按钮
 */
@property(nonatomic, strong)UIButton *selectButton;
@end

@implementation RecommendedCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self addsubViews];
        self.contentView.backgroundColor = [UIColor colorWithRed:247 / 255.0 green:250 / 255.0 blue:251 / 255.0 alpha:1];
    }
    return self;
}

- (void)addsubViews {
    [self containerView];
    [self nameLabel];
    [self addressLabel];
    [self hintLabel];
    [self phoneLabel];
    [self roleLabel];
    [self timeLabel];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.containerView QH_addRounderCornerWithRadius:10 size:self.containerView.frame.size];
    });
}
- (void)setModel:(RecommendedModel *)model {
    _model = model;
//    self.textLabel.text = model.testStr;
    if (model.isEditing) {
        [self selectButton];
            [self.containerView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.contentView).offset(48);
            }];
    }else {
        [self.containerView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(16);
        }];
    }
    if (model.isEditing) {
        self.selectButton.selected = model.isSelected;
    }
    
    self.nameLabel.text = model.name;
    self.addressLabel.text = model.address;
    self.roleLabel.text = model.positionStr;
    self.timeLabel.text = [model.updated_at substringToIndex:19];
}
- (UIButton *)selectButton {
    if (_selectButton == nil) {
        _selectButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_selectButton setImage:[UIImage imageNamed:@"normal"] forState:UIControlStateNormal];
        [_selectButton setImage:[UIImage imageNamed:@"selected"] forState:UIControlStateSelected];
        [self.contentView addSubview:_selectButton];
        [_selectButton addTarget:self action:@selector(selectAction:) forControlEvents:UIControlEventTouchUpInside];
        [_selectButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(16);
            make.centerY.equalTo(self.containerView);
        }];
    }
    return _selectButton;
}
- (void)selectAction:(UIButton *)button {
    self.model.isSelected = !self.model.isSelected;
    if (self.delegate && [self.delegate respondsToSelector:@selector(didSelect:cell:)]) {
        [self.delegate didSelect:self.model cell:self];
    }
}
- (UILabel *)nameLabel {
    if (_nameLabel == nil) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = [UIFont systemFontOfSize:17];
        _nameLabel.text = @"姓名";
        [self.containerView addSubview:_nameLabel];
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.containerView).offset(10);
            make.top.equalTo(self.containerView).offset(3);
        }];
    }
    return _nameLabel;
}

- (UILabel *)addressLabel {
    if (_addressLabel == nil) {
        _addressLabel = [[UILabel alloc] init];
        _addressLabel.font = [UIFont systemFontOfSize:12];
        _addressLabel.text = @"地址";
        [self.containerView addSubview:_addressLabel];
        [_addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.nameLabel);
            make.top.equalTo(self.nameLabel.mas_bottom).offset(2);
        }];
    }
    return _addressLabel;
}
- (UILabel *)phoneLabel {
    if (_phoneLabel == nil) {
        _phoneLabel = [[UILabel alloc] init];
        _phoneLabel.font = [UIFont systemFontOfSize:17];
        _phoneLabel.text = @"15811008899";
        [self.containerView addSubview:_phoneLabel];
        [_phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.nameLabel.mas_right).offset(4);
            make.centerY.equalTo(self.nameLabel);
        }];
    }
    return _phoneLabel;
}
- (UILabel *)hintLabel {
    if (_hintLabel == nil) {
        _hintLabel = [[UILabel alloc] init];
        _hintLabel.text = @"提示信息";
        _hintLabel.font = [UIFont systemFontOfSize:12];
        [self.containerView addSubview:_hintLabel];
        [_hintLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.nameLabel);
            make.top.equalTo(self.addressLabel.mas_bottom).offset(2);
            make.bottom.equalTo(self.containerView).offset(-5);
        }];
    }
    return _hintLabel;
}

- (UIView *)containerView {
    if (_containerView == nil) {
        _containerView = [[UIView alloc] init];
        _containerView.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_containerView];
        [_containerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView).offset(10);
            make.right.equalTo(self.contentView).offset(-16);
            make.bottom.equalTo(self.contentView);
        }];
     
        
    }
    return _containerView;
}
- (UILabel *)roleLabel {
    if (_roleLabel == nil) {
        _roleLabel = [[UILabel alloc] init];
        _roleLabel.text = @"骑士";
        _roleLabel.font = [UIFont systemFontOfSize:14];
        [self.containerView addSubview:_roleLabel];
        [_roleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.nameLabel);
            make.right.equalTo(self.containerView).offset(-10);
        }];
    }
    return _roleLabel;
}
- (UILabel *)timeLabel {
    if (_timeLabel == nil) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.text = @"时间";
        _timeLabel.font = [UIFont systemFontOfSize:10];
        [self.containerView addSubview:_timeLabel];
        [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.addressLabel);
            make.right.equalTo(self.roleLabel);
        }];
    }
    return _timeLabel;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
