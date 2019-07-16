//
//  UIView+ImagePick.h
//  Bapp_v2.3_new
//
//  Created by 贾远潮 on 16/5/5.
//  Copyright © 2016年 wifier. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (ImagePick)<UINavigationControllerDelegate,UIImagePickerControllerDelegate>

- (void)pickImageFromPhotoOrCameraWithImageBlock:(void (^)(UIImage *imageResult))imageBlock;

- (void)removeImageFromPhotoOrCamera;


@end
