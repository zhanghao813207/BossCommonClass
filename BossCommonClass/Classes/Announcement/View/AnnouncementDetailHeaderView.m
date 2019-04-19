
//
//  AnnouncementDetailHeaderView.m
//  AFNetworking
//
//  Created by admin on 2019/4/14.
//

#import "AnnouncementDetailHeaderView.h"
#import "Masonry.h"
#import "JYCMethodDefine.h"

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



///////test
@property(nonatomic, assign)BOOL isMe;
@end

@implementation AnnouncementDetailHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.isMe = true;
    }
    return self;
}
- (void)setIsMe:(BOOL)isMe {
    _isMe = isMe;
    if (isMe) {
        
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(16);
            make.top.equalTo(self).offset(16);
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
//    [self contentLabel];
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
        _imgView.backgroundColor = [UIColor orangeColor];
        _imgView.layer.cornerRadius = 20;
        _imgView.layer.masksToBounds = true;
    }
    return _imgView;
}
- (UILabel *)titleLabel {
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.numberOfLines = 0;
        _titleLabel.font = [UIFont boldSystemFontOfSize:24];
        _titleLabel.text = @"活动上线通知";
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
        NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"从 2015 年 4 月起，Ant Design 在蚂蚁金服中后台产品线迅速推广，对接多条业务线，覆盖系统 800 个以上。定位于中台业务的 Ant Design 兼顾专业和非专业的设计人员，具有学习成本低、上手速度快、实现效果好具有学习成本低、上手速度快、实现效果好等特点等特点，并且提供从界面设计到前端开发的全链路生态，可提升设计和开发的效率。"attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 16],NSForegroundColorAttributeName: [UIColor colorWithRed:52/255.0 green:51/255.0 blue:57/255.0 alpha:1.0]}];
        
        _contentLabel.attributedText = string;
        _contentLabel.textAlignment = NSTextAlignmentJustified;
        [self addSubview:_contentLabel];
    }
    return _contentLabel;
}

@end
