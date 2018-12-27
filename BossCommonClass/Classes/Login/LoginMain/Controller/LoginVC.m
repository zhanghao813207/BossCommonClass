//
//  LoginVC.m
//  登陆模块
//
//  Created by 贾远潮 on 2017/12/20.
//  Copyright © 2017年 贾远潮. All rights reserved.
//

#import "LoginVC.h"
#import "InputPhoneNumberView.h"
#import "InputCodeView.h"
#import "NNBUtilRequest.h"
#import "NNBAuthRequest.h"
#import "BossBasicDefine.h"

@interface LoginVC ()<InputCodeViewDelegate>

/**
 登陆页背景View
 处理View上移
 */
@property (nonatomic, strong) UIView *BGView;

/**
 appIcon
 */
@property (nonatomic, strong) UIImageView *appLogoImageView;

/**
 验证码页放回按钮
 */
@property (nonatomic, strong) UIBarButtonItem *backBarButtonItem;

/**
 输入手机号View
 */
@property (nonatomic, strong) InputPhoneNumberView *inputPhoneNumberView;

/**
 输入验证码View
 */
@property (nonatomic, strong) InputCodeView *inputCodeView;

@end

@implementation LoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = nil;
    [self.view addSubview:self.BGView];
    
    [self.inputPhoneNumberView isBecomeFirstResponder];
}


/**
 点击放回按钮

 @param sender sender
 */
- (void)backBarButtonItemAction:(UIBarButtonItem *)sender
{
    DLog(@"返回按钮被点击");
    self.inputCodeView.showVoiceCode = NO;
    [self showView:self.inputPhoneNumberView dismissView:self.inputCodeView showBack:NO commplete:^(BOOL finish) {
        DLog(@"333333");
    }];
}


/**
 登陆模块View切换显示

 @param showView 待显示View
 @param dismissView 当前View
 @param show 是否返回按钮
 @param commplete View切换完成回调
 */
- (void)showView:(UIView *)showView dismissView:(UIView *)dismissView showBack:(BOOL)show commplete:(void(^)(BOOL finish))commplete
{
    if (!showView || !dismissView) {
        return;
    }
    
    // 是否显示左侧返回按钮
    if (show) {
        self.navigationItem.leftBarButtonItem = self.backBarButtonItem;
    } else {
        self.navigationItem.leftBarButtonItem = nil;
    }
    
    // 登陆模块View切换键盘一直显示
    if ([showView respondsToSelector:@selector(isBecomeFirstResponder)]) {
        [showView performSelector:@selector(isBecomeFirstResponder) withObject:nil afterDelay:0];
    }
    
    // View切换动画
    dismissView.alpha = 1;
    [UIView animateWithDuration:0.25f animations:^{
        dismissView.alpha = 0;
    } completion:^(BOOL finished) {
        dismissView.hidden = YES;
        showView.hidden = NO;
        showView.alpha = 0;
        [UIView animateWithDuration:0.25 animations:^{
            showView.alpha = 1;
        } completion:^(BOOL finished) {
            if (commplete) {
                commplete(finished);
            }
        }];
    }];
    
}

#pragma mark -- 倒计时的代理

/**
 开始倒计时

 @param inputCodeView 输入验证码View
 */
- (void)inputCodeViewWillStartCount:(InputCodeView *)inputCodeView
{
    inputCodeView.showVoiceCode = YES;
    inputCodeView.inputCodeViewStatus = InputCodeViewStatusBegainCount;
    // 发送验证码请求
    [NNBUtilRequest UtilRequestSendSMSWithPhhoneNumber:self.inputPhoneNumberView.phoneNumber smsType:NNBSendSMSTypeLogin begainSend:nil success:^(BOOL ok, NSString *mockMessage) {
        if (ok) {
            if (kIsAlertPassword) {
                [self.navigationController.view showAnimationStatus:mockMessage completion:nil];
            }
            inputCodeView.inputCodeViewStatus = InputCodeViewStatusCounting;
        }
    } fail:^{
        inputCodeView.inputCodeViewStatus = InputCodeViewStatusNomal;
    }];
}


#pragma mark --lazy

/**
 初始化BGView
 懒加载

 @return 登陆页背景View
 */
-(UIView *)BGView
{
    if (!_BGView) {
        _BGView = [[UIView alloc] initWithFrame:self.view.bounds];
        _BGView.backgroundColor = [UIColor whiteColor];
        [_BGView addSubview:self.appLogoImageView];
        [_BGView addSubview:self.inputPhoneNumberView];
        [_BGView addSubview:self.inputCodeView];
    }
    return _BGView;
}


/**
 显示appIcon
 懒加载

 @return appIcon ImageView
 */
- (UIImageView *)appLogoImageView
{
    if (!_appLogoImageView) {
        // 图片大小 111*88
        _appLogoImageView = [[UIImageView alloc] initWithFrame:CGRectMake((kScreenWidth - 111) / 2.0, 0, 111, 88)];
        _appLogoImageView.image = [UIImage imageNamed:@"appLaunchLogo"];
        
        // 手机显示图标，ipad隐藏图标。
        _appLogoImageView.hidden = !IS_ON_IPHONE;
    }
    return _appLogoImageView;
}


/**
 初始化 输入手机号View
 懒加载

 @return 输入手机号View
 */
