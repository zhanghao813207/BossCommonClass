//
//  LoginVC.m
//  登陆模块
//
//  Created by 贾远潮 on 2017/12/20.
//
#import "BossWhiteNavigationController.h"
#import "LoginVC.h"
#import "InputMerchantCodeView.h"
#import "InputPhoneNumberView.h"
#import "InputCodeViewOC.h"
#import "SaasRequest.h"
#import "NNBUtilRequest.h"
#import "NNBAuthRequest.h"
#import "BossBasicDefine.h"
#import "NNBRequestManager.h"
#import "AgreementVc.h"
#import "ProtocollAlertViewCommon.h"
#import "Masonry.h"
#import "UINavigationBar+BackgroundColor.h"
@interface LoginVC ()<InputCodeViewDelegate,UIGestureRecognizerDelegate>

/**
 用户协议提示框
 */
@property (nonatomic,strong)ProtocollAlertViewCommon *protocolAlertView;

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
 输入商户号View
 */
@property (nonatomic, strong) InputMerchantCodeView *inputMerchantCodeView;

/**
 输入手机号View
 */
@property (nonatomic, strong) InputPhoneNumberView *inputPhoneNumberView;

/**
 输入验证码View
 */
@property (nonatomic, strong) InputCodeViewOC *inputCodeView;

@property (nonatomic, assign) OperatingView currentOperatingView;

@property (nonatomic, strong) SaasModel *saasModel;

@property (nonatomic, readonly) NSString *defaultPhoneNumber;

/**
 服务器获取当前是否为第一次登录
 */
@property BOOL isFirstLogin;

/**
 验证码失败 是否点击过同意协议
 */
@property BOOL isClickAgree;

@end

@implementation LoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor colorNamed:@"boss_FFFFFF_000000"];
    self.navigationItem.leftBarButtonItem = nil;
    [self.view addSubview:self.BGView];
    
    self.saasModel = kCache.currentSaasModel;
    if(kCache.currentSaasModel){
        [self.inputPhoneNumberView isBecomeFirstResponder];
        [self showInputPhoneNumberView:kCache.currentSaasModel phoneNumber:self.defaultPhoneNumber];
    }else{
        [self.inputMerchantCodeView isBecomeFirstResponder];
        [self showInputMerchantCodeView:@""];
    }
    self.navigationController.navigationBar.backgroundColor = UIColor.redColor;
    
    
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (self.protocolAlertView.alpha == 0){
        self.protocolAlertView.alpha = 1;
    }
    UIColor *navcolor = [UIColor colorNamed:@"bgcolor_FFFFFF_000000"];
    [self.navigationController.navigationBar lt_setBackgroundColor:navcolor showdowColor:navcolor];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    return NO;
}


- (void)showInputMerchantCodeView:(NSString *)merchantCode
{
    _currentOperatingView = MerchantCodeView;
    kLocalConfig = YES;
    // NNBRequestManager.shareNNBRequestManager.saasModel = nil;
    [kCache initNetConfig:nil];
    self.inputMerchantCodeView.merchantCode = merchantCode;
    [self showView:self.inputMerchantCodeView showBack:kCache.showBackMerchantCode commplete:nil];
    self.inputPhoneNumberView.hidden = YES;
    self.inputCodeView.hidden = YES;
}

- (void)showInputPhoneNumberView:(SaasModel *)saasModel phoneNumber:(NSString *)phoneNumber
{
    _currentOperatingView = PhoneNumberView;
    kLocalConfig = NO;
    // NNBRequestManager.shareNNBRequestManager.saasModel = saasModel;
    [kCache initNetConfig:saasModel];
    self.inputPhoneNumberView.saasModel = saasModel;
    
    self.inputPhoneNumberView.phoneNumber = phoneNumber;
    
    [self showView:self.inputPhoneNumberView showBack:YES commplete:nil];
    self.inputMerchantCodeView.hidden = YES;
    self.inputCodeView.hidden = YES;
}

- (void)showInputCodeView:(NSString *)phoneNumber
{
    _currentOperatingView = PhoneCodeView;
    self.inputCodeView.phoneNumber = phoneNumber;
    [self showView:self.inputCodeView showBack:YES commplete:nil];
    self.inputMerchantCodeView.hidden = YES;
    self.inputPhoneNumberView.hidden = YES;
}

/**
 点击放回按钮
 
 @param sender sender
 */
