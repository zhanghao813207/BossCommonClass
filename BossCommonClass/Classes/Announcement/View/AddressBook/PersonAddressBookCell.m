

//
//  PersonAddressBookCell.m
//  AFNetworking
//
//  Created by admin on 2019/4/17.
//

#import "PersonAddressBookCell.h"
#import "BossMethodDefine.h"
#import "Masonry.h"

@interface PersonAddressBookCell ()
@property(nonatomic, strong)UIButton *selectButton;
@property(nonatomic, strong)UIImageView *imgView;
@property(nonatomic, strong)UILabel *nameLabel;
@end

@implementation PersonAddressBookCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self selectButton];
        [self imgView];
        [self nameLabel];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}
- (void)setModel:(TestPersonModel *)model {
    _model = model;
    self.selectButton.selected = model.isSelect;
    self.nameLabel.text = model.name;
}
- (UIImageView *)imgView {
    if (_imgView == nil) {
        _imgView = [[UIImageView alloc] init];
        _imgView.layer.cornerRadius = 20;
        _imgView.layer.masksToBounds = true;
        _imgView.backgroundColor = [UIColor blackColor];
        [self.contentView addSubview:_imgView];
        [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(40, 40));
            make.centerY.equalTo(self.contentView);
            make.left.equalTo(self.selectButton.mas_right).offset(16);
        }];
    }
    return _imgView;
}
- (UILabel *)nameLabel {
    if (_nameLabel == nil) {
        _nameLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_nameLabel];
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView);
            make.left.equalTo(self.imgView.mas_right).offset(10);
        }];
    }
    return _nameLabel;
}
- (UIButton *)selectButton {
    if (_selectButton == nil) {
        _selectButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _selectButton.userInteractionEnabled = false;
        UIImage *normalImage = [UIImage imageNamed:@"nomarl" inBundle:QH_Bundle  compatibleWithTraitCollection:nil];
        UIImage *selectImage = [UIImage imageNamed:@"select" inBundle:QH_Bundle  compatibleWithTraitCollection:nil];
        [_selectButton setImage:normalImage forState:UIControlStateNormal];
        [_selectButton setImage:selectImage forState:UIControlStateSelected];
        [self.contentView addSubview:_selectButton];
        [_selectButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(16);
            make.centerY.equalTo(self.contentView);
        }];
    }
    return _selectButton;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}


@end
