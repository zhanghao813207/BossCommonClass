//
//  AlertToolViewController.m
//  flashman
//
//  Created by yjs on 2019/10/23.
//  Copyright © 2019 white. All rights reserved.
//

#import "AlertToolViewController.h"
#import "JYCSimpleToolClass.h"
@interface AlertToolViewController ()

@end

@implementation AlertToolViewController

+ (void)showPermissionAlert:(PermissionType)type{
    NSString *message = @"BOSS当家";
#ifdef kBossKnight
    message = @"BOSS骑士";
#endif
    //配置对应提示文字
    NSString *permissionTypeString;
    switch (type) {
        case CameraPermission:
            permissionTypeString = @"相机";
            break;
        case PhotoLibraryPermission:
            permissionTypeString = @"相册";
            break;
            
        default:
            break;
    }
    
    UIAlertController *permissionAlertController = [UIAlertController alertControllerWithTitle:@"温馨提示" message:[NSString stringWithFormat:@"需要您允许%@打开%@权限才能使用哦~去\"设置->隐私->%@\"开启一下吧",message,permissionTypeString,permissionTypeString] preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *setAction = [UIAlertAction actionWithTitle:@"设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        if ([[UIApplication sharedApplication] canOpenURL:url]) {
            [[UIApplication sharedApplication] openURL:url];
            
        }
    }];
    [permissionAlertController addAction:setAction];
    [permissionAlertController addAction:cancleAction];
    [[JYCSimpleToolClass getCurrentVC] presentViewController:permissionAlertController animated:YES completion:nil];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)showWBAler:(UIViewController *)viewController {
    [viewController presentViewController:self animated:YES completion:nil];
    //    [[self getCurrentVC] presentViewController:self animated:YES completion:nil];
}

/**
 得到当前控制视图
 
 @return 当前控制视图
 */
-(UIViewController *)getCurrentVC
{
    UIViewController *result = nil;
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tempWindow in windows)
        {
            if (tempWindow.windowLevel == UIWindowLevelNormal)
            {
                window = tempWindow;
                break;
            }
        }
    }
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    return result;
}

//重写方法
+ (instancetype)initWBAlerControllerWithTitle:(nullable NSString *)title message:(nullable NSString *)message style:(NSString *)style titleArr:(NSMutableArray *)titleArr alerAction:(void (^)(NSInteger index))alerAction{
    //参数说明:
    //title表示弹框的标题;
    //message表示弹框的展示的信息;
    //style是0或者1;代表弹框的类型;UIAlertControllerStyleActionSheet = 0,UIAlertControllerStyleAlert = 1;
    //titleArr为弹框中出现的按钮标题的数组;个数你自己决定;
    //alerAction为block回调事件,因为这里只需要判断点击的按钮坐标就可以,其他需要壳自行添加参数;
    
    //判断弹框类型
    if ([style isEqualToString:@"1"]) {
        AlertToolViewController *alert = [AlertToolViewController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
        for (NSInteger i = 0; i < titleArr.count; i++) {
            UIAlertAction *confirm = [UIAlertAction actionWithTitle:[titleArr objectAtIndex:i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                if (alerAction) {
                    alerAction(i);
                }
                
            }];
            [alert addAction:confirm];
        }
        return alert;
        
    }else{
        AlertToolViewController *alert = [AlertToolViewController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleActionSheet];
        for (NSInteger i = 0; i < titleArr.count; i++) {
            
            //如果是取消的话 改变下样式
            NSString *title = [titleArr objectAtIndex:i];
            UIAlertActionStyle style = UIAlertActionStyleDefault;
            if ([title isEqualToString:@"取消"]){
                style = UIAlertActionStyleCancel;
            }
            UIAlertAction *confirm = [UIAlertAction actionWithTitle:[titleArr objectAtIndex:i] style:style handler:^(UIAlertAction * _Nonnull action) {
                
                if (alerAction) {
                    alerAction(i);
                }
                
            }];
            [alert addAction:confirm];
        }
        
        return alert;
    }
    
}

@end
