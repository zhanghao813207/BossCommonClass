
//
//  AnnouncementDetailCell.m
//  AFNetworking
//
//  Created by admin on 2019/4/14.
//

#import "AnnouncementDetailCell.h"
#import "Masonry.h"
#import "UIImageView+WebCache.h"

@interface AnnouncementDetailCell()

@end

@implementation AnnouncementDetailCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self imgView];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = UIColor.whiteColor;
    }
    return self;
}
- (UIImageView *)imgView {
    if (_imgView == nil) {
        _imgView = [[UIImageView alloc] init];
        _imgView.userInteractionEnabled = true;
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
        [_imgView addGestureRecognizer:tapGesture];
        [self.contentView addSubview:_imgView];
        [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(16);
            make.right.equalTo(self.contentView).offset(-16);
            make.bottom.equalTo(self.contentView);
            make.top.equalTo(self.contentView).offset(10);
            make.height.equalTo(@221);
        }];
    }
    return _imgView;
}
- (void)tapAction {
    if (self.delegate && [self.delegate respondsToSelector:@selector(imgClick:)]) {
        [self.delegate imgClick:self.testImgStr];
    }
}
- (void)setTestImgStr:(NSArray *)testImgStr {
    _testImgStr = testImgStr;
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:testImgStr]];
}

@end
