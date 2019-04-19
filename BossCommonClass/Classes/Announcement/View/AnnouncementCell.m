
//
//  AnnouncementCell.m
//  即时通讯界面
//
//  Created by admin on 2019/4/11.
//  Copyright © 2019 admin. All rights reserved.
//

#import "AnnouncementCell.h"
#import "TestModel.h"
#import "Masonry.h"
#import "UIImageView+WebCache.h"
#import "JYCMethodDefine.h"

@interface AnnouncementCell()
@property(nonatomic, strong)UIImageView *headerImgView;
@property(nonatomic, strong)UIView *containerView;
@property(nonatomic, strong)UILabel *hintLabel;
@property(nonatomic, strong)UILabel *titleLabel;
@property(nonatomic, strong)UILabel *contentLabel;
@property(nonatomic, strong)UIView *lineView;
@property(nonatomic, strong)UILabel *clickLabel;
@property(nonatomic, strong)UIImageView *imgView;
@property(nonatomic, strong)UIView *progressBgView;
@property(nonatomic, strong)UIView *progressView;
@end

@implementation AnnouncementCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self headerImgView];
        [self containerView];
        [self imgView];
        [self hintLabel];
        [self lineView];
        [self clickLabel];
        [self progressBgView];
        [self progressView];
        self.contentView.backgroundColor = [UIColor colorWithRed:245 / 255.0 green:247 / 255.0 blue:249 / 255.0 alpha:1];
    }
    return self;
}
- (UIImageView *)imgView {
    if (_imgView == nil) {
        _imgView = [[UIImageView alloc] init];
        [self.containerView addSubview:_imgView];
        [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(self.containerView);
        }];
    }
    return _imgView;
}
- (UILabel *)clickLabel {
    if (_clickLabel == nil) {
        _clickLabel = [[UILabel alloc] init];
        _clickLabel.text = @"查看详情 >";
        _clickLabel.font = [UIFont systemFontOfSize:12];
        _clickLabel.textColor = kHexRGBA(0x343339, 0.6);
        [self.containerView addSubview:_clickLabel];
        [_clickLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.lineView.mas_bottom).offset(6);
            make.left.equalTo(self.contentLabel);
        }];
    }
    return _clickLabel;
}
- (UIView *)lineView {
    if (_lineView == nil) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = kHexRGB(0xE5E5EE);
        [self.containerView addSubview:_lineView];
        [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.containerView);
            make.top.equalTo(self.contentLabel.mas_bottom).offset(10);
            make.height.mas_equalTo(1 / UIScreen.mainScreen.scale);
        }];
    }
    return _lineView;
}
- (UILabel *)contentLabel {
    if (_contentLabel == nil) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.numberOfLines = 2;
        _contentLabel.font = [UIFont systemFontOfSize:14];
        _contentLabel.alpha = 0.9;
        _contentLabel.textColor = kHexRGBA(0x343339, 0.9);
        [self.containerView addSubview:_contentLabel];
        [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.titleLabel).offset(-3);
            make.top.equalTo(self.titleLabel.mas_bottom).offset(10);
            make.right.equalTo(self.containerView).offset(-16);
        }];
    }
    return _contentLabel;
}
- (UILabel *)titleLabel {
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont boldSystemFontOfSize:17];
        [self.containerView addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.containerView).offset(16);
            make.top.equalTo(self.imgView.mas_bottom).offset(20);
        }];
    }
    return _titleLabel;
}
- (UIImageView *)headerImgView {
    if (_headerImgView == nil) {
        _headerImgView = [[UIImageView alloc] init];
        _headerImgView.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:_headerImgView];
        [_headerImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(16);
            make.top.equalTo(self.contentView).offset(20);
            make.size.mas_equalTo(CGSizeMake(40, 40));
        }];
    }
    return _headerImgView;
}
- (UIView *)progressBgView {
    if (_progressBgView == nil) {
        _progressBgView = [[UIView alloc] init];
        _progressBgView.backgroundColor = [UIColor colorWithRed:207 / 255.0 green:207 / 255.0 blue:207 / 255.0 alpha:1];
        [self.containerView addSubview:_progressBgView];
        [_progressBgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.clickLabel.mas_bottom).offset(6);
            make.left.right.equalTo(self.containerView);
            make.height.mas_equalTo(4);
            make.bottom.equalTo(self.containerView);
        }];
    }
    return _progressBgView;
}
- (UIView *)progressView {
    if (_progressView == nil) {
        _progressView = [[UIView alloc] init];
        _progressView.backgroundColor = [UIColor greenColor];
        [self.containerView addSubview:_progressView];
        [_progressView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.bottom.equalTo(self.progressBgView);
            make.width.equalTo(self.progressBgView).multipliedBy(0.8);
        }];
    }
    return _progressView;
}
- (UIView *)containerView {
    if (_containerView == nil) {
        _containerView = [[UIView alloc] init];
        _containerView.backgroundColor = [UIColor whiteColor];
        _containerView.layer.cornerRadius = 5;
        _containerView.layer.masksToBounds = true;
        [self.contentView addSubview:_containerView];
        [_containerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(64);
            make.right.equalTo(self.contentView).offset(-64);
            make.top.equalTo(self.headerImgView.mas_centerY);
        }];
    }
    return _containerView;
}
- (UILabel *)hintLabel {
    if (_hintLabel == nil) {
        _hintLabel = [[UILabel alloc] init];
//        _hintLabel.text = @"已读/未读";
        _hintLabel.font = [UIFont systemFontOfSize:10];
        _hintLabel.textColor = kHexRGBA(0x000000, 0.2);
        [self.contentView addSubview:_hintLabel];
        [_hintLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.containerView);
            make.top.equalTo(self.containerView.mas_bottom).offset(2);
            make.bottom.equalTo(self.contentView).offset(-6);
        }];
    }
    return _hintLabel;
}
- (void)setModel:(TestModel *)model {
    _model = model;
    self.titleLabel.text = model.title;
    self.contentLabel.text = model.text;
    if (model.isMe) {
        [self.headerImgView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset([UIScreen mainScreen].bounds.size.width - 56);
        }];
        self.progressBgView.hidden = false;
//        self.hintLabel.attributedText;
    }else {
        self.progressBgView.hidden = true;
        self.hintLabel.text = @"已读/未读";
        [self.headerImgView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(16);
        }];
    }
    self.progressView.hidden = self.progressBgView.hidden;
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:model.imgUrl]];
}

@end
