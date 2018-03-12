//
//  SobotManager.m
//  NNBarKnight
//
//  Created by 贾远潮 on 2017/10/10.
//  Copyright © 2017年 贾远潮. All rights reserved.
//

#import "SobotManager.h"
#import <SobotKit/SobotKit.h>
#import "NNBBasicDefine.h"

@interface SobotManager()

@property (nonatomic, strong) ZCLibInitInfo *libInitInfo;

@property (nonatomic, strong) ZCKitInfo *UIInfo;

@end

@implementation SobotManager

+ (SobotManager *)shareSobotManager
{
    static SobotManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[SobotManager alloc] init];
    });
    return manager;
}

- (void)startChatWithViewController:(UIViewController *)viewController
{
    [self customerUI:self.UIInfo];
    WS(weakSelf);
    __weak __typeof__(viewController) weakVC = viewController;
    [ZCSobot startZCChatView:_UIInfo with:viewController
                   pageBlock:^(ZCUIChatController *object, ZCPageBlockType type) {
                       //点击返回
                       if(type==ZCPageBlockGoBack){
                           DLog(@"点击了关闭按钮");
                       }
                       
                       //页面UI初始化完成，可以获取UIView，自定义UI
                       if(type==ZCPageBlockLoadFinish){
                           [weakSelf customerUI:_UIInfo];
                       }
                   } messageLinkClick:nil];
}

- (void)customerUI:(ZCKitInfo *)kitInfo{
    
    /**
     * 自定义信息
     */
    
    //顶部导航条标题文字 评价标题文字 系统相册标题文字 评价客服（立即结束 取消）按钮文字
    kitInfo.titleFont = NNBFont(18.f);
    
    //返回按钮 输入框文字 评价客服是否有以下情况 label 文字 提价评价按钮
    kitInfo.listTitleFont = NNBFont(16.f);
    
    //没有网络提醒的button 没有更多记录label的文字 语音输入的按钮文字 评价不满意（4个button）文字
    
    //占位图片的lablel文字 语音输入时间label文字 语音tipLabel的文字 voiceButton标题文字
    kitInfo.listDetailFont = NNBFont(14.f);
    
    //消息提醒 （转人工、客服接待等）
    kitInfo.listTimeFont = NNBFont(14.f);
    
    //聊天气泡中的文字
    kitInfo.chatFont = NNBFont(16.f);
    
    //聊天的背景颜色
    kitInfo.backgroundColor = kHexRGB(0xeaeff7);
    
    //导航、客服气泡、线条的颜色
    kitInfo.customBannerColor = [UIColor whiteColor];
    
    //左边气泡的颜色
    kitInfo.leftChatColor = [UIColor whiteColor];
    
    //右边气泡的颜色
    kitInfo.rightChatColor = kHexRGB(0x29ab5b);
    
    //底部bottom的背景颜色
    kitInfo.backgroundBottomColor = [UIColor whiteColor];
    
    //底部bottom的输入框线条背景颜色
    kitInfo.bottomLineColor = [UIColor grayColor];
    
    //提示气泡的背景颜色
    kitInfo.BgTipAirBubblesColor = kHexRGB(0x29ab5b);
    
    //顶部文字的颜色
    kitInfo.topViewTextColor = kHexRGBA(0x000000, 0.6);
    
    //提示气泡文字颜色
    kitInfo.tipLayerTextColor = kHexRGBA(0x000000, 0.6);
    
    //左边气泡文字的颜色
    kitInfo.leftChatTextColor = kHexRGBA(0x000000, 0.8);
    
    //右边气泡文字的颜色[注意：语音动画图片，需要单独替换]
    kitInfo.rightChatTextColor = kHexRGBA(0x000000, 0.8);
    
    //时间文字的颜色
    kitInfo.timeTextColor = kHexRGBA(0x000000, 0.6);
    
    //客服昵称颜色
    kitInfo.serviceNameTextColor = kHexRGB(0x29ab5b);
}

#pragma mark -- lazy property
- (ZCLibInitInfo *)libInitInfo
{
    if (!_libInitInfo) {
        _libInitInfo = [[ZCLibInitInfo alloc] init];
        
        _libInitInfo.enterpriseId = SOBOT_KEY;
        
        _libInitInfo.email = @"";
    }
    //用户id，用于标识用户，建议填写 每次都设置  避免更换用户登录的时候  信息不能及时同步
    
    _libInitInfo.userId = [NSString stringWithFormat:@"%ld", [NNBAccount defaultAccount].account_id];
    
    _libInitInfo.phone = [NSString stringWithFormat:@"%@", [NNBAccount defaultAccount].mobile];;
    
    _libInitInfo.nickName = [NSString stringWithFormat:@"%@", [NNBAccount defaultAccount].name];
    
    return _libInitInfo;
}

- (ZCKitInfo *)UIInfo
{
    if (!_UIInfo) {
        _UIInfo = [[ZCKitInfo alloc] init];
    }
    _UIInfo.info = self.libInitInfo;
    return _UIInfo;
}


@end
