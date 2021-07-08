//
//  InputPhoneNumberView.m
//  输入手机号View
//
//  Created by 贾远潮 on 2017/12/20.
//

#import "InputPhoneNumberView.h"
#import "BossBasicDefine.h"
#import "AgreementVc.h"
#import "Masonry.h"

/**
 输入手机号View的高度
 */
CGFloat const kInputPhoneNumberViewHeight = 263;

@interface InputPhoneNumberView()<UITextFieldDelegate>

/**
 商户号
 */
@property (nonatomic, strong) UILabel *merchantCodeLabel;

/**
 商户名称
 */
@property (nonatomic, strong) UILabel *merchantNameLabel;

/**
 协议Label
 */
@property (nonatomic, strong) UIButton *agreementLabel;

@property (nonatomic, strong) UIButton *privacyBtn;


@property (nonatomic, strong) UITextField *phoneTextField;

@property (nonatomic, strong) UIView *line;

@property (nonatomic, strong) UILabel *errorNoticeLabel;

@property (nonatomic, strong) NNBButton *nextStepButton;

@end

@implementation InputPhoneNumberView

@synthesize phoneNumber = _phoneNumber;

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.merchantCodeLabel];
        [self addSubview:self.merchantNameLabel];
        [self addSubview:self.phoneTextField];
        [self addSubview:self.line];
        [self addSubview:self.errorNoticeLabel];
        [self addSubview:self.nextStepButton];
        [self addSubview:self.agreementLabel];
        [self addSubview:self.privacyBtn];
        [self.agreementLabel sizeToFit];
//        self.nextStepButton.frame.origin.y - 30
        [self.agreementLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.nextStepButton.mas_top).offset(-30);
            make.left.equalTo(self.mas_left).offset(20);
            make.height.mas_equalTo(13);
        }];
        [self.privacyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.agreementLabel.mas_right).offset(0);
            make.top.equalTo(self.agreementLabel);
            make.width.mas_equalTo(100);
            make.height.mas_equalTo(13);
        }];
    }
    

    return self;
}

- (void)nextStepButtonAction:(UIButton *)sender
{
    DLog(@"%@",APPCODE);
    DLog(@"下一步");
    NSString *phone = [self.phoneTextField.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (phone.length < 11) {
        self.errorNoticeLabel.hidden = NO;
        return;
    }
    BOOL isPhone = [JYCSimpleToolClass isPhoneStringWithString:phone];
#ifdef DEBUG
    if ([[phone substringWithRange:NSMakeRange(0, 1)] isEqualToString:@"1"]) {
        isPhone = YES;
    }
#endif
    if (!isPhone) {
        self.errorNoticeLabel.hidden = NO;
        return;
    }
    self.errorNoticeLabel.hidden = YES;
    if (self.nextStepBlock) {
        self.nextStepBlock(phone,self.phoneTextField.text);
    }

}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (string.length == 1 || [string isEqualToString:@""]) {
        NSString *phoneNumber = textField.text;
        phoneNumber = [phoneNumber stringByReplacingOccurrencesOfString:@" " withString:@""];
        
        if (phoneNumber.length >= 11 && ![string isEqualToString:@""]) {
            return NO;
        }
        if (textField.text.length <= 13 && [string isEqualToString:@""]) {
            NSRange firstRange = [textField.text rangeOfString:@" "];
            NSRange lastRange = [textField.text rangeOfString:@" " options:NSBackwardsSearch];
            if (phoneNumber.length == 11 && (range.location == firstRange.location || range.location == lastRange.location)) {
                self.nextStepButton.clickEnable = YES;
            } else {
                self.nextStepButton.clickEnable = NO;
                self.errorNoticeLabel.hidden = YES;
            }
        } else if(phoneNumber.length < 10 && ![string isEqualToString:@""]) {
            self.nextStepButton.clickEnable = NO;
        } else {
            self.nextStepButton.clickEnable = YES;
        }
        if ((textField.text.length == 3 || textField.text.length == 8) && ![string isEqualToString:@""]) {
            textField.text = [textField.text stringByAppendingString:@" "];
        }
        return YES;
    } else {
        NSString *phoneNumber = [NSString stringWithFormat:@"%@",string];
        if (phoneNumber.length >= 13) {
            phoneNumber = [phoneNumber substringToIndex:13];
        }
        phoneNumber = [phoneNumber stringByReplacingOccurrencesOfString:@" " withString:@""];
        if (phoneNumber.length >= 11) {
            self.nextStepButton.clickEnable = YES;
        } else {
            self.nextStepButton.clickEnable = NO;
        }
        return YES;
    }
}

