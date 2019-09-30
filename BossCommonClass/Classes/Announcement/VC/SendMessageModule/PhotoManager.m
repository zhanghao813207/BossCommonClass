//
//  PhotoManager.m
//  BossCommonClass
//
//  Created by 高炀辉 on 2019/7/2.
//

#import "PhotoManager.h"
#import <AVFoundation/AVFoundation.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "UIViewController+StoryBoard.h"
#import "ChooseImageVc.h"
#import "JYCSimpleToolClass.h"

@interface PhotoManager()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@end

@implementation PhotoManager

static PhotoManager * sharedSingleton = nil;

+ (PhotoManager *) sharedInstance {
    if (sharedSingleton == nil) {
        sharedSingleton = [[PhotoManager alloc] init];
    }
    return sharedSingleton;
}
- (void)pickChooseManagerWithBlock:(nonnull chooseImageBlock)chooseImageBlock{
    self.chooseImageBlock = ^(UIImage * _Nonnull image) {
        chooseImageBlock(image);
    };
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *photoAction = [UIAlertAction actionWithTitle:@"图库选取" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self showPhotoLibary];
    }];
    UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:@"立即拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self showCamera];
    }];
    
    [alertController addAction:cancelAction];
    [alertController addAction:photoAction];
    [alertController addAction:cameraAction];
    [[self topMostController] presentViewController:alertController animated:YES completion:nil];
}

- (void)showPhotoLibary{
    // 以"检查用户对相册的授权状态"为例
    
    // 返回用户对相册的授权状态
    ALAuthorizationStatus authorizationStatus = [ALAssetsLibrary authorizationStatus];
    // 处理不同授权状态下的操作流程
    switch (authorizationStatus)
    {
        case ALAuthorizationStatusNotDetermined:
        {
            // 用户没有选择是否授权使用
            // 申请授权
            [AVCaptureDevice requestAccessForMediaType:(AVMediaTypeVideo) completionHandler:^(BOOL granted) {
                if (granted) {
                    // 允许
                    dispatch_async(dispatch_get_main_queue(), ^{
                        // UI更新代码
                        [self alertPhotoLibary];
                    });
                } else {
                    // 不允许
                }
            }];
            // 用户没有选择是否授权使用
        }
            break;
        case ALAuthorizationStatusRestricted:
        {
            // 用户禁止使用,且授权状态不可修改,可能由于家长控制功能
        }
            break;
        case ALAuthorizationStatusDenied:
        {
            // 用户已经禁止使用
        }
            break;
        case ALAuthorizationStatusAuthorized:
        {
            // 用户已经授权使用
            [self alertPhotoLibary];
        }
            break;
    }
}
- (void)showCamera{
    // 以"检查用户对视频媒体类型的授权状态"为例
    
    // 返回用户对视频媒体类型的授权状态
    AVAuthorizationStatus authorizationStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    // 处理不同授权状态下的操作流程
    switch (authorizationStatus)
    {
        case AVAuthorizationStatusNotDetermined:
        {
            // 用户没有选择是否授权使用
            // 申请授权
            [AVCaptureDevice requestAccessForMediaType:(AVMediaTypeVideo) completionHandler:^(BOOL granted) {
                if (granted) {
                    // 允许
                    dispatch_async(dispatch_get_main_queue(), ^{
                        // UI更新代码
                        [self alertcamera];
                    });
                } else {
                    // 不允许
                }
            }];
        }
            break;
        case AVAuthorizationStatusRestricted:
        {
            // 用户禁止使用,且授权状态不可修改,可能由于家长控制功能
        }
            break;
        case AVAuthorizationStatusDenied:
        {
            // 用户已经禁止使用
        }
            break;
        case AVAuthorizationStatusAuthorized:
        {
            // 用户已经授权使用
            [self alertcamera];
        }
            break;
    }
}
- (void)alertPhotoLibary{
    // 创建图像选取控制器对象
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    // 将资源类型设置为相册类型
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    // 将媒体类型设置为图片类型和视频类型(数组中如果只写一个,图像选择控制器即只能选取图片/视频)
//    picker.mediaTypes = @[(NSString *)kUTTypeImage, (NSString *)kUTTypeMovie];
    // 设置选取后的图片允许编辑
    picker.allowsEditing = NO;
    // 设置代理,需要遵守两个协议
    picker.delegate = self;
    // 弹出图像选取控制器
    // iOS 13 的 presentViewController 默认有视差效果，模态出来的界面现在默认都下滑返回。 一些页面必须要点确认才能消失的，需要适配。
    // 如果项目中页面高度全部是屏幕尺寸，那么多出来的导航高度会出现问题。
    picker.modalPresentationStyle = UIModalPresentationFullScreen;
    [[self topMostController] presentViewController:picker animated:YES completion:nil];
}
- (void)alertcamera{
    // 创建图像选取控制器对象
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    // 将资源类型设置为相机类型
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    // 将媒体类型设置为图片类型和视频类型(数组中如果只写一个,图像选择控制器即只允许拍照/录像)
//    picker.mediaTypes = @[(NSString *)kUTTypeImage, (NSString *)kUTTypeMovie];
    // 设置拍照后的图片允许编辑
    picker.allowsEditing = NO;
    // 设置摄像图像品质,默认是UIImagePickerControllerQualityTypeMedium
    picker.videoQuality = UIImagePickerControllerQualityTypeHigh;
    // 设置最长摄像时间,默认是10秒
    picker.videoMaximumDuration = 30;
    // 设置代理,需要遵守两个协议
    picker.delegate = self;
    // 弹出图像选取控制器
    // iOS 13 的 presentViewController 默认有视差效果，模态出来的界面现在默认都下滑返回。 一些页面必须要点确认才能消失的，需要适配。
    // 如果项目中页面高度全部是屏幕尺寸，那么多出来的导航高度会出现问题。
    picker.modalPresentationStyle = UIModalPresentationFullScreen;
    [[self topMostController] presentViewController:picker animated:true completion:nil];

}
// 找到最顶部控制器
- (UIViewController*)topMostController
{
    UIViewController *topController = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    while (topController.presentedViewController) {
        topController = topController.presentedViewController;
    }
    
    return topController;
}
- (UIViewController*)topViewControllerWithRootViewController:(UIViewController*)rootViewController {
    
    if ([rootViewController isKindOfClass:[UITabBarController class]]) {
        
        UITabBarController* tabBarController = (UITabBarController*)rootViewController;
        
        return [self topViewControllerWithRootViewController:tabBarController.selectedViewController];
        
    } else if ([rootViewController isKindOfClass:[UINavigationController class]]) {
        
        UINavigationController* navigationController = (UINavigationController*)rootViewController;
        
        return [self topViewControllerWithRootViewController:navigationController.visibleViewController];
        
    } else if (rootViewController.presentedViewController) {
        
        UIViewController* presentedViewController = rootViewController.presentedViewController;
        
        return [self topViewControllerWithRootViewController:presentedViewController];
        
    } else {
        
        return rootViewController;
        
    }
    
    
    
}
// 操作完成
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image  = [info valueForKey:@"UIImagePickerControllerOriginalImage"];
    
    if (picker.sourceType == UIImagePickerControllerSourceTypePhotoLibrary) {
        
        ChooseImageVc * vc = [ChooseImageVc storyBoardCreateViewControllerWithBundle:@"BossCommonClass" StoryBoardName:@"EntrustAccountRegistration"];
        vc.image = image;
        vc.chooseImageBlock2 = ^(UIImage * _Nonnull image) {
            if (self.chooseImageBlock){
                self.chooseImageBlock(image);
            }
        };
        [[self topViewControllerWithRootViewController:UIApplication.sharedApplication.keyWindow.rootViewController].navigationController pushViewController:vc animated:true];
    } else {
        if (self.chooseImageBlock){
            self.chooseImageBlock(image);
        }
        [[self topMostController] dismissViewControllerAnimated:true completion:nil];
    }
    
}

