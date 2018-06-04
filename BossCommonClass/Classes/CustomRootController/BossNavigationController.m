//
//  BossNavigationController.m
//  BasicCommonClass
//
//  Created by 贾远潮 on 2018/3/12.
//

#import "BossNavigationController.h"
#import "UINavigationBar+BackgroundColor.h"
#import "BossBasicDefine.h"

@interface BossNavigationController ()<UINavigationControllerDelegate, UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIBarButtonItem *customCommentLeftBarButtonItem;

@end

@implementation BossNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //设置navigationBar的字体
    self.navigationBar.titleTextAttributes = @{NSFontAttributeName:BossRegularFont(18),NSForegroundColorAttributeName:[UIColor whiteColor]};
    
    //设置navigationBar背景色
    [self.navigationBar lt_setBackgroundColor:kAppMainColor];

}

//push的时候将手势禁用
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [super pushViewController:viewController animated:animated];
    if (viewController.navigationItem.leftBarButtonItem == nil && [self.viewControllers count] > 1)
    {
        viewController.navigationItem.leftBarButtonItem = self.customCommentLeftBarButtonItem;
    }
    //    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]){
    //        self.interactivePopGestureRecognizer.enabled = NO;
    //    }
}

//#pragma mark UINavigationControllerDelegate
//
////视图展示时启用手势
//- (void)navigationController:(UINavigationController *)navigationController
//       didShowViewController:(UIViewController *)viewController
//                    animated:(BOOL)animate
//{
//    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)])
//        self.interactivePopGestureRecognizer.enabled = YES;
//}
//
//- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
//
//    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)])
//        self.interactivePopGestureRecognizer.enabled = YES;
//}

- (UIBarButtonItem *)customCommentLeftBarButtonItem
{
    UIBarButtonItem *buttonItem_back = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"popBack"] style:UIBarButtonItemStyleDone target:self action:@selector(popToLastViewController:)];
    [buttonItem_back setTintColor:[UIColor whiteColor]];
    _customCommentLeftBarButtonItem = buttonItem_back;
    return _customCommentLeftBarButtonItem;
}

- (void)popToLastViewController:(UIBarButtonItem *)sender
{
    [self popViewControllerAnimated:YES];
}


@end
