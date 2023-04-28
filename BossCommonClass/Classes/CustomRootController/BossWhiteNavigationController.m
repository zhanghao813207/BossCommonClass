//
//  BossWhiteNavigationController.m
//  BasicCommonClass
//
//  Created by 贾远潮 on 2018/3/12.
//

#import "BossWhiteNavigationController.h"
#import "UINavigationBar+BackgroundColor.h"
#import "BossBasicDefine.h"

@interface BossWhiteNavigationController () <UIGestureRecognizerDelegate>

//@property (nonatomic, strong) UIBarButtonItem *customCommentLeftBarButtonItem;

@end

@implementation BossWhiteNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.view.backgroundColor = [UIColor whiteColor];
    //判断是否支持右滑手势
	self.interactivePopGestureRecognizer.delegate = self;
    #if kBossKnight
        //默认显示
     self.hasLine = true;
    #else
      //设置navigationBar背景色
     //默认不显示
     self.hasLine = false;
    #endif
    self.navigationBar.translucent = NO;
}

- (void)setHasLine:(BOOL)hasLine
{
    
    if (hasLine) {
        [self.navigationBar lt_setBackgroundColor:[UIColor colorNamed:@"bgcolor_FFFFFF_000000"] showdowColor:[UIColor colorNamed:@"bgcolor_F5F5F5_000000"]];
    } else {
        [self.navigationBar lt_setBackgroundColor:[UIColor colorNamed:@"bgcolor_FFFFFF_000000"] showdowColor:[UIColor colorNamed:@"bgcolor_FFFFFF_000000"]];
    }
    _hasLine = hasLine;
}

//push的时候将手势禁用

//- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
//{
//    [super pushViewController:viewController animated:animated];
//    if (viewController.navigationItem.leftBarButtonItem == nil && [self.viewControllers count] > 1)
//    {
//        viewController.navigationItem.leftBarButtonItem = self.customCommentLeftBarButtonItem;
//    }
//    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]){
//        self.interactivePopGestureRecognizer.enabled = NO;
//    }
//}




//- (UIBarButtonItem *)customCommentLeftBarButtonItem
//{
//    UIBarButtonItem *buttonItem_back = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"popBack"] style:UIBarButtonItemStyleDone target:self action:@selector(popToLastViewController:)];
//#ifdef kBossKnight
//    [buttonItem_back setTintColor:kAppMainColor];
//#elif defined kBossManager
//    [buttonItem_back setTintColor:kHexRGB(0x06041D)];
//#else
//    [buttonItem_back setTintColor:kHexRGB(0x06041D)];
//#endif
//    _customCommentLeftBarButtonItem = buttonItem_back;
//    return _customCommentLeftBarButtonItem;
//}

- (void)popToLastViewController:(UIBarButtonItem *)sender
{
    [self popViewControllerAnimated:YES];
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    return YES;
}

@end
