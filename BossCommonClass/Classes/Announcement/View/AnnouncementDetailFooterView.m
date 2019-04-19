
//
//  AnnouncementDetailFooterView.m
//  AFNetworking
//
//  Created by admin on 2019/4/14.
//

#import "AnnouncementDetailFooterView.h"
#import "JYCMethodDefine.h"
#import "ProgressView.h"
#import "Masonry.h"

@interface AnnouncementDetailFooterView ()
@property(nonatomic, strong)UILabel *label;
@property(nonatomic, strong)ProgressView *progressView;
@property(nonatomic, strong)UILabel *numberLabel;
@property(nonatomic, strong)UIView *lineView;
@end

@implementation AnnouncementDetailFooterView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = kHexRGBA(0xF6F6F6, 0.7);
        [self progressView];
        [self numberLabel];
        [self label];
        [self lineView];
        self.progressView.progress = 0.8;
        //////test
        NSString *str1 = @"14";
        NSString *str2 = @"15";
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@/%@",str1,str2]];
        [str addAttribute:NSForegroundColorAttributeName value:kHexRGB(0x00BD9A) range:NSMakeRange(0, str1.length)];
        self.numberLabel.attributedText = str;
    }
    return self;
}
- (UIView *)lineView {
    if (_lineView == nil) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:_lineView];
        [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(self);
            make.height.mas_equalTo(1 / UIScreen.mainScreen.scale);
        }];
    }
    return _lineView;
}
- (UILabel *)label {
    if (_label == nil) {
        _label = [[UILabel alloc] init];
        _label.text = @"打算发到付阿斯顿发大沙发斯蒂芬阿萨德法师打发斯蒂芬阿斯顿发到付";
        _label.font = [UIFont systemFontOfSize:16];
        [self addSubview:_label];
        [_label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(16);
            make.top.equalTo(self).offset(20);
            make.right.equalTo(self).offset(-16);
        }];
    }
    return _label;
}
- (UILabel *)numberLabel {
    if (_numberLabel == nil) {
        _numberLabel = [[UILabel alloc] init];
        [self addSubview:_numberLabel];
        [_numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.progressView);
            make.bottom.equalTo(self.progressView.mas_top).offset(-5);
        }];
    }
    return _numberLabel;
}
- (ProgressView *)progressView {
    if (_progressView == nil) {
        _progressView = [[ProgressView alloc] init];
        [self addSubview:_progressView];
        [_progressView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(16);
            make.top.equalTo(self).offset(77);
            make.right.equalTo(self).offset(-16);
            make.height.mas_equalTo(8);
        }];
    }
    return _progressView;
}
@end
