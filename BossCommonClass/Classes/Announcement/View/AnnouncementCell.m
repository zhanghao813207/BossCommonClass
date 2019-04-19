
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


/**
 大背景
 */
@property(nonatomic, strong)UIView *bgView;
/**
 头像
 */
@property(nonatomic, strong)UIImageView *headerImgView;
@property(nonatomic, strong)UIView *containerView;
@property(nonatomic, strong)UILabel *hintLabel;

/**
 内容的标题
 */
@property(nonatomic, strong)UILabel *titleLabel;

/**
 内容
 */
@property(nonatomic, strong)UILabel *contentLabel;

/**
 灰色的线
 */
@property(nonatomic, strong)UIView *lineView;

/**
 查看详情
 */
@property(nonatomic, strong)UILabel *clickLabel;

/**
 内容里面的图片
 */
@property(nonatomic, strong)UIImageView *imgView;

/**
 进度背景
 */
@property(nonatomic, strong)UIView *progressBgView;

/**
 进度
 */
@property(nonatomic, strong)UIView *progressView;

/**
 时间
 */
@property(nonatomic, strong)UILabel *timeLable;
@property(nonatomic, strong)UILabel *nameLable;
@end

@implementation AnnouncementCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self bgView];
        [self headerImgView];
        [self containerView];
        [self imgView];
        [self hintLabel];
        [self lineView];
        [self clickLabel];
        [self progressBgView];
        [self progressView];
        [self timeLable];
        [self nameLable];
        self.contentView.backgroundColor = [UIColor colorWithRed:245 / 255.0 green:247 / 255.0 blue:249 / 255.0 alpha:1];
    }
    return self;
}
- (UIView *)bgView {
    if (_bgView == nil) {
        _bgView = [[UIView alloc] init];
        _bgView.layer.cornerRadius = 20;
        _bgView.layer.masksToBounds = true;
        _bgView.backgroundColor = [UIColor colorWithRed:235 / 255.0 green:237 / 255.0 blue:239 / 255.0 alpha:0.2];
        [self.contentView addSubview:_bgView];
        [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(36);
            make.right.equalTo(self.contentView).offset(-36);
            make.top.equalTo(self.contentView).offset(10);
            make.bottom.equalTo(self.contentView).offset(0);
        }];
    }
    return _bgView;
}
- (UIImageView *)imgView {
    if (_imgView == nil) {
        _imgView = [[UIImageView alloc] init];
        [self.containerView addSubview:_imgView];
        [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(self.containerView);
//            make.height.equalTo(@150);
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
        _headerImgView.backgroundColor = [UIColor blackColor];
        _headerImgView.layer.cornerRadius = 20;
        _headerImgView.layer.masksToBounds = true;
        [self.contentView addSubview:_headerImgView];
        [_headerImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(16);
            make.top.equalTo(self.contentView).offset(20);
            make.size.mas_equalTo(CGSizeMake(40, 40));
        }];
    }
    return _headerImgView;
}
- (UILabel *)timeLable {
    if (_timeLable == nil) {
        _timeLable = [[UILabel alloc] init];
        _timeLable.textColor = kHexRGBA(0x343339, 0.42);
        _timeLable.font = [UIFont systemFontOfSize:12];
//        _timeLable.alpha = 0.42;
        _timeLable.text = @"时间";
        [self.contentView addSubview:_timeLable];
        
    }
    return _timeLable;
}
- (UILabel *)nameLable {
    if (_nameLable == nil) {
        _nameLable = [[UILabel alloc] init];
        _nameLable.textColor = kHexRGBA(0x0B0817, 0.6);
        _nameLable.font = [UIFont systemFontOfSize:12];
        _nameLable.text = @"姓名";
        [self.contentView addSubview:_nameLable];
//        [_nameLable mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.bottom.equalTo(self.containerView.mas_top).offset(-4);
//            make.left.equalTo(self.contentView).offset(64);
//        }];
    }
    return _nameLable;
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
        _progressView.backgroundColor = kHexRGB(0x00BD9A);
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
        _containerView.layer.cornerRadius = 12;
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
        NSString *str1 = @"14";
        NSString *str2 = @"15";
        NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@/%@",str1,str2]];
        [attrStr addAttribute:NSForegroundColorAttributeName value:kHexRGB(0x00BD9A) range:NSMakeRange(0, str1.length)];
        self.hintLabel.attributedText = attrStr;
        [self.nameLable mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.containerView.mas_top).offset(-4);
            make.right.equalTo(self.contentView).offset(-64);
        }];
        [self.timeLable mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(64);
            make.bottom.equalTo(self.nameLable);
        }];
//        self.hintLabel.text = @"123123";
    }else {
        self.progressBgView.hidden = true;
        self.hintLabel.text = @"已读/未读";
        [self.headerImgView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(16);
        }];
        [self.nameLable mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.containerView.mas_top).offset(-4);
            make.left.equalTo(self.contentView).offset(64);
        }];
        [self.timeLable mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView).offset(-64);
            make.bottom.equalTo(self.nameLable);
        }];
    }
    self.progressView.hidden = self.progressBgView.hidden;
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:model.imgUrl]];
}

@end
