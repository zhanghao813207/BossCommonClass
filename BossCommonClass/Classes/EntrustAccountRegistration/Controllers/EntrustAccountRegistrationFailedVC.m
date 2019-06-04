//
//  EntrustAccountRegistrationFailedVC.m
//  BossCommonClass
//
//  Created by 张浩 on 2019/5/23.
//

#import "EntrustAccountRegistrationFailedVC.h"
#import "UIViewController+StoryBoard.h"
#import <XFHProject/XFHProject.h>

@interface EntrustAccountRegistrationFailedVC ()

@property (weak, nonatomic) IBOutlet UILabel *failedResonLabel;

@end

@implementation EntrustAccountRegistrationFailedVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initViews];
}

- (void)initViews{
    self.title = @"委托个户注册";
    self.view.backgroundColor = UIColor.whiteColor;
    self.failedResonLabel.text = self.reason;
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
