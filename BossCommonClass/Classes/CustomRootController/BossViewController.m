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
//    [self.view endEditing:YES];
    
}
    
- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection{
    [super traitCollectionDidChange:previousTraitCollection];
    if (@available(iOS 13.0, *)) {
        if (![self isKindOfClass:NSClassFromString(@"WalletPageVc")]){
            UIColor *navcolor = [UIColor colorNamed:@"navcolor_FFFFFF_1A1A1A"];
            [self.navigationController.navigationBar lt_setBackgroundColor:navcolor showdowColor:navcolor];
        }
       
    }
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.titleTextAttributes = @{NSFontAttributeName:BossBlodFont(18),NSForegroundColorAttributeName:[UIColor colorNamed:@"boss_000000-80_FFFFFF-80"]};
    UIColor *navcolor = [UIColor colorNamed:@"navcolor_FFFFFF_1A1A1A"];
    [self.navigationController.navigationBar lt_setBackgroundColor:navcolor showdowColor:navcolor];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    #ifdef kBossOwner
        self.view.backgroundColor = [UIColor colorNamed:@"bgcolor_FFFFFF_000000"];
    #else
         self.view.backgroundColor = [UIColor colorNamed:@"bgcolor_F5F5F5_000000"];
    #endif
    self.packUpKeybordEnable = YES;

    self.navigationItem.leftBarButtonItem = [self customCommentLeftBarButtonItem];

}
    
- (UIBarButtonItem *)customCommentLeftBarButtonItem
{
    UIBarButtonItem *buttonItem_back = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"popBack"] style:UIBarButtonItemStyleDone target:self action:@selector(popToLastViewController:)];
     [buttonItem_back setTintColor:[UIColor colorNamed:@"navbackicon_06041D_8E8C96"]];

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
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {
        return NO;
    }
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UICollectionViewCellContentView"]) {
        return NO;
    }
    return YES;
}
#pragma mark - tap gestureRecognizer action method
- (void)endEditing:(UITapGestureRecognizer *)tap {
    
    [self.view endEditing:YES];
}


@end