- (BOOL)textFieldShouldClear:(UITextField *)textField
{
    self.nextStepButton.clickEnable = NO;
    self.errorNoticeLabel.hidden = YES;
    return YES;
}

- (void)isBecomeFirstResponder
{
    [self.phoneTextField becomeFirstResponder];
}

- (void)resignTheFirstResponder
{
    [self.phoneTextField resignFirstResponder];
}

- (void)setSaasModel:(SaasModel *)saasModel
{
    if(_saasModel != saasModel){
        _saasModel = saasModel;
        self.merchantCodeLabel.text = saasModel.merchant_info.merchant_code;
        self.merchantNameLabel.text = saasModel.merchant_info.name;
    }
}

- (void)setPhoneNumber:(NSString *)phoneNumber
{
    if(phoneNumber.length == 11){
        NSMutableString *string = [phoneNumber mutableCopy];
        [string insertString:@" " atIndex:3];
        [string insertString:@" " atIndex:8];
        self.phoneTextField.text = string;
        self.nextStepButton.clickEnable = YES;
    }else{
        self.phoneTextField.text = @"";
    }
}

#pragma mark --lazy

- (UILabel *)merchantCodeLabel
{
    if(!_merchantCodeLabel){
        // CGFloat Y = IsPhone_Size_4 ? 34 : 70;
        _merchantCodeLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 16, kScreenWidth - 40, 22)];
        _merchantCodeLabel.textColor = [UIColor colorNamed:@"boss_0B0817_FFFFFF"];
        _merchantCodeLabel.font = BossRegularFont(18.f);
        // _merchantCodeLabel.text = @"123456";
        
    }
    return _merchantCodeLabel;
}

- (UILabel *)merchantNameLabel
{
    if(!_merchantNameLabel){
        _merchantNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(self.merchantCodeLabel.frame) + 10, kScreenWidth - 40, 14)];
        _merchantNameLabel.textColor = [UIColor colorNamed:@"boss_0B0817-80_FFFFFF-80"];
        _merchantNameLabel.font = BossFont(14.f);
        // _merchantNameLabel.text = @"上海易继达科技有限公司";
    }
    return _merchantNameLabel;
}



- (UIButton *)privacyBtn{
    if (!_privacyBtn) {
       
 
        //添加文字背景颜色
        _privacyBtn = [[UIButton alloc]initWithFrame:CGRectMake(20, self.nextStepButton.frame.origin.y - 30, 100, 13)];

        //设置label的富文本
        [_privacyBtn addTarget:self action:@selector(privacyAction) forControlEvents:UIControlEventTouchUpInside];
        [_privacyBtn.titleLabel setFont:[UIFont systemFontOfSize:12.0f]];
        [_privacyBtn setTitleColor:[UIColor colorNamed:@"boss_3589DE_3589DE-79"] forState:UIControlStateNormal];
        [_privacyBtn setTitle:@"隐私政策" forState:UIControlStateNormal];
        _privacyBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;

        
    }
    return _privacyBtn;
}

