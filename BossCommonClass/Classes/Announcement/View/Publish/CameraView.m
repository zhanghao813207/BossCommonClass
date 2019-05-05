//
//  CameraView.m
//  AFNetworking
//
//  Created by admin on 2019/4/18.
//

#import "CameraView.h"
#import "Masonry.h"
#import "BossMethodDefine.h"

@interface CameraView ()
@property(nonatomic, strong)UIButton *cameraButton;
@property(nonatomic, strong)UIButton *photoButton;
@end

@implementation CameraView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self photoButton];
        [self cameraButton];
    }
    return self;
}
- (UIButton *)photoButton {
    if (_photoButton == nil) {
        _photoButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        _photoButton.backgroundColor = [UIColor blackColor];
        [_photoButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        UIImage *image = [UIImage imageNamed:@"photo" inBundle:QH_Bundle  compatibleWithTraitCollection:nil];
        [_photoButton setImage:image forState:UIControlStateNormal];
        _photoButton.tag = PictureTypePhoto;
        [self addSubview:_photoButton];
        [_photoButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(16);
            make.centerY.equalTo(self);
            make.size.mas_equalTo(CGSizeMake(40, 40));
        }];
    }
    return _photoButton;
}
- (void)buttonAction:(UIButton *)button {
    if (self.delegate && [self.delegate respondsToSelector:@selector(pictureSelect:)]) {
        [self.delegate pictureSelect:button.tag];
    }
}
- (UIButton *)cameraButton {
    if (_cameraButton == nil) {
        _cameraButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        _cameraButton.backgroundColor = [UIColor blackColor];
        _cameraButton.tag = PictureTypeCamera;
        UIImage *image = [UIImage imageNamed:@"camera" inBundle:QH_Bundle  compatibleWithTraitCollection:nil];
        [_cameraButton setImage:image forState:UIControlStateNormal];
        [_cameraButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_cameraButton];
        [_cameraButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).offset(-16);
            make.centerY.equalTo(self.photoButton);
            make.size.mas_equalTo(CGSizeMake(40, 40));
        }];
    }
    return _cameraButton;
}
@end
