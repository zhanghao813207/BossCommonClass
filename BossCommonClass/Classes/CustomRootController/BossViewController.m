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
@property (nonatomic, strong) UIBarButtonItem *customCommentLeftBarButtonItem;
@end

@implementation BossViewController

- (void)viewWillDisappear:(BOOL)animated
{
    //取消view的编辑状态
    [self.view endEditing:YES];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = kBossBGColor;
    self.packUpKeybordEnable = YES;

    self.navigationItem.leftBarButtonItem = [self customCommentLeftBarButtonItem];

}
    
- (UIBarButtonItem *)customCommentLeftBarButtonItem{
    UIBarButtonItem *buttonItem_back = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"popBack"] style:UIBarButtonItemStyleDone target:self action:@selector(popToLastViewController:)];
#ifdef kBossKnight
    [buttonItem_back setTintColor:kAppMainColor];
#elif defined kBossManager
    [buttonItem_back setTintColor:kHexRGB(0x06041D)];
#else
    [buttonItem_back setTintColor:kHexRGB(0x06041D)];
#endif
    _customCommentLeftBarButtonItem = buttonItem_back;
    return _customCommentLeftBarButtonItem;
}
- (void)popToLastViewController:(UIBarButtonItem *)sender
{
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

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

#pragma mark - tap gestureRecognizer action method
- (void)endEditing:(UITapGestureRecognizer *)tap {
    
    [self.view endEditing:YES];
}


@end