- (void)backBarButtonItemAction:(UIBarButtonItem *)sender
{
    DLog(@"返回按钮被点击");
    switch (self.currentOperatingView) {
        case MerchantCodeView:
            //            NNBRequestManager.shareNNBRequestManager.saasModel = kCache.currentSaasModel;
            [kCache initNetConfig:kCache.currentSaasModel];
            [self.navigationController dismissViewControllerAnimated:YES completion:^{
                kLocalConfig = NO;
                kCache.showBackMerchantCode = NO;
            }];
            break;
        case PhoneNumberView:
            [self showInputMerchantCodeView:self.inputPhoneNumberView.saasModel.merchant_info.merchant_code];
            break;
        case PhoneCodeView:
            self.inputCodeView.showVoiceCode = NO;
            [self showInputPhoneNumberView:self.inputPhoneNumberView.saasModel phoneNumber:self.inputCodeView.phoneNumber];
            break;
        default:
            break;
    }
}


/**
 登陆模块View切换显示
 
 @param showView 待显示View
 @param show 是否返回按钮
 @param commplete View切换完成回调
 */
- (void)showView:(UIView *)showView showBack:(BOOL)show commplete:(void(^)(BOOL finish))commplete
{
    if (!showView) {
        return;
    }
    NSLog(@"%@,%@", NSStringFromClass([self class]), NSStringFromClass([self superclass]));
    // 是否显示左侧返回按钮
    self.navigationItem.leftBarButtonItems = show ? @[self.backBarButtonItem] : @[];
    self.navigationItem.leftItemsSupplementBackButton = NO;
    // 登陆模块View切换键盘一直显示
    if ([showView respondsToSelector:@selector(isBecomeFirstResponder)]) {
        [showView performSelector:@selector(isBecomeFirstResponder) withObject:nil afterDelay:0];
    }
    
    showView.hidden = NO;
}

#pragma mark -- 倒计时的代理

/**
 开始倒计时
 
 @param inputCodeView 输入验证码View
 */
- (void)inputCodeViewWillStartCount:(InputCodeViewOC *)inputCodeView
{
    inputCodeView.showVoiceCode = YES;
    inputCodeView.inputCodeViewStatus = InputCodeViewStatusBegainCount;
    // 发送验证码请求
    [NNBUtilRequest UtilRequestSendSMSWithPhhoneNumber:self.inputPhoneNumberView.phoneNumber smsType:NNBSendSMSTypeLogin begainSend:nil success:^(BOOL ok, NSString *mockMessage,BOOL is_first_login) {
        if (ok) {
            if (kIsAlertPassword) {
                [self.navigationController.view showAnimationStatus:mockMessage completion:nil];
            }
            inputCodeView.inputCodeViewStatus = InputCodeViewStatusCounting;
        }
    } fail:^(id  _Nonnull error){
        inputCodeView.inputCodeViewStatus = InputCodeViewStatusNomal;
    }];
}


#pragma mark - 网络请求
/// 请求商户号
- (void)requestMerchantWithMerchantCode:(NSString *)merchantCode {
    WS(weakSelf);
    [self.navigationController.view showGrayLoadingStatus:@"加载中..."];
    [SaasRequest getSaasResult:merchantCode success:^(SaasModel * _Nonnull saasModel) {
        [weakSelf.navigationController.view dismissLoadingStatusViewWithCompletion:nil];
        weakSelf.saasModel = saasModel;
        NSString *phoneNumber = @"";
        if(kCache.currentSaasModel){
            if ([saasModel._id isEqualToString:kCache.currentSaasModel._id]) {
                phoneNumber = weakSelf.defaultPhoneNumber;
            }
        }
        [weakSelf showInputPhoneNumberView:saasModel phoneNumber:phoneNumber];
    } fail:^{
        [weakSelf.navigationController.view dismissLoadingStatusViewWithCompletion:nil];
    }];
}

