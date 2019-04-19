

//
//  AddressBookCell.m
//  AFNetworking
//
//  Created by admin on 2019/4/17.
//

#import "AddressBookCell.h"
#import "BossMethodDefine.h"
#import "Masonry.h"
#import "JYCMethodDefine.h"

@interface AddressBookCell ()
@property(nonatomic, strong)UIButton *selectButton;
@property(nonatomic, strong)UIImageView *imgView;
@property(nonatomic, strong)UILabel *nameLabel;
@property(nonatomic, strong)UILabel *arrowLabel;
@end

@implementation AddressBookCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self selectButton];
        [self imgView];
        [self nameLabel];
//        [self arrowLabel];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return self;
}
- (void)setModel:(TestGroupModel *)model {
    _model = model;
    UIImage *image;
    if (model.state == SelectStateNo) {
        image = [UIImage imageNamed:@"nomarl" inBundle:QH_Bundle  compatibleWithTraitCollection:nil];
    }else if (model.state == SelectStateAll ) {
        image = [UIImage imageNamed:@"select" inBundle:QH_Bundle  compatibleWithTraitCollection:nil];
    }else if (model.state == SelectStateSubAll) {
        image = [UIImage imageNamed:@"subSelect" inBundle:QH_Bundle  compatibleWithTraitCollection:nil];
    }
    
    [_selectButton setImage:image forState:UIControlStateNormal];
    
    self.nameLabel.text = model.name;
}
//- (UILabel *)arrowLabel {
//    if (_arrowLabel == nil) {
//        _arrowLabel = [[UILabel alloc] init];
//        _arrowLabel.text = @">";
////        _arrowLabel.textColor = kHexRGB(0xF3F3F3);
//        _arrowLabel.textColor = [UIColor lightGrayColor];
//        [self.contentView addSubview:_arrowLabel];
//        [_arrowLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.centerY.equalTo(self.contentView);
//            make.right.equalTo(self.contentView).offset(-16);
//        }];
//    }
//    return _arrowLabel;
//}
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
        
        [_selectButton addTarget:self action:@selector(selectAction) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_selectButton];
        [_selectButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(16);
            make.centerY.equalTo(self.contentView);
        }];
    }
    return _selectButton;
}
- (void)selectAction {
    if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectCell:model:)]) {
        if (self.model.state == SelectStateSubAll) {
            self.model.state = SelectStateAll;
        }else if (self.model.state == SelectStateAll) {
            self.model.state = SelectStateNo;
        }else if (self.model.state == SelectStateNo) {
            self.model.state = SelectStateAll;
        }
        [self.delegate didSelectCell:self model:self.model];
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
