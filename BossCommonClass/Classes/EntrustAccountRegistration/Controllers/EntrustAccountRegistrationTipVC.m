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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)initViews{
    self.title = @"委托个户注册";
}

#pragma mark - button click envent

- (IBAction)clickEnterFaceRecognition:(id)sender {
    
    // 跳往委托个户注册页
    DXWebViewController *homeVC = [[DXWebViewController alloc] init];
    [homeVC loadURLString:self.url];
    // [homeVC loadURLString:@"http://hatch.bndxqc.com/h5/#/"];
    [self presentViewController:homeVC animated:YES completion:nil];
}

@end