- (UIButton *)agreementLabel{
    if (!_agreementLabel) {
        NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc]initWithString:@"点击下一步即代表您已同意 软件许可及服务协议 和 "];
        //设置字体和设置字体的范围
        [attrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12.0f] range:NSMakeRange(0, attrStr.length)];
        //添加文字颜色
        // 点击下一步即代表您已同意
        [attrStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorNamed:@"boss_000000_FFFFFF-40"] range:NSMakeRange(0, 13)];
        // 软件许可及服务协议
        [attrStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorNamed:@"boss_3589DE_3589DE-79"] range:NSMakeRange(13, 9)];
        // 和
        [attrStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorNamed:@"boss_000000_FFFFFF-40"] range:NSMakeRange(23, 1)];
        //添加文字背景颜色
        _agreementLabel = [[UIButton alloc]initWithFrame:CGRectMake(20, self.nextStepButton.frame.origin.y - 30, 280, 13)];
        //设置label的富文本
        _agreementLabel.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [_agreementLabel addTarget:self action:@selector(doIt:) forControlEvents:UIControlEventTouchUpInside];
        [_agreementLabel setAttributedTitle:attrStr forState:UIControlStateNormal];
    }
    return _agreementLabel;
}
- (void)doIt:(UIButton *)gesture{
    if (self.agreementBlock) {
        self.agreementBlock();
    }
}

- (void)privacyAction {
    if (self.privacyBlock) {
        self.privacyBlock();
    }
    
}


- (UITextField *)phoneTextField
{
    if (!_phoneTextField) {
        CGFloat height = IsPhone_Size_4 ? 30 : 36;
        _phoneTextField = [[UITextField alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(self.merchantNameLabel.frame) + 20, kScreenWidth - 40, height)];
        _phoneTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _phoneTextField.font = BossBlodFont(25.f);
        NSMutableAttributedString *placeholderAttString = [[NSMutableAttributedString alloc] initWithString:@"请输入手机号码"];
        [placeholderAttString addAttributes:@{NSFontAttributeName:BossRegularFont(25.f)} range:NSMakeRange(0, placeholderAttString.length)];
        _phoneTextField.attributedPlaceholder = placeholderAttString;
        _phoneTextField.textColor = [UIColor colorNamed:@"boss_000000-80_FFFFFF-80"];
        _phoneTextField.delegate = self;
        _phoneTextField.keyboardType = UIKeyboardTypeNumberPad;
        _phoneTextField.tintColor = kAppMainColor;
    }
    return _phoneTextField;
}

- (UIView *)line
{
    if (!_line) {
        _line = [[UIView alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(self.phoneTextField.frame) + 10, kScreenWidth - 40, 1)];
        _line.backgroundColor = [UIColor colorNamed:@"boss_000000-20_FFFFFF-20"];
    }
    return _line;
}

- (UILabel *)errorNoticeLabel
{
    if (!_errorNoticeLabel) {
        _errorNoticeLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(self.line.frame) + 10, kScreenWidth - 40, 17)];
        _errorNoticeLabel.text = @"您的手机号格式不正确";
        _errorNoticeLabel.font = BossRegularFont(12.f);
        _errorNoticeLabel.textColor = [UIColor colorNamed:@"boss_D0021B-40_FF2729"];
        _errorNoticeLabel.hidden = YES;
    }
    return _errorNoticeLabel;
}

- (NNBButton *)nextStepButton
{
    if (!_nextStepButton) {
        CGFloat Y = IsPhone_Size_4 ? kInputPhoneNumberViewHeight - 47 - 63: kInputPhoneNumberViewHeight - 47;
        _nextStepButton = [NNBButton buttonWithFrame:CGRectMake(0, Y, kScreenWidth, 47)];
        _nextStepButton.clickEnable = NO;
        [_nextStepButton setTitle:@"下一步" forState:UIControlStateNormal];
        _nextStepButton.backgroundColor = [UIColor colorNamed:@"boss_479CFF_0087FF"];
        [_nextStepButton addTarget:self action:@selector(nextStepButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _nextStepButton;
}

- (NSString *)phoneNumber
{
    _phoneNumber = [self.phoneTextField.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    return _phoneNumber;
}


@end
