
//
//  AnnouncementDetailHeaderView.m
//  AFNetworking
//
//  Created by admin on 2019/4/14.
//

#import "AnnouncementDetailHeaderView.h"
#import "Masonry.h"
#import "JYCMethodDefine.h"
#import "BossMethodDefine.h"

@interface AnnouncementDetailHeaderView()

/**
 包含头像 名称 时间
 */
@property(nonatomic, strong)UIView *containerView;
@property(nonatomic, strong)UIImageView *imgView;
@property(nonatomic, strong)UILabel *nameLabel;
@property(nonatomic, strong)UILabel *timeLabel;

/**
 大标题
 */
@property(nonatomic, strong)UILabel *titleLabel;
///内容
@property(nonatomic, strong)UILabel *contentLabel;



@end

@implementation AnnouncementDetailHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}
- (void)setModel:(AnnouncementDetail *)model {
    _model = model;
    self.nameLabel.text = model.sender_info.nick_name;
    self.timeLabel.text = model.time;
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.alignment = NSTextAlignmentJustified;
    paragraphStyle.lineSpacing = 6;
    
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:model.content attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 16],NSForegroundColorAttributeName: [UIColor colorWithRed:52/255.0 green:51/255.0 blue:57/255.0 alpha:1.0],NSParagraphStyleAttributeName:paragraphStyle,NSKernAttributeName:@(2)}];
    self.contentLabel.attributedText = string;
    self.titleLabel.text = model.title;
    if (model.sender_info.isMe) {
        
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(16);
            make.top.equalTo(self).offset(16);
            make.right.equalTo(self).offset(-16);
        }];
        [self addSubview:self.timeLabel];
        [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.titleLabel);
            make.top.equalTo(self.titleLabel.mas_bottom).offset(10);
        }];
        [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(16);
            make.right.equalTo(self).offset(-16);
            make.top.equalTo(self.timeLabel.mas_bottom).offset(16);
            make.bottom.equalTo(self).offset(-16);
        }];
    }else {
        [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(self);
            make.height.equalTo(@70);
        }];
        
        [self.containerView addSubview:self.imgView];
        [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(16);
            make.top.equalTo(self).offset(15);
            make.size.mas_equalTo(CGSizeMake(40, 40));
        }];
        
        [self.containerView addSubview:self.nameLabel];
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.imgView);
            make.left.equalTo(self.imgView.mas_right).offset(10);
        }];
        
        [self.containerView addSubview:self.timeLabel];
        [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.imgView);
            make.right.equalTo(self).offset(-16);
        }];
        
        
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(16);
            make.right.equalTo(self).offset(-16);
            make.top.equalTo(self.containerView.mas_bottom).offset(20);
        }];
        [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(16);
            make.right.equalTo(self).offset(-16);
            make.top.equalTo(self.titleLabel.mas_bottom).offset(16);
            make.bottom.equalTo(self).offset(-16);
        }];
    }
}
- (UIView *)containerView {
    if (_containerView == nil) {
        _containerView = [[UIView alloc] init];
        _containerView.backgroundColor = [UIColor colorWithRed:247 / 255.0 green:250 / 255.0 blue:251 / 255.0 alpha:1];
        [self addSubview:_containerView];
    }
    return _containerView;
}
- (UILabel *)nameLabel {
    if (_nameLabel == nil) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.text = @"名称";
        _nameLabel.textColor = kHexRGBA(0x0B0817, 0.6);
        _nameLabel.font = [UIFont systemFontOfSize:16];
    }
    return _nameLabel;
}
- (UILabel *)timeLabel {
    if (_timeLabel == nil) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.text = @"时间";
        _timeLabel.font = [UIFont systemFontOfSize:14];
        _timeLabel.textColor = kHexRGB(0x343339);
        _timeLabel.alpha = 0.42;
    }
    return _timeLabel;
}
- (UIImageView *)imgView {
    if (_imgView == nil) {
        _imgView = [[UIImageView alloc] init];
        UIImage *image = [UIImage imageNamed:@"addressbook_userDefaultIcon" inBundle:QH_Bundle  compatibleWithTraitCollection:nil];
        _imgView.image = image;
//        _imgView.layer.cornerRadius = 20;
//        _imgView.layer.masksToBounds = true;
    }
    return _imgView;
}
- (UILabel *)titleLabel {
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.numberOfLines = 0;
        _titleLabel.font = [UIFont boldSystemFontOfSize:24];
//        _titleLabel.text = @"活动上线通知";
        [self addSubview:_titleLabel];
    }
    return _titleLabel;
}
- (UILabel *)contentLabel {
    if (_contentLabel == nil) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.numberOfLines = 0;
        _contentLabel.backgroundColor = [UIColor whiteColor];
        _contentLabel.font = [UIFont systemFontOfSize:16];
       
        _contentLabel.textAlignment = NSTextAlignmentJustified;
        [self addSubview:_contentLabel];
    }
    return _contentLabel;
}

@end
