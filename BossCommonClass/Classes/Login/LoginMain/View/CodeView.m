//
//  CodeView.m
//  NNB
//
//  Created by 贾远潮 on 2017/12/20.
//

#import "CodeView.h"
#import "JYCTextField.h"
#import "BossBasicDefine.h"

#define kDelayTime (0.0f)

@interface CodeView()<UITextFieldDelegate,JYCTextFieldDelegate>

@property (nonatomic, strong) NSMutableArray *textArray;

@property (nonatomic, strong) NSString *codeString;

@property (nonatomic, assign) BOOL autoInputEnd;
/// 解决调用删除时，第一次会调用两次的问题
@property (nonatomic, assign) BOOL returnDelete;

@end

@implementation CodeView


-(void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection{
    [super traitCollectionDidChange:previousTraitCollection];
    for (UITextField *codeTextField in self.textArray){
        
        codeTextField.backgroundColor = [UIColor colorNamed:@"boss_FFFFFF_767680-24"];
        codeTextField.layer.borderColor = [UIColor colorNamed:@"boss_000000-60_FFFFFF-10"].CGColor;
        codeTextField.textColor = [UIColor colorNamed:@"boss_000000-80_FFFFFF-80"];
    }
    
    
}
/**
 初始化CodeView

 @param frame frame大小
 @param maxNumber 验证码个数
 @return 验证码View
 */

- (__kindof CodeView *)initWithFrame:(CGRect)frame
                           maxNumber:(NSInteger)maxNumber
{
    if (self = [super initWithFrame:frame]) {
        if (maxNumber < 1) {
            return self;
        }
        self.autoInputEnd = YES;
        [self.textArray removeAllObjects];
        CGFloat marginAll = (self.width - self.height * maxNumber);
        CGFloat margin = marginAll > 0 ? marginAll / (maxNumber - 1) : 0;
        for (NSInteger i = 0; i < maxNumber; i++) {
            JYCTextField *codeTextField = [[JYCTextField alloc] initWithFrame:CGRectMake((self.height + margin) * i, 0, self.height, self.height)];
            codeTextField.layer.cornerRadius = 2.f;
            codeTextField.backgroundColor = [UIColor colorNamed:@"boss_FFFFFF_767680-24"];
            codeTextField.layer.borderColor = [UIColor colorNamed:@"boss_000000-60_FFFFFF-10"].CGColor;
            codeTextField.layer.borderWidth = 0.5f;
            codeTextField.textAlignment = NSTextAlignmentCenter;
            codeTextField.delegate = self;
            codeTextField.jyc_delegate = self;
            codeTextField.tag = 1000 + i;
            codeTextField.font = BossBlodFont(25.f);
            codeTextField.textColor = [UIColor colorNamed:@"boss_000000-80_FFFFFF-80"];
            codeTextField.keyboardType = UIKeyboardTypeNumberPad;
            codeTextField.tintColor = [UIColor clearColor];
            
            [self addSubview:codeTextField];
            [self.textArray addObject:codeTextField];
        }
    }
    return self;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField.text.length > 0) {
        return NO;
    }
    NSInteger index = textField.tag - 1000;
    if (index > 0) {
        for (NSInteger i = 0; i < index; i++) {
            UITextField *textField = self.textArray[i];
            if (textField.text.length == 0) {
                return NO;
            }
        }
    }
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    // 自动填充过程中
    if (!self.autoInputEnd && ![textField.text isEqualToString:@""]) {
        return NO;
    }
    // 第一次自动填充时事件
    if (string.length > 1) {
        self.autoInputEnd = NO;
        
        [self isBecomeFirstResponder];
        // 截取前6位
        if (string.length >= self.textArray.count) {
            string = [string substringWithRange:NSMakeRange(0, self.textArray.count)];
        }
        
        for (NSInteger i = 0; i < string.length; i++) {
            NSRange strRang = NSMakeRange(i, 1);
            UITextField *textFieldL;
            if (i + 1 <= self.textArray.count) {
                textFieldL = self.textArray[i];
                textFieldL.text = [string substringWithRange:strRang];
            }
        }
        if (string.length == self.textArray.count){
            // 填充完成，回调
            [self performSelector:@selector(inputEnd) withObject:nil afterDelay:0.25];
        } else {
            self.autoInputEnd = YES;
        }
        return NO;
    }
    if (textField.text.length >= 1 && ![string isEqualToString:@""]) {
        NSInteger index = textField.tag - 1000;
        if (index + 2 < self.textArray.count) {
            UITextField *textField = self.textArray[index + 1];
            textField.text = string;
            UITextField *firstTextField = self.textArray[index + 2];
            [firstTextField performSelector:@selector(becomeFirstResponder) withObject:nil afterDelay:kDelayTime];
        } else if (index + 2 == self.textArray.count){
            UITextField *textField = self.textArray[index + 1];
            textField.text = string;
            [textField performSelector:@selector(becomeFirstResponder) withObject:nil afterDelay:kDelayTime];
            [self performSelector:@selector(inputEnd) withObject:nil afterDelay:0.25];
        } else if (index + 1 == self.textArray.count){
            [self performSelector:@selector(inputEnd) withObject:nil afterDelay:0.25];
        }
        return NO;
    } else if(textField.text.length == 0 && ![string isEqualToString:@""]){
        NSInteger index = textField.tag - 1000;
        if (index + 1 < self.textArray.count) {
            UITextField *textField = self.textArray[index + 1];
            [textField performSelector:@selector(becomeFirstResponder) withObject:nil afterDelay:kDelayTime];
        } else if(index + 1 == self.textArray.count) {
            [self performSelector:@selector(inputEnd) withObject:nil afterDelay:0.25];
        }
        return YES;
    } else if (textField.text.length <= 1 && [string isEqualToString:@""]){
        NSInteger index = textField.tag - 1000;
        if (index - 1 >= 0) {
            UITextField *textField = self.textArray[index - 1];
            [textField performSelector:@selector(becomeFirstResponder) withObject:nil afterDelay:kDelayTime];
        }
        /*
         已填验证码大于一位时，第一次点击删除会删除两位(调用一遍shouldChangeCharactersInRange,再调用一遍textFieldDeleteBackward,正常删除只调用textFieldDeleteBackward),所以第一遍时，调用本方法后，拦截，使之不再调用textFieldDeleteBackward
         */
        self.returnDelete = YES;
        return YES;
    }
    return YES;
}