/// 登录请求
- (void)requestLoginWithCode:(NSString *)code
                 phoneNumber:(NSString *)phoneNumber {
    // 显示加载对话框
    WS(weakSelf);
    [self.navigationController.view showLoadingStatus:@"登录中..."];
    [NNBAuthRequest authRequestLoginWithPhoneNumber:self.saasModel phoneNumber:phoneNumber authCode:code success:^(id accountInfo) {
        NSLog(@"%@", accountInfo);
        //如果是账号管理页面跳转过来的就直接退到我的页面。
        [weakSelf.lastNavigationController popToRootViewControllerAnimated:NO];
        weakSelf.currentTabbarController.selectedIndex = 0;
        [weakSelf.navigationController dismissViewControllerAnimated:YES completion:^{
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
        _BGView.backgroundColor = [UIColor colorNamed:@"boss_FFFFFF_000000"];
        [_BGView addSubview:self.appLogoImageView];
        [_BGView addSubview:self.inputMerchantCodeView];
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
        //        _appLogoImageView.contentMode = UIViewContentModeScaleAspectFit;
        // 手机显示图标，ipad隐藏图标。
        _appLogoImageView.hidden = !IS_ON_IPHONE;
    }
    return _appLogoImageView;
}

/// 输入商户号view
- (InputMerchantCodeView *) inputMerchantCodeView
{
    if(!_inputMerchantCodeView){
        CGFloat y = IS_ON_IPHONE ? CGRectGetMaxY(self.appLogoImageView.frame) : 0;
        _inputMerchantCodeView = [[InputMerchantCodeView alloc] initWithFrame:CGRectMake(0, y, kScreenWidth, kInputMerchantCodeViewHeight)];
        
        // _inputMerchantCodeView.alpha = 0;
        _inputMerchantCodeView.hidden = YES;
        
        WS(weakSelf);
        [_inputMerchantCodeView setNextStepBlock:^(NSString * _Nonnull merchantCode) {
            [weakSelf requestMerchantWithMerchantCode:merchantCode];
        }];
    }
    
    return _inputMerchantCodeView;
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
        // _inputPhoneNumberView.alpha = 0;
        _inputPhoneNumberView.hidden = YES;
        
        WS(weakSelf);
        [_inputPhoneNumberView setAgreementBlock:^{
            [weakSelf agreementClicked:@"用户服务协议"];
            //            AgreementVc *vc = [[AgreementVc alloc] init];
            //            [weakSelf.navigationController pushViewController:vc animated:true];
        }];
        
        [_inputPhoneNumberView setPrivacyBlock:^{
            [weakSelf agreementClicked:@"隐私协议"];
        }];
        
        [_inputPhoneNumberView setNextStepBlock:^(NSString *phoneNumber, NSString *textFieldText) {
            [weakSelf.navigationController.view showGrayLoadingStatus:@"加载中..."];
            [NNBUtilRequest UtilRequestSendSMSWithPhhoneNumber:phoneNumber smsType:NNBSendSMSTypeLogin begainSend:nil success:^(BOOL ok, NSString *mockMessage,BOOL is_first_login) {
                
                [weakSelf.navigationController.view dismissLoadingStatusViewWithCompletion:nil];
                //获取是否为第一次登录
                weakSelf.isFirstLogin = is_first_login;
                if (ok) {
                    if (kIsAlertPassword) {
                        [weakSelf.navigationController.view showAnimationStatus:mockMessage completion:nil];
                    }
                    
                    weakSelf.inputCodeView.inputCodeViewStatus = InputCodeViewStatusCounting;
                    if (!kIsAlertPassword) {
                        [weakSelf.navigationController.view showSuccessStaus:@"验证码已发"];
                    }
                    [weakSelf showInputCodeView:phoneNumber];
                    
                }
                
            } fail:^(id  _Nonnull error){
                [weakSelf.navigationController.view dismissLoadingStatusViewWithCompletion:nil];
                [weakSelf showAccountDisableError:error];
            }];
        }];
        
    }
    return _inputPhoneNumberView;
}


-(void)showAccountDisableError:(id)error{
    NSString *errorMsg = @"";
    if ([error isKindOfClass:[NSDictionary class]]) {
        NSDictionary *dict = error;
        errorMsg = dict[@"zh_message"]?:@"服务器未响应，请稍后重试";
    }else {
        errorMsg = @"服务器未响应，请稍后重试";
    }
    if( [errorMsg containsString:@"service@cityio.cn"] ){
        UIAlertController  *alertC = [UIAlertController alertControllerWithTitle:@"温馨提示" message:errorMsg preferredStyle:(UIAlertControllerStyleAlert)];
        UIAlertAction *alertA = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self.view endEditing:NO];
        }];
        [alertC addAction:alertA];
        [self presentViewController:alertC animated:false completion:nil];
    }
}

