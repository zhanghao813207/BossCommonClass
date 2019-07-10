//
//  UIView+ImagePick.m
//  Bapp_v2.3_new
//
//  Created by 贾远潮 on 16/5/5.
//  Copyright © 2016年 wifier. All rights reserved.
//

#import "UIView+ImagePick.h"
#import <objc/runtime.h>

@implementation UIView (ImagePick)

static char imageBlockKey;

- (void)setImageBlock:(void (^)(UIImage *imageResult))ImageBlock
{
    objc_setAssociatedObject(self, &imageBlockKey, ImageBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void (^)(UIImage *imageResult))imageBlock
{
    return objc_getAssociatedObject(self, &imageBlockKey);
}

- (void)pickImageFromPhotoOrCameraWithImageBlock:(void (^)(UIImage *imageResult))imageBlock
{
    if (imageBlock) {
        self.imageBlock = imageBlock;
    }
    if (!self.userInteractionEnabled) {
        self.userInteractionEnabled = YES;
    }
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pickImageTapGRAction:)];
    [self addGestureRecognizer:tapGR];
}


- (void)removeImageFromPhotoOrCamera
{
    for (UIGestureRecognizer *tapGR in [self gestureRecognizers]) {
        if ([tapGR isKindOfClass:[UITapGestureRecognizer class]]) {
            [self removeGestureRecognizer:tapGR];
        }
    }
}

- (void)pickImageTapGRAction:(UITapGestureRecognizer *)sender
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *photoAction = [UIAlertAction actionWithTitle:@"图库选取" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self fromPhotos];
    }];
    UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:@"立即拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self fromCamera];
    }];
    
    [alertController addAction:cancelAction];
    [alertController addAction:photoAction];
    [alertController addAction:cameraAction];
    [self.viewController presentViewController:alertController animated:YES completion:nil];
}



#pragma mark - UIImagePickerController
-(void)fromPhotos
{
    //初始化UIImagePickerController 指定代理
    UIImagePickerController * imagePicker = [[UIImagePickerController alloc] init];
    
    //选择类型相机，相册还是什么
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    // 去除毛玻璃效果 防止图库第一行图片被导航条遮挡
    imagePicker.navigationBar.translucent = NO;
    
    
    /*enum {
     UIImagePickerControllerSourceTypePhotoLibrary,
     UIImagePickerControllerSourceTypeCamera,
     UIImagePickerControllerSourceTypeSavedPhotosAlbum
     };
     typedef NSUInteger UIImagePickerControllerSourceType;
     */
    //指定代理 因此我们要实现 UIImagePickerControllerDelegate,UINavigationControllerDelegate 协议
    imagePicker.delegate = self;
    //允许编辑
    imagePicker.allowsEditing = YES;
    //显示相册
    [[self viewController].navigationController presentViewController:imagePicker animated:YES completion:nil];
    
}

-(void)fromCamera
{
    //这里先判断是否有相机，如果没有弹窗警告
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
        UIImagePickerController * imagePicker = [[UIImagePickerController alloc] init];
        // 去除毛玻璃效果 防止图库第一行图片被导航条遮挡
        imagePicker.navigationBar.translucent = NO;
        imagePicker.delegate = self;
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        imagePicker.allowsEditing = YES;
        [[self viewController].navigationController presentViewController:imagePicker animated:YES completion:nil];
        
    }else{
        NSLog(@"设备不可用");
    }
}

#pragma mark -- ImagePickView

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image  = [info valueForKey:@"UIImagePickerControllerEditedImage"];
    if (self.imageBlock) {
        self.imageBlock(image);
    }
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}


- (UIViewController *)viewController {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}


@end
