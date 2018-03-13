//
//  LoginVC.m
//  NNB
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
#import "UIView+ShowView.h"

@interface LoginVC ()<InputCodeViewDelegate>

@property (nonatomic, strong) UIView *BGView;

@property (nonatomic, strong) UIImageView *appLogoImageView;

@property (nonatomic, strong) UIBarButtonItem *backBarButtonItem;

@property (nonatomic, strong) InputPhoneNumberView *inputPhoneNumberView;

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

- (void)backBarButtonItemAction:(UIBarButtonItem *)sender
{
    DLog(@"返回按钮被点击");
    self.inputCodeView.showVoiceCode = NO;
    [self showView:self.inputPhoneNumberView dismissView:self.inputCodeView showBack:NO commplete:^(BOOL finish) {
        DLog(@"333333");
    }];
}

- (void)showView:(UIView *)showView dismissView:(UIView *)dismissView showBack:(BOOL)show commplete:(void(^)(BOOL finish))commplete
{
    if (!showView || !dismissView) {
        return;
    }
    if (show) {
        self.navigationItem.leftBarButtonItem = self.backBarButtonItem;
    } else {
        self.navigationItem.leftBarButtonItem = nil;
    }
    if ([showView respondsToSelector:@selector(isBecomeFirstResponder)]) {
        [showView performSelector:@selector(isBecomeFirstResponder) withObject:nil afterDelay:0];
    }
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
- (void)inputCodeViewWillStartCount:(InputCodeView *)inputCodeView
{
    inputCodeView.showVoiceCode = YES;
    inputCodeView.inputCodeViewStatus = InputCodeViewStatusBegainCount;
    [NNBUtilRequest UtilRequestSendSMSWithPhhoneNumber:self.inputPhoneNumberView.phoneNumber smsType:NNBSendSMSTypeLogin success:^(BOOL ok, NSString *mockMessage) {
        if (ok) {
            inputCodeView.inputCodeViewStatus = InputCodeViewStatusCounting;
        }
    } fail:^{
        inputCodeView.inputCodeViewStatus = InputCodeViewStatusNomal;
    }];
}


#pragma mark --lazy

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

- (UIImageView *)appLogoImageView
{
    if (!_appLogoImageView) {
        _appLogoImageView = [[UIImageView alloc] initWithFrame:CGRectMake((kScreenWidth - 111) / 2.0, 0, 111, 88)];
        _appLogoImageView.image = [UIImage imageNamed:@"appLaunchLogo"];
        _appLogoImageView.hidden = !IS_ON_IPHONE;
    }
    return _appLogoImageView;
}

- (InputPhoneNumberView *)inputPhoneNumberView
{
    if (!_inputPhoneNumberView) {
        CGFloat y = IS_ON_IPHONE ? CGRectGetMaxY(self.appLogoImageView.frame) : 0;
        _inputPhoneNumberView = [[InputPhoneNumberView alloc] initWithFrame:CGRectMake(0, y, kScreenWidth, kInputPhoneNumberViewHeight)];
        WS(weakSelf);
        [_inputPhoneNumberView setNextStepBlock:^(NSString *phoneNumber, NSString *textFieldText) {
            [weakSelf.navigationController.view showClearLoadingStatus:@"加载中..."];
            [NNBUtilRequest UtilRequestSendSMSWithPhhoneNumber:phoneNumber smsType:NNBSendSMSTypeLogin success:^(BOOL ok, NSString *mockMessage) {
                [weakSelf.navigationController.view dismissLoadingStatusViewWithCompletion:nil];
                if (ok) {
                    [weakSelf showView:weakSelf.inputCodeView dismissView:weakSelf.inputPhoneNumberView showBack:YES commplete:^(BOOL finish) {
                        weakSelf.inputCodeView.inputCodeViewStatus = InputCodeViewStatusCounting;
                        [weakSelf.navigationController.view showSuccessStaus:@"验证码已发"];
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
        CGFloat y = IS_ON_IPHONE ? CGRectGetMaxY(self.appLogoImageView.frame) : 0;
        _inputCodeView = [[InputCodeView alloc] initWithFrame:CGRectMake(0, y, kScreenWidth, kInputCodeViewHeight)];
        _inputCodeView.alpha = 0;
        _inputCodeView.hidden = YES;
        _inputCodeView.delegate = self;
        WS(weakSelf);
        [_inputCodeView setVoiceCodeBlock:^{
            [NNBUtilRequest UtilRequestSendVoiceSMSWithPhhoneNumber:weakSelf.inputPhoneNumberView.phoneNumber smsType:NNBSendSMSTypeLogin success:^(BOOL ok, NSString *mockMessage) {
                [weakSelf.navigationController.view showSuccessStaus:@"验证码将通过语音电话010-86396960呼叫到您的手机，请保持电话畅通。"];
            } fail:^{
                
            }];
        }];
        [_inputCodeView setInputCodeEndBlock:^(NSString *phoneNumber, NSString *code) {
            DLog(@"phoneNumber = %@, code = %@",phoneNumber,code);
            [weakSelf.inputCodeView resignTheFirstResponder];
            [UIView animateWithDuration:0.25f animations:^{
                weakSelf.BGView.y = 85;
            } completion:^(BOOL finished) {
                [weakSelf.navigationController.view showLoadingStatus:@"登录中..."];
                [NNBAuthRequest authRequestLoginWithPhoneNumber:phoneNumber authCode:code success:^(NNBAccount *accountInfo) {
                    [weakSelf.navigationController dismissViewControllerAnimated:YES completion:^{
                        [weakSelf.navigationController.view dismissLoadingStatusViewWithCompletion:nil];
                        if (weakSelf.loginSuccessBlock) {
                            weakSelf.loginSuccessBlock(YES);
                        }
                    }];
                } fail:^(id error) {
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

- (UIBarButtonItem *)backBarButtonItem
{
    if (!_backBarButtonItem) {
        _backBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"popBack"] style:UIBarButtonItemStyleDone target:self action:@selector(backBarButtonItemAction:)];
        [_backBarButtonItem setTintColor:kHexRGBA(0x000000, 0.8)];
    }
    return _backBarButtonItem;
}

@end