/// 第一次登陆的用户协议
- (ProtocollAlertViewCommon *)protocolAlertView
{
    if(!_protocolAlertView)
    {
        _protocolAlertView = [[ProtocollAlertViewCommon alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    }
    return _protocolAlertView;
}

/// 验证码输入view
- (InputCodeViewOC *)inputCodeView
{
    if (!_inputCodeView) {
        // 区分手机和Ipad
        CGFloat y = IS_ON_IPHONE ? CGRectGetMaxY(self.appLogoImageView.frame) : 0;
        _inputCodeView = [[InputCodeViewOC alloc] initWithFrame:CGRectMake(0, y, kScreenWidth, kInputCodeViewHeight)];
        // _inputCodeView.alpha = 0;
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
                //如果是第一次登录 的 并且没有点击过同意协议的
                if((self.isFirstLogin && (!weakSelf.isClickAgree))) {
                    UIWindow *window = [UIApplication sharedApplication].keyWindow;
                    [window addSubview:weakSelf.protocolAlertView];
                    weakSelf.protocolAlertView.alpha = 0;
                    [UIView animateWithDuration:0.25f animations:^{
                        
                    } completion:^(BOOL finished) {
                        weakSelf.protocolAlertView.alpha = 1;
                    }];
                    
                    [weakSelf.protocolAlertView mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.top.width.equalTo(window);
                        make.bottom.mas_equalTo(window.mas_safeAreaLayoutGuideBottom);
                    }];
                    
                    weakSelf.protocolAlertView.softBlock = ^{
                        [weakSelf agreementClicked:@"用户服务协议"];
                        weakSelf.protocolAlertView.alpha = 0;
                    };
                    weakSelf.protocolAlertView.privacyBlock = ^{
                        [weakSelf agreementClicked:@"隐私协议"];
                        weakSelf.protocolAlertView.alpha = 0;
                    };
                    /// 点击了同意按钮
                    weakSelf.protocolAlertView.agreeBlock = ^{
                        // 登录
                        weakSelf.isClickAgree = true;
                        [weakSelf requestLoginWithCode:code phoneNumber:phoneNumber];
                    };
                } else {
                    // 登录
                    [weakSelf requestLoginWithCode:code phoneNumber:phoneNumber];
                }
            }];
        }];
    }
    return _inputCodeView;
}


- (void)removeNavigationLoginVC{
    
    NSMutableArray<UIViewController *> *tmpArr = [NSMutableArray array];
    for (UIViewController *vc in self.parentViewController.navigationController.viewControllers) {
        [tmpArr addObject:vc];
    }
    for (UIViewController *vc in self.parentViewController.navigationController.viewControllers) {
        if ([vc isKindOfClass:[BossWhiteNavigationController class]]) {
            [tmpArr removeObject:vc];
        }
    }
    self.parentViewController.navigationController.viewControllers = tmpArr;
}

/**
 初始化导航条返回按钮
 
 @return 返回按钮
 */
- (UIBarButtonItem *)backBarButtonItem
{
    if (!_backBarButtonItem) {
        _backBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"popBack"] style:UIBarButtonItemStyleDone target:self action:@selector(backBarButtonItemAction:)];
        
        [_backBarButtonItem setTintColor:[UIColor colorNamed:@"navbackicon_06041D_8E8C96"]];
    }
    return _backBarButtonItem;
}

- (NSString *)defaultPhoneNumber
{
    return self.addAccount ? @"" : kCache.lastLoginPhone;
}


- (void)agreementClicked:(NSString *)type {
    NSString *url;
    NSString *title;
    if ([type isEqualToString:@"用户服务协议"]) {
        title = @"用户服务协议";
        url = [NSString stringWithFormat:@"%@static/%@.html", [self getHost], @"agreement-home"];
    } else {
        title = @"隐私政策";
        url = [NSString stringWithFormat:@"%@static/%@.html", [self getHost], @"privacy-home"];
    }
    AgreementVc *vc = [[AgreementVc alloc] init];
    vc.url = url;
    vc.title = title;
    [self.navigationController pushViewController:vc animated:true];
}

/**
 获取域名
 
 @return 域名
 */
- (NSString *)getHost {
#ifdef DEBUG
    return @"https://boss-dev.aoaosong.com/";
#else
    return @"https://boss.aoaosong.com/";
#endif
}

@end
