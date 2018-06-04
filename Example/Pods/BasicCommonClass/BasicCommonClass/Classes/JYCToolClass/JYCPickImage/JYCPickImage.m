//
//  JYCPickImage.m
//  BasicCommonClass
//
//  Created by 贾远潮 on 2018/3/12.
//

#import "JYCPickImage.h"

@interface JYCPickImage()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property (nonatomic, strong) UIImagePickerController *imagePicker;

@property (nonatomic, copy) void(^finishBlock)(UIImage *pickImage);

@property (nonatomic, copy) void(^cancelBlock)();

@property (nonatomic, assign) BOOL edite;

@end

@implementation JYCPickImage
static JYCPickImage *picker = nil;

/**
 拍照获取图片
 
 @param edite 图片是否能够编辑
 @param finishBlock 选取完成回调
 @param cancelBlock 取消选取图片回调
 @param viewController 弹出拍照的控制器
 */
+ (__kindof JYCPickImage *)pickImageFromCameraCanEdite:(BOOL)edite Finish:(void(^)(UIImage *pickImage))finishBlock cancel:(void(^)())cancelBlock viewController:(UIViewController *)viewController
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        picker = [[JYCPickImage alloc] init];
    });
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
        picker.imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        picker.edite = edite;
        picker.finishBlock = finishBlock;
        picker.cancelBlock = cancelBlock;
        [viewController.navigationController presentViewController:picker.imagePicker animated:YES completion:nil];
    }
    return picker;
}

#pragma mark -- ImagePickView
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSLog(@"选取图片调用");
    //    info 中的key值
    //    NSString *const  UIImagePickerControllerMediaType ;指定用户选择的媒体类型（文章最后进行扩展）
    //    NSString *const  UIImagePickerControllerOriginalImage ;原始图片
    //    NSString *const  UIImagePickerControllerEditedImage ;修改后的图片
    //    NSString *const  UIImagePickerControllerCropRect ;裁剪尺寸
    //    NSString *const  UIImagePickerControllerMediaURL ;媒体的URL
    //    NSString *const  UIImagePickerControllerReferenceURL ;原件的URL
    //    NSString *const  UIImagePickerControllerMediaMetadata;当来数据来源是照相机的时候这个值才有效
    [picker dismissViewControllerAnimated:YES completion:^{
        if (self.finishBlock) {
            UIImage *pickImage;
            if (self.edite) {
                pickImage = info[@"UIImagePickerControllerEditedImage"];
            } else {
                pickImage = info[@"UIImagePickerControllerOriginalImage"];
            }
            self.finishBlock(pickImage);
        }
    }];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    NSLog(@"取消选取");
    [picker dismissViewControllerAnimated:YES completion:^{
        if (self.cancelBlock) {
            self.cancelBlock();
        }
    }];
}


- (UIImagePickerController *)imagePicker
{
    if (!_imagePicker) {
        _imagePicker = [[UIImagePickerController alloc] init];
        _imagePicker.delegate = self;
    }
    return _imagePicker;
}

@end
