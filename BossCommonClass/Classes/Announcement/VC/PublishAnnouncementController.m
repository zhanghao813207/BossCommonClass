

//
//  PublishAnnouncementController.m
//  AFNetworking
//
//  Created by admin on 2019/4/17.
//

#import "PublishAnnouncementController.h"
#import "PublishAnnouncementView.h"
#import "JYCMethodDefine.h"
@interface PublishAnnouncementController ()<PublishAnnouncementViewDelegate>
@property(nonatomic, strong)PublishAnnouncementView *publishView;
@end

@implementation PublishAnnouncementController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kHexRGBA(0x000000, 0.5);
    self.navigationController.navigationBarHidden = true;
    [self publishView];
    NSLog(@"%@",self.navigationController);
}
//PublishAnnouncementViewDelegate
- (void)publishSuccess {
    if (self.delegate && [self.delegate respondsToSelector:@selector(publishSuccess)]) {
        [self.delegate publishSuccess];
    }
    [self.navigationController popViewControllerAnimated:false];
}
/**
 创建发布公告界面
 */
- (PublishAnnouncementView *)publishView {
    if (_publishView == nil) {
        _publishView = [[PublishAnnouncementView alloc] initWithFrame:self.view.bounds];
        _publishView.wppId = self.wppId;
        _publishView.proxyId = self.proxyId;
        _publishView.delegate = self;
        [self.view addSubview:_publishView];
        __weak typeof(self)weakself = self;
        _publishView.dismissBlock = ^(PublishAnnouncementView * _Nonnull view) {
            [weakself dismissViewControllerAnimated:true completion:^{
                
            }];
        };
    }
    return _publishView;
}
- (void)dealloc {
    
}
@end
