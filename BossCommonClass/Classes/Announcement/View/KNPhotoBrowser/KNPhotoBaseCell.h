//
//  KNPhotoBaseCell.h
//  KNPhotoBrowser
//
//  Created by LuKane on 2018/12/14.
//  Copyright © 2019 欧客云. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KNPhotoBrowserImageView.h"
#import "KNProgressHUD.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^PhotoBrowerSingleTap)(void);
typedef void(^PhotoBrowerLongPressTap)(void);

typedef void(^PhotoBrowerplayTap)(void);

@interface KNPhotoBaseCell : UICollectionViewCell

- (void)sd_ImageWithUrl:(NSString *)url placeHolder:(UIImage *)placeHolder;

@property (nonatomic,strong) KNPhotoBrowserImageView *photoBrowerImageView;
@property (nonatomic,strong) UIImageView *playImageView;

@property (nonatomic,strong) UIButton *playbutton;
@property (nonatomic,copy  ) PhotoBrowerSingleTap singleTap;
@property (nonatomic,copy  ) PhotoBrowerLongPressTap longPressTap;
@property (nonatomic,copy  ) PhotoBrowerplayTap playTap;
@end

NS_ASSUME_NONNULL_END
