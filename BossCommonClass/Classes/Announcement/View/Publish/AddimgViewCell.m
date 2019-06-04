

//
//  AddimgViewCell.m
//  AFNetworking
//
//  Created by admin on 2019/4/16.
//

#import "AddimgViewCell.h"
#import "Masonry.h"
#import "BossMethodDefine.h"

@interface AddimgViewCell ()


@property(nonatomic, strong)UIButton *deletButton;


@end

@implementation AddimgViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self imgView];
        [self deletButton];
        
        self.contentView.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)setImage:(UIImage *)image {
    _image = image;
    self.imgView.image = image;
}

- (UIButton *)deletButton {
    if (_deletButton == nil) {
        _deletButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        _deletButton.backgroundColor = [UIColor purpleColor];
        UIImage *deleteImage = [UIImage imageNamed:@"delete" inBundle:QH_Bundle  compatibleWithTraitCollection:nil];
        [_deletButton setImage:deleteImage forState:UIControlStateNormal];
        [_deletButton addTarget:self action:@selector(deleteAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_deletButton];
        [self.deletButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.imgView.mas_right);
            make.centerY.equalTo(self.imgView.mas_top);
            make.size.mas_equalTo(CGSizeMake(20, 20));
        }];
    }
    return _deletButton;
}
- (void)deleteAction:(UIButton *)button {
    if (self.delegate && [self.delegate respondsToSelector:@selector(deleteImage:)]) {
        [self.delegate deleteImage:self.image];
    }
}
- (UIImageView *)imgView {
    if (_imgView == nil) {
        _imgView = [[UIImageView alloc] init];
        _imgView.backgroundColor = [UIColor redColor];
        _imgView.userInteractionEnabled = true;
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
        [_imgView addGestureRecognizer:tapGesture];
        [self.contentView addSubview:_imgView];
        [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView);
            make.left.equalTo(self.contentView);
            make.size.mas_equalTo(CGSizeMake(88, 75));
        }];
    }
    return _imgView;
}
- (void)tapAction {
    if (self.delegate && [self.delegate respondsToSelector:@selector(clickImg:)]) {
        [self.delegate clickImg:self.image];
    }
}
@end
