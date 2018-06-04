//
//  BossWhiteNavigationController.m
//  BasicCommonClass
//
//  Created by 贾远潮 on 2018/3/12.
//

#import "BossWhiteNavigationController.h"
#import "UINavigationBar+BackgroundColor.h"
#import "BossBasicDefine.h"

@interface BossWhiteNavigationController ()<UINavigationControllerDelegate, UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIBarButtonItem *customCommentLeftBarButtonItem;

@end

@implementation BossWhiteNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //判断是否支持右滑手势
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.delegate = self;
        self.delegate = self;
        self.interactivePopGestureRecognizer.enabled = NO;
    }

    //设置navigationBar的字体
    self.navigationBar.titleTextAttributes = @{NSFontAttributeName:BossBlodFont(18),NSForegroundColorAttributeName:kHexRGBA(0x000000, 0.8)};
    
    //设置navigationBar背景色
    [self.navigationBar lt_setBackgroundColor:[UIColor whiteColor]];
    self.navigationBar.translucent = NO;
}

//push的时候将手势禁用
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [super pushViewController:viewController animated:animated];
    if (viewController.navigationItem.leftBarButtonItem == nil && [self.viewControllers count] > 1)
    {
        viewController.navigationItem.leftBarButtonItem = self.customCommentLeftBarButtonItem;
    }
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]){
        self.interactivePopGestureRecognizer.enabled = NO;
    }
}

#pragma mark UINavigationControllerDelegate

//视图展示时启用手势
- (void)navigationController:(UINavigationController *)navigationController
       didShowViewController:(UIViewController *)viewController
                    animated:(BOOL)animate
{
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)])
        self.interactivePopGestureRecognizer.enabled = YES;
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {

    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)])
        self.interactivePopGestureRecognizer.enabled = YES;
}

- (UIBarButtonItem *)customCommentLeftBarButtonItem
{
    UIBarButtonItem *buttonItem_back = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"popBack"] style:UIBarButtonItemStyleDone target:self action:@selector(popToLastViewController:)];
    [buttonItem_back setTintColor:kAppMainColor];
    _customCommentLeftBarButtonItem = buttonItem_back;
    return _customCommentLeftBarButtonItem;
}

- (void)popToLastViewController:(UIBarButtonItem *)sender
{
    [self popViewControllerAnimated:YES];
}

// 解决在根目录下 界面卡死的 情况
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if ( gestureRecognizer == self.interactivePopGestureRecognizer )
    {
        if ( self.viewControllers.count < 2 || self.visibleViewController == [self.viewControllers objectAtIndex:0] )
        {
            return NO;
        }
    }
    return YES;
}

@end