// 操作取消
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    // 回收图像选取控制器
    [picker dismissViewControllerAnimated:YES completion:nil];
}
- (void)cameraConfig:(camertConfig)camertConfig{
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if (device) {
        AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        switch (status) {
            case AVAuthorizationStatusNotDetermined: {
                [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                    if (granted) {
                        dispatch_sync(dispatch_get_main_queue(), ^{
//                            [self.navigationController pushViewController:scanVC animated:YES];
                            if (camertConfig){
                                camertConfig();
                            }
                        });
                        NSLog(@"用户第一次同意了访问相机权限 - - %@", [NSThread currentThread]);
                    } else {
                        NSLog(@"用户第一次拒绝了访问相机权限 - - %@", [NSThread currentThread]);
                    }
                }];
                break;
            }
            case AVAuthorizationStatusAuthorized: {
                if (camertConfig){
                    camertConfig();
                }
//                [self.navigationController pushViewController:scanVC animated:YES];
                break;
            }
            case AVAuthorizationStatusDenied: {
                UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"请去-> [设置 - 隐私 - 相机 - SGQRCodeExample] 打开访问开关" preferredStyle:(UIAlertControllerStyleAlert)];
                UIAlertAction *alertA = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
                    
                }];
                
                [alertC addAction:alertA];
                [[JYCSimpleToolClass getCurrentVC] presentViewController:alertC animated:YES completion:nil];
                break;
            }
            case AVAuthorizationStatusRestricted: {
                NSLog(@"因为系统原因, 无法访问相册");
                break;
            }
                
            default:
                break;
        }
        return;
    }
    
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"未检测到您的摄像头" preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *alertA = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alertC addAction:alertA];
    
    [[JYCSimpleToolClass getCurrentVC] presentViewController:alertC animated:YES completion:nil];
}
@end
