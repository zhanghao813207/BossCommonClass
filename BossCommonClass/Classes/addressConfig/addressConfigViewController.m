//
//  addressConfigViewController.m
//  BossCommonClass
//
//  Created by 高炀辉 on 2019/9/4.
//

#import "addressConfigViewController.h"
#import "BossConstDataDefine.h"
#import "BossWhiteNavigationController.h"
#import "UIViewController+StoryBoard.h"
#import "BindPhoneVc.h"

@interface addressConfigViewController ()
@property (weak, nonatomic) IBOutlet UILabel *configstatusLabel;

@end

@implementation addressConfigViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)changeConfig:(UIButton *)sender {
    
#ifdef kBossOwner
    
    // 0测试 1质检 2 演示
    if (sender.tag == 0){
        BossBasicURL   = @"https://boss-api-dev.aoaosong.com:9040/1.0/";
        BossBasicURLV2 = @"https://boss-api-dev.aoaosong.com:9040/2.0/";
        ACCESS_KEY     = @"5277d8d0265d5ae93e23da9a640fe354";
        SECRET_KEY     = @"d9ccf222c2a9e1378de3bff603bfde96";
        MessageBasicURL   = @"https://boss-quhuo-api.aoaosong.com:9090/1.0/";
        MessageBasicURLV2 = @"https://boss-quhuo-api.aoaosong.com:9090/2.0/";
    } else if (sender.tag == 1){
        BossBasicURL = @"https://boss-quhuo-api.aoaosong.com:9070/1.0/";
        BossBasicURLV2 = @"https://boss-quhuo-api.aoaosong.com:9070/2.0/";
        ACCESS_KEY = @"e6d14e49b8589e95508e6245d6628337";
        SECRET_KEY = @"a6b0a55291872fa9e2c3707285f297d2";
        
        MessageBasicURL = @"https://boss-quhuo-api.aoaosong.com:9090/1.0/";
        MessageBasicURLV2 = @"https://boss-quhuo-api.aoaosong.com:9090/2.0/";
    } else {
        
         BossBasicURL    = @"https://boss-quhuo-api.aoaosong.com:1082/1.0/";
         BossBasicURLV2  = @"https://boss-quhuo-api.aoaosong.com:1082/2.0/";
         ACCESS_KEY      = @"3f92d896b23d960e529048c2fc2ab762";
         SECRET_KEY      = @"2fd89206dd6edd7b87b8833ba6bed5a9";
        
         MessageBasicURL   = @"https://boss-api-dev.aoaosong.com:1083/2.0/";
         MessageBasicURLV2 = @"https://boss-api-dev.aoaosong.com:1083/2.0/";
    }
    
#elif defined kBossKnight
    
    if (sender.tag == 0){
        // dev
        BossBasicURL   = @"https://boss-api-dev.aoaosong.com:9040/1.0/";
        BossBasicURLV2 = @"https://boss-api-dev.aoaosong.com:9040/2.0/";
        ACCESS_KEY     = @"e2ee2080d71f31b7e5794089ec5ddadc";
        SECRET_KEY     = @"717285b895ddce6a8197e4b9773800c8";
        
        MessageBasicURL   = @"https://boss-quhuo-api.aoaosong.com:9090/1.0/";
        MessageBasicURLV2 = @"https://boss-quhuo-api.aoaosong.com:9090/2.0/";
    } else if (sender.tag == 1){
         BossBasicURL   = @"https://boss-quhuo-api.aoaosong.com:9070/1.0/";
         BossBasicURLV2 = @"https://boss-quhuo-api.aoaosong.com:9070/2.0/";
         ACCESS_KEY     = @"e6d14e49b8589e95508e6245d6628337";
         SECRET_KEY     = @"a6b0a55291872fa9e2c3707285f297d2";
         MessageBasicURL   = @"https://boss-quhuo-api.aoaosong.com:9090/1.0/";
         MessageBasicURLV2 = @"https://boss-quhuo-api.aoaosong.com:9090/2.0/";
    } else {
        
        BossBasicURL    = @"https://boss-quhuo-api.aoaosong.com:1082/1.0/";
        BossBasicURLV2  = @"https://boss-quhuo-api.aoaosong.com:1082/2.0/";
        ACCESS_KEY      = @"500aa2ba0e248edff26c502ac11d8f41";
        SECRET_KEY      = @"f175a2c83bbec7732c6acd0c8b405504";
        
        MessageBasicURL   = @"https://boss-api-dev.aoaosong.com:1083/2.0/";
        MessageBasicURLV2 = @"https://boss-api-dev.aoaosong.com:1083/2.0/";
    }
#endif
    
    UIViewController *vc = [BindPhoneVc storyBoardCreateViewControllerWithBundle:@"BossOwnerLogin" StoryBoardName:@"BossOwnerLogin"];
    BossWhiteNavigationController *nav = [[BossWhiteNavigationController alloc] initWithRootViewController:vc];
    nav.hasLine = true;
    [[UIApplication sharedApplication].keyWindow setRootViewController:nav];
}


@end
