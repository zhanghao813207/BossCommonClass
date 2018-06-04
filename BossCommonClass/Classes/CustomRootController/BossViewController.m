//
//  BossViewController.m
//  BasicCommonClass
//
//  Created by 贾远潮 on 2018/3/12.
//

#import "BossViewController.h"
#import "UINavigationBar+BackgroundColor.h"
#import "BossBasicDefine.h"
@interface BossViewController ()<UIGestureRecognizerDelegate>

@property (nonatomic, strong) UITapGestureRecognizer *packKeybordTap;

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
