//
//  EntrustAccountRegistrationTipVC.m
//  AFNetworking
//
//  Created by 张浩 on 2019/5/20.
//

#import "EntrustAccountRegistrationTipVC.h"
#import "UIViewController+StoryBoard.h"
#import <XFHProject/XFHProject.h>

@interface EntrustAccountRegistrationTipVC ()

@end

@implementation EntrustAccountRegistrationTipVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initViews];
}

- (void)initViews{
    self.title = @"委托个户注册";
    self.view.backgroundColor = UIColor.whiteColor;
}

#pragma mark - button click envent

- (IBAction)clickEnterFaceRecognition:(id)sender {
    
    // 跳往委托个户注册页
    DXWebViewController *homeVC = [[DXWebViewController alloc] init];
    [homeVC loadURLString:self.url];
    // [homeVC loadURLString:@"http://hatch.bndxqc.com/h5/#/"];
    [self presentViewController:homeVC animated:YES completion:^{
        [self.navigationController popViewControllerAnimated:false];
    }];
}

@end
