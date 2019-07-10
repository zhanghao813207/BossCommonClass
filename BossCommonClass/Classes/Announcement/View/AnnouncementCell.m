
//
//  AnnouncementCell.m
//  即时通讯界面
//
//  Created by admin on 2019/4/11.
//  Copyright © 2019 admin. All rights reserved.
//

#import "AnnouncementCell.h"
#import "AnnoucementList.h"
#import "Masonry.h"
#import "UIImageView+WebCache.h"
#import "JYCMethodDefine.h"
#import "BossMethodDefine.h"
#import "Media_info.h"


@interface AnnouncementCell()


/**
 大背景
 */
@property(nonatomic, strong)UIImageView *bgView;
/**
 头像
 */
@property(nonatomic, strong)UIImageView *headerImgView;

/**
 以下视图的父视图
 */
@property(nonatomic, strong)UIView *containerView;

/**
 提示
 */
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
        [self titleLabel];
        [self hintLabel];
        [self lineView];
        [self clickLabel];
        [self progressBgView];
        [self progressView];
        [self timeLable];
        [self nameLable];
        self.contentView.backgroundColor = [UIColor colorWithRed:245 / 255.0 green:247 / 255.0 blue:249 / 255.0 alpha:1];
#ifdef kBossKnight
        [self.containerView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView).offset(-16);
        }];
      
#elif defined kBossManager
        
#else
        
#endif

    }
    return self;
}
- (UIImageView *)bgView {
    if (_bgView == nil) {
        UIImage *image = [UIImage imageNamed:@"bg" inBundle:QH_Bundle  compatibleWithTraitCollection:nil];
        _bgView = [[UIImageView alloc] initWithImage:image];
        _bgView.layer.cornerRadius = 20;
        _bgView.layer.masksToBounds = true;
//        _bgView.backgroundColor = [UIColor colorWithRed:235 / 255.0 green:237 / 255.0 blue:239 / 255.0 alpha:0.2];
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
        _imgView.backgroundColor = [UIColor whiteColor];
        _imgView.contentMode = UIViewContentModeScaleAspectFill;
        _imgView.clipsToBounds = true;
        [self.containerView addSubview:_imgView];
        [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(self.containerView);
            make.height.mas_equalTo(0);
        }];
    }
    return _imgView;
}
- (UILabel *)clickLabel {
    if (_clickLabel == nil) {
        _clickLabel = [[UILabel alloc] init];
        _clickLabel.text = @"查看详情 >";
        [_clickLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
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
//        _contentLabel.backgroundColor = [UIColor redColor];
        _contentLabel.alpha = 0.9;
        _contentLabel.textColor = kHexRGBA(0x343339, 0.9);
        [_contentLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
        [self.containerView addSubview:_contentLabel];
        [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.titleLabel).offset(0);
            make.top.equalTo(self.titleLabel.mas_bottom).offset(8);
            make.right.equalTo(self.containerView).offset(-16);
        }];
        
    }
    return _contentLabel;
}
- (UILabel *)titleLabel {
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.numberOfLines = 0;
        _titleLabel.font = [UIFont boldSystemFontOfSize:17];
//        _titleLabel.backgroundColor = [UIColor redColor];
        [_titleLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
        [self.containerView addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.containerView).offset(16);
            make.right.equalTo(self.containerView).offset(-16);
            make.top.equalTo(self.imgView.mas_bottom).offset(0);
        }];
    }
    return _titleLabel;
}
- (UIImageView *)headerImgView {
    if (_headerImgView == nil) {
        _headerImgView = [[UIImageView alloc] init];
//        _headerImgView.backgroundColor = [UIColor blackColor];
        _headerImgView.backgroundColor = [UIColor whiteColor];
        UIImage *image = [UIImage imageNamed:@"addressbook_userDefaultIcon" inBundle:QH_Bundle  compatibleWithTraitCollection:nil];
        _headerImgView.image = image;
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
        [self.progressBgView addSubview:_progressView];
        [_progressView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.bottom.equalTo(self.progressBgView);
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
        [_hintLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
        [self.contentView addSubview:_hintLabel];
        [_hintLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.containerView).offset(16);
            make.top.equalTo(self.containerView.mas_bottom).offset(2);
            make.bottom.equalTo(self.contentView).offset(-6);
        }];
    }
    return _hintLabel;
}
- (void)setModel:(AnnoucementList *)model {
    _model = model;
    NSLog(@"%@",model.sender_info._id);
    self.titleLabel.text = model.message_summary_info.title;
    self.contentLabel.text = model.message_summary_info.content;
    self.timeLable.text = model.message_summary_info.time;
 
    
    if (model.sender_info.isMe) {
//        self.nameLable.text = [self reversalString:model.sender_info.nick_name];
        self.nameLable.text = model.sender_info.nick_name;
        [self.headerImgView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset([UIScreen mainScreen].bounds.size.width - 56);
        }];
        self.progressBgView.hidden = false;
        NSString *str1 = [NSString stringWithFormat:@"%ld",model.message_counter_info.read_counter];
        
        NSString *str2 = [NSString stringWithFormat:@"%ld",model.message_counter_info.total_counter];
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
        NSLog(@"model.progress === %f",model.progress);
        [self.progressView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.top.bottom.equalTo(self.progressBgView);
            make.width.equalTo(self.progressBgView).multipliedBy(model.progress);
        }];
//        self.hintLabel.text = @"123123";
    }else {
        self.nameLable.text = model.sender_info.nick_name;
        self.progressBgView.hidden = true;
        self.hintLabel.text = model.is_read ? @"已读":@"未读";
        
        [self.headerImgView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(16);
        }];
        [self.nameLable mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.containerView.mas_top).offset(-4);
            make.left.equalTo(self.contentView).offset(64);
        }];
        [self.timeLable mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.containerView.mas_top).offset(-4);
            make.right.equalTo(self.contentView).offset(-64);
        }];
        [self.progressView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.top.bottom.equalTo(self.progressBgView);
            make.width.equalTo(self.progressBgView).multipliedBy(0);
        }];
        
#ifdef kBossKnight
        [self.timeLable mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView).offset(-16);
            make.bottom.equalTo(self.nameLable);
        }];
        
#elif defined kBossManager
        [self.timeLable mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView).offset(-64);
            make.bottom.equalTo(self.nameLable);
        }];
#else
        
#endif
    }
    self.progressView.hidden = self.progressBgView.hidden;
    NSLog(@"%@",model.media_info_list);
    if (model.media_info_list.count > 0) {
        Media_info *info = model.media_info_list.firstObject;
        UIImage *placeImage = [UIImage imageNamed:@"placehold_Image" inBundle:QH_Bundle  compatibleWithTraitCollection:nil];
       [self.imgView sd_setImageWithURL:[NSURL URLWithString:info.url] placeholderImage:placeImage];
        [self.imgView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(@150);
        }];
    }else {
        [self.imgView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(0);
        }];
    }
    
    [self.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imgView.mas_bottom).offset(10);
    }];
}
- (NSString *)reversalString:(NSString *)originString{
    NSString *resultStr = @"";
    for (NSInteger i = originString.length -1; i >= 0; i--) {
        NSString *indexStr = [originString substringWithRange:NSMakeRange(i, 1)];
        resultStr = [resultStr stringByAppendingString:indexStr];
    }
    return resultStr;
}
@end