- (InputPhoneNumberView *)inputPhoneNumberView
{
    if (!_inputPhoneNumberView) {
        CGFloat y = IS_ON_IPHONE ? CGRectGetMaxY(self.appLogoImageView.frame) : 0;
        _inputPhoneNumberView = [[InputPhoneNumberView alloc] initWithFrame:CGRectMake(0, y, kScreenWidth, kInputPhoneNumberViewHeight)];
        WS(weakSelf);
        [_inputPhoneNumberView setNextStepBlock:^(NSString *phoneNumber, NSString *textFieldText) {
            [weakSelf.navigationController.view showGrayLoadingStatus:@"加载中..."];
            [NNBUtilRequest UtilRequestSendSMSWithPhhoneNumber:phoneNumber smsType:NNBSendSMSTypeLogin begainSend:nil success:^(BOOL ok, NSString *mockMessage) {
                [weakSelf.navigationController.view dismissLoadingStatusViewWithCompletion:nil];
                if (ok) {
                    if (kIsAlertPassword) {
                        [weakSelf.navigationController.view showAnimationStatus:mockMessage completion:nil];
                    }
                    [weakSelf showView:weakSelf.inputCodeView dismissView:weakSelf.inputPhoneNumberView showBack:YES commplete:^(BOOL finish) {
                        weakSelf.inputCodeView.inputCodeViewStatus = InputCodeViewStatusCounting;
                        if (!kIsAlertPassword) {
                            [weakSelf.navigationController.view showSuccessStaus:@"验证码已发"];
                        }
                    }];
                    weakSelf.inputCodeView.phoneNumber = textFieldText;
                }
            } fail:^{
                [weakSelf.navigationController.view dismissLoadingStatusViewWithCompletion:nil];
            }];
        }];
        
    }
    return _inputPhoneNumberView;
}


#pragma mark -- lazy
- (InputCodeView *)inputCodeView
{
    if (!_inputCodeView) {
        // 区分手机和Ipad
        CGFloat y = IS_ON_IPHONE ? CGRectGetMaxY(self.appLogoImageView.frame) : 0;
        _inputCodeView = [[InputCodeView alloc] initWithFrame:CGRectMake(0, y, kScreenWidth, kInputCodeViewHeight)];
        _inputCodeView.alpha = 0;
        _inputCodeView.hidden = YES;
        _inputCodeView.delegate = self;
        
        WS(weakSelf);
        // 设置语音验证码回调
        [_inputCodeView setVoiceCodeBlock:^{
            // 发送语音验证码请求
            [NNBUtilRequest UtilRequestSendVoiceSMSWithPhhoneNumber:weakSelf.inputPhoneNumberView.phoneNumber smsType:NNBSendSMSTypeLogin success:^(BOOL ok, NSString *mockMessage) {
                if (kIsAlertPassword) {
                    [weakSelf.navigationController.view showAnimationStatus:mockMessage completion:nil];
                }
                [weakSelf.navigationController.view showSuccessStaus:@"验证码将通过语音电话010-86396960呼叫到您的手机，请保持电话畅通。"];
            } fail:^{
                
            }];
        }];
        
        // 验证码输入完成回调
        [_inputCodeView setInputCodeEndBlock:^(NSString *phoneNumber, NSString *code) {
            DLog(@"phoneNumber = %@, code = %@",phoneNumber,code);
            // 收起键盘
            [weakSelf.inputCodeView resignTheFirstResponder];
            // View下移动画
            [UIView animateWithDuration:0.25f animations:^{
                weakSelf.BGView.y = 85;
            } completion:^(BOOL finished) {
                // 显示加载对话框
                [weakSelf.navigationController.view showLoadingStatus:@"登录中..."];
                // 登陆请求
                [NNBAuthRequest authRequestLoginWithPhoneNumber:phoneNumber authCode:code success:^(NNBAccount *accountInfo) {
                    // 登陆失败
                    if (!accountInfo) {
                        // 隐藏加载对话框
                        [weakSelf.navigationController.view dismissLoadingStatusViewWithCompletion:^(BOOL finish) {
                            [weakSelf backBarButtonItemAction:nil];
                        }];
                        return;
                    }
                    
                    // 登陆成功
                    // 隐藏对话框
                    [weakSelf.navigationController dismissViewControllerAnimated:YES completion:^{
                        [weakSelf.navigationController.view dismissLoadingStatusViewWithCompletion:nil];
                        if (weakSelf.loginSuccessBlock) {
                            weakSelf.loginSuccessBlock(YES);
                        }
                    }];
                } fail:^(id error) { // 网络请求失败
                    [weakSelf.navigationController.view dismissLoadingStatusViewWithCompletion:^(BOOL finish) {
                        [weakSelf.inputCodeView isBecomeFirstResponder];
                        [UIView animateWithDuration:0.25f animations:^{
                            weakSelf.BGView.y = 0;
                        } completion:^(BOOL finished) {
                            
                        }];
                    }];
                }];
            }];
        }];
    }
    return _inputCodeView;
}


/**
 初始化导航条返回按钮

 @return 返回按钮
 */
- (UIBarButtonItem *)backBarButtonItem
{
    if (!_backBarButtonItem) {
        _backBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"popBack"] style:UIBarButtonItemStyleDone target:self action:@selector(backBarButtonItemAction:)];
        [_backBarButtonItem setTintColor:kHexRGBA(0x000000, 0.8)];
    }
    return _backBarButtonItem;
}

@end
