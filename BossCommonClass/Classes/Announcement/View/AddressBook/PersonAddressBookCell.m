

//
//  PersonAddressBookCell.m
//  AFNetworking
//
//  Created by admin on 2019/4/17.
//

#import "PersonAddressBookCell.h"
#import "BossMethodDefine.h"
#import "Masonry.h"
#import "BossBasicDefine.h"

@interface PersonAddressBookCell ()
@property(nonatomic, strong)UIButton *selectButton;
@property(nonatomic, strong)UILabel *imgView;
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
- (void)setModel:(ContactsPerson *)model {
    _model = model;
    self.selectButton.selected = model.isSelect;
    self.nameLabel.text = model.nick_name;
    self.imgView.text = [model.nick_name substringFromIndex:model.nick_name.length - 1];
}
- (UILabel *)imgView {
    if (_imgView == nil) {
        _imgView = [[UILabel alloc] init];
        _imgView.backgroundColor = kHexRGB(0x89A1DE);
        _imgView.textColor = UIColor.whiteColor;
        _imgView.layer.masksToBounds = YES;
        _imgView.layer.cornerRadius = 20;
        _imgView.textAlignment = NSTextAlignmentCenter;
        _imgView.font = BossRegularFont(17.f);
//        _imgView.layer.cornerRadius = 20;
//        _imgView.layer.masksToBounds = true;
//        UIImage *image = [UIImage imageNamed:@"addressbook_userDefaultIcon" inBundle:QH_Bundle  compatibleWithTraitCollection:nil];
//        _imgView.image = image;
        [self.contentView addSubview:_imgView];
        [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(40, 40));
            make.centerY.equalTo(self.contentView);
            make.right.equalTo(self.selectButton.mas_right).offset(16);
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
        _selectButton.hidden = true;
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
