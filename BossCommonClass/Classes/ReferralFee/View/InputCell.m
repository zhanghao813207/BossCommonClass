
//
//  InputCell.m
//  AFNetworking
//
//  Created by admin on 2019/3/27.
//

#import "InputCell.h"
#import "Masonry.h"

@interface InputCell()<UITextFieldDelegate>
@property(nonatomic, strong)UITextField *textField;
@property(nonatomic, strong)UIButton *arrowButton;
@property(nonatomic, strong)UILabel *titleLabel;
@end

@implementation InputCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self textField];
        [self arrowButton];
    }
    return self;
}

//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
//    if (self.delegate && [self.delegate respondsToSelector:@selector(inputContent:type:)]) {
//        [self.delegate inputContent:[NSString stringWithFormat:@"%@%@",textField.text,string] type:self.model];
//    }
//    return true;
//}
- (void)setDetailStr:(NSString *)detailStr {
    _detailStr = detailStr;
    self.textField.text = detailStr;
}
- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (self.delegate && [self.delegate respondsToSelector:@selector(inputContent:type:)]) {
        [self.delegate inputContent:textField.text type:self.model];
    }
}
- (void)setModel:(InputMessageModel *)model {
    _model = model;
    self.textField.placeholder = model.placeholder;
    self.arrowButton.hidden = model.isSkip;
    self.textField.userInteractionEnabled = model.isSkip;
    if (model.isDetail) {
        self.textField.textAlignment = NSTextAlignmentRight;
        self.textField.text = [NSString stringWithFormat:@"%@",model.text];
        self.titleLabel.text = model.title;
    }else {
        self.textField.textAlignment = NSTextAlignmentLeft;
        self.titleLabel.text = @"";
    }
}
- (UILabel *)titleLabel {
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = [UIColor lightGrayColor];
        [self.contentView addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(8);
            make.centerY.equalTo(self.contentView);
        }];
    }
    return _titleLabel;
}
- (UITextField *)textField {
    if (_textField == nil) {
        _textField = [[UITextField alloc] init];
        _textField.font = [UIFont systemFontOfSize:16];
//        [_textField setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
        _textField.delegate = self;
        [self.contentView addSubview:_textField];
        [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self.contentView);
            make.right.equalTo(self.arrowButton.mas_left).offset(-4);
            make.left.equalTo(self.contentView).offset(8);
        }];
    }
    return _textField;
}
- (UIButton *)arrowButton {
    if (_arrowButton == nil) {
        _arrowButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_arrowButton setImage:[UIImage imageNamed:@"ic_arrow_right"] forState:UIControlStateNormal];
        [_arrowButton addTarget:self action:@selector(arrowAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_arrowButton];
        [_arrowButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView).offset(-4);
            make.centerY.equalTo(self.contentView);
            make.size.mas_equalTo(CGSizeMake(40, 40));
        }];
    }
    return _arrowButton;
}
- (void)arrowAction:(UIButton *)button {
    if (self.delegate && [self.delegate respondsToSelector:@selector(arrowActionWithModel:)]) {
        [self.delegate arrowActionWithModel:self.model];
    }
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
