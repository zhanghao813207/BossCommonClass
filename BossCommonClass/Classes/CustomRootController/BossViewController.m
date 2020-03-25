//
//  BossViewController.m
//  BasicCommonClass
//
//  Created by 贾远潮 on 2018/3/12.
//

#import "BossViewController.h"
#import "UINavigationBar+BackgroundColor.h"
#import "BossBasicDefine.h"
#import "BossWhiteNavigationController.h"

@interface BossViewController ()<UIGestureRecognizerDelegate>

@property (nonatomic, strong) UITapGestureRecognizer *packKeybordTap;

@end

@implementation BossViewController

- (void)viewWillDisappear:(BOOL)animated
{
    //取消view的编辑状态
    [self.view endEditing:YES];
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.titleTextAttributes = @{NSFontAttributeName:BossBlodFont(18),NSForegroundColorAttributeName:[UIColor colorNamed:@"boss_000000-80_FFFFFF-80"]};
    
    UIColor *navcolor = [UIColor colorNamed:@"navcolor_FFFFFF_FFFFFF-10"];
    
    [self.navigationController.navigationBar lt_setBackgroundColor:navcolor showdowColor:navcolor];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorNamed:@"bgcolor_FFFFFF_000000"];
    self.packUpKeybordEnable = YES;

    self.navigationItem.leftBarButtonItem = [self customCommentLeftBarButtonItem];

}
    
- (UIBarButtonItem *)customCommentLeftBarButtonItem
{
    UIBarButtonItem *buttonItem_back = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"popBack"] style:UIBarButtonItemStyleDone target:self action:@selector(popToLastViewController:)];
#ifdef kBossKnight
    [buttonItem_back setTintColor:kAppMainColor];
#elif defined kBossManager
    [buttonItem_back setTintColor:kHexRGB(0x06041D)];
#else
    [buttonItem_back setTintColor:[UIColor colorNamed:@"navbackicon_06041D_8E8C96"]];
#endif
    _customCommentLeftBarButtonItem = buttonItem_back;
    return _customCommentLeftBarButtonItem;
}

- (void)popToLastViewController:(UIBarButtonItem *)sender
{
    //有的页面是消息推送直接弹出来的，所以点返回的时候要dismiss掉
    [self dismissViewControllerAnimated:true completion:nil];
    [self.navigationController popViewControllerAnimated:YES];
}
- (UITapGestureRecognizer *)packKeybordTap
{
    if (!_packKeybordTap) {
        _packKeybordTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(endEditing:)];
        _packKeybordTap.delegate = self;
    }
    return _packKeybordTap;
}

- (void)setPackUpKeybordEnable:(BOOL)packUpKeybordEnable
{
    _packUpKeybordEnable = packUpKeybordEnable;
    if (packUpKeybordEnable) {
        [self.view addGestureRecognizer:self.packKeybordTap];
    } else {
        if (_packKeybordTap) {
            [self.view removeGestureRecognizer:self.packKeybordTap];
        }
    }
}
//手势
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleDefault;
}

#pragma mark - tap gestureRecognizer action method
- (void)endEditing:(UITapGestureRecognizer *)tap {
    
    [self.view endEditing:YES];
}


@end
