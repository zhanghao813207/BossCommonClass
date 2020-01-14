//
//  PlayerViewController.m
//  boss-message-ios
//
//  Created by 高炀辉 on 2020/1/9.
//

#import "PlayerViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>

@interface PlayerViewController ()

@end

@implementation PlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 视频
    // 设置资源路径
    NSURL *url = [NSURL URLWithString:self.url];
    AVPlayer *avPlayer= [AVPlayer playerWithURL:url];
    // player的控制器对象
    AVPlayerViewController *playerViewController = [[AVPlayerViewController alloc] init];
    // 控制器的player播放器
    playerViewController.player = avPlayer;
    // 试图的填充模式
    playerViewController.videoGravity = AVLayerVideoGravityResizeAspect;
    // 是否显示播放控制条
    playerViewController.showsPlaybackControls = YES;
    // 设置显示的Frame
    playerViewController.view.frame = self.view.bounds;
    // 将播放器控制器添加到当前页面控制器中
    [self addChildViewController:playerViewController];
    // view一定要添加，否则将不显示
    [self.view addSubview:playerViewController.view];
    // 播放
    [playerViewController.player play];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
