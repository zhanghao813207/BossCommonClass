//
//  KNPhotoBaseCell.m
//  KNPhotoBrowser
//
//  Created by LuKane on 2018/12/14.
//  Copyright © 2019 欧客云. All rights reserved.
//

#import "KNPhotoBaseCell.h"
#import "UIView+PBExtesion.h"
#import "KNProgressHUD.h"
#import "Masonry.h"

@implementation KNPhotoBaseCell{
    KNProgressHUD *_progressHUD;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupImageView];
        _playbutton = [[UIButton alloc] init];
        [_playbutton addTarget:self action:@selector(play) forControlEvents:UIControlEventTouchUpInside];
        [_playbutton setTintColor:UIColor.redColor];
        [_playbutton setTitle:@"" forState:UIControlStateNormal];
        [self.contentView addSubview:_playbutton];
        [_playbutton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.centerY.equalTo(self.contentView);
            make.width.height.offset(90);
        }];
        
        NSString *bundlePath = [[NSBundle bundleForClass:[self class]].resourcePath stringByAppendingPathComponent:@"/boss-message-ios.bundle"];
        NSBundle *bundle = [NSBundle bundleWithPath:bundlePath];
        self.playImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"playImage" inBundle:bundle  compatibleWithTraitCollection:nil]];
        [self.contentView addSubview:self.playImageView];
        
        [self.playImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.centerY.equalTo(self.contentView);
            make.width.height.offset(40);
        }];
        
    }
    return self;
}
- (void)play{
    if (self.playTap){
        self.playTap();
    }
}
- (void)setupImageView{
    // 1.photoBrowerView
    KNPhotoBrowserImageView *photoBrowerView = [[KNPhotoBrowserImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _photoBrowerImageView = photoBrowerView;
    [self.contentView addSubview:photoBrowerView];
    
    photoBrowerView.singleTap = ^{
        if (self->_singleTap) {
            self->_singleTap();
        }
    };
    
    photoBrowerView.longPressTap = ^{
        if (self->_longPressTap) {
            self->_longPressTap();
        }
    };
    
    // 2.progressHUD
    KNProgressHUD *progressHUD = [[KNProgressHUD alloc] initWithFrame:(CGRect){{([UIScreen mainScreen].bounds.size.width - 40) * 0.5,([UIScreen mainScreen].bounds.size.height - 40) * 0.5},{40,40}}];
    _progressHUD = progressHUD;
    [self.contentView addSubview:progressHUD];
}

- (void)sd_ImageWithUrl:(NSString *)url placeHolder:(UIImage *)placeHolder{
    [_photoBrowerImageView sd_ImageWithUrl:[NSURL URLWithString:url]
                               progressHUD:_progressHUD
                               placeHolder:placeHolder];
}

- (void)prepareForReuse{
    [_photoBrowerImageView.scrollView setZoomScale:1.f animated:false];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [_photoBrowerImageView.scrollView setZoomScale:1.f animated:false];
    _photoBrowerImageView.frame = self.bounds;
    _progressHUD.center = self.contentView.center;
}

@end
