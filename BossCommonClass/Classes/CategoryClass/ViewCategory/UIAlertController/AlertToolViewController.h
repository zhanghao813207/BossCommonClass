//
//  AlertToolViewController.h
//  flashman
//
//  Created by yjs on 2019/10/23.
//  Copyright © 2019 欧客云. All rights reserved.
//

#import <UIKit/UIKit.h>

//隐私权限类型枚举
typedef enum : NSUInteger {
    //相机权限
    CameraPermission,
    //相册权限
    PhotoLibraryPermission,
    //位置权限
}PermissionType;

NS_ASSUME_NONNULL_BEGIN

@interface AlertToolViewController : UIAlertController

/// 弹出需要配置权限的弹框
+ (void)showPermissionAlert:(PermissionType)type;

+ (instancetype)initWBAlerControllerWithTitle:(nullable NSString *)title message:(nullable NSString *)message style:(NSString *)style titleArr:(NSMutableArray *)titleArr alerAction:(void (^)(NSInteger index))alerAction;

-(void)showWBAler:(UIViewController *)viewController;
@end

NS_ASSUME_NONNULL_END
