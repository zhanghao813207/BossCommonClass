
//
//  InputCell.m
//  AFNetworking
//
//  Created by admin on 2019/3/27.
//

#import "InputCell.h"
#import "Masonry.h"
#import "JYCMethodDefine.h"
#import "BossMethodDefine.h"

@interface InputCell()<UITextFieldDelegate>

/**
 标题
 */
@property(nonatomic, strong)UILabel *titleLabel;

/**
 内容
 */
@property(nonatomic, strong)UILabel *detailLabel;

/**
 输入框 - 编辑状态
 */
@property(nonatomic, strong)UITextField *textField;

/**
 右箭头
 */
@property(nonatomic, strong)UIButton *arrowButton;

@end

@implementation InputCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self arrowButton];
        [self detailLabel];
        [self textField];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
//    if (self.delegate && [self.delegate respondsToSelector:@selector(inputContent:type:)]) {
//        [self.delegate inputContent:[NSString stringWithFormat:@"%@%@",textField.text,string] type:self.model];
//    }
//    return true;
//}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self endEditing:YES];
    return YES;
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
    
    if (model.isDetail) {
        self.textField.textAlignment = NSTextAlignmentRight;
        self.textField.text = [NSString stringWithFormat:@"%@",model.text];
        self.titleLabel.text = model.title;
        self.detailLabel.hidden = false;
        self.detailLabel.text = model.text;
//        [self.textField mas_remakeConstraints:^(MASConstraintMaker *make) {
//             make.right.equalTo(self.arrowButton.mas_left).offset(32);
//            make.top.bottom.equalTo(self.contentView);
//            make.left.greaterThanOrEqualTo(self.titleLabel.mas_right).offset(5);
//        }];
        self.textField.hidden = true;
    }else {
        self.detailLabel.hidden = true;
        self.textField.hidden = false;
        if (model.isInput) {
            self.textField.text = model.text;
        }
        self.textField.textAlignment = NSTextAlignmentLeft;
        
        if ([model.text containsString:@"未填写"]) {
            self.textField.text = @"";
        }else {
            self.textField.text = model.text;
        }
        self.titleLabel.text = @"";
        if (model.type == InputTypePhone) {
            self.textField.keyboardType = UIKeyboardTypePhonePad;
        }else {
            self.textField.keyboardType = UIKeyboardTypeDefault;
        }
        if ( [model.placeholder containsString:@"骑士"]) {
            self.arrowButton.hidden = true;
        }else {
            self.arrowButton.hidden = model.isSkip;
        }
    }
    self.textField.userInteractionEnabled = model.isSkip;
}

- (UILabel *)detailLabel {
    if (_detailLabel == nil) {
        _detailLabel = [[UILabel alloc] init];
        _detailLabel.numberOfLines = 0;
        _detailLabel.hidden = true;
        _detailLabel.font = [UIFont systemFontOfSize:16];
        _detailLabel.textColor = kHexRGBA(0x000000, 0.8);
        [self.contentView addSubview:_detailLabel];
        [_detailLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.titleLabel.mas_right).offset(4);
            make.centerY.equalTo(self.contentView);
            make.right.equalTo(self.contentView).offset(-4);
        }];
    }
    return _detailLabel;
}

- (UILabel *)titleLabel {
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = [UIColor lightGrayColor];
        [_titleLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
        [self.contentView addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(16);
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
//            make.right.equalTo(self.arrowButton.mas_left).offset(-4);
            make.right.equalTo(self.contentView).offset(-16);
            make.left.equalTo(self.contentView).offset(16);
        }];
    }
    return _textField;
}
- (UIButton *)arrowButton {
    if (_arrowButton == nil) {
        UIImage *arrowImage = [UIImage imageNamed:@"ic_arrow_right" inBundle:QH_Bundle  compatibleWithTraitCollection:nil];
        _arrowButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _arrowButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [_arrowButton setImage:arrowImage forState:UIControlStateNormal];
        [_arrowButton addTarget:self action:@selector(arrowAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_arrowButton];
        [_arrowButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView).offset(-16);
            make.left.equalTo(self.contentView);
            make.centerY.equalTo(self.contentView);
//            make.size.mas_equalTo(CGSizeMake(40, 40));
            make.height.equalTo(@40);
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