- (void)textFieldDeleteBackward:(JYCTextField *)textField
{
    NSInteger index = textField.tag - 1000;
    if (index > 0 && self.returnDelete == NO) {
        JYCTextField *textField = self.textArray[index - 1];
        textField.text = @"";
        [textField becomeFirstResponder];
    }
    self.returnDelete = NO;
}

- (void)inputEnd
{
    if (self.inputCodeEndBlock) {
        NSString *code = self.codeString;
        self.autoInputEnd = YES;
        self.inputCodeEndBlock(code);
    }
}

/**
 第一个输入框成为第一响应者
 */
- (void)isBecomeFirstResponder
{
    if (self.textArray.count > 0) {
        for (UITextField *textField in self.textArray) {
            textField.text = @"";
        }
        UITextField *textField = self.textArray[0];
        [textField becomeFirstResponder];
    }
}


/**
 最后一个输入框成为第一响应者
 */
- (void)isLastBecomeFirstResponder
{
    if (self.textArray.count > 0) {
        UITextField *textField = self.textArray.lastObject;
        [textField becomeFirstResponder];
        for (UITextField *textField in self.textArray) {
            textField.text = @"";
        }
    }
}

/**
 释放第一响应着
 */
- (void)resignTheFirstResponder
{
    [self endEditing:YES];
}

- (NSMutableArray *)textArray
{
    if (!_textArray) {
        _textArray = [NSMutableArray array];
    }
    return _textArray;
}


- (NSString *)codeString
{
    NSString *code = @"";
    for (UITextField *textField in self.textArray) {
        code = [code stringByAppendingFormat:@"%@",textField.text];
    }
    _codeString = code;
    return _codeString;
}

@end
