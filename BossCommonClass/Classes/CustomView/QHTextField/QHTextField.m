//
//  QHTextField.m
//  QHReceipt
//
//  Created by white on 2016/8/16.
//  Copyright © 2016年 QuHuo. All rights reserved.
//

#import "QHTextField.h"
#import "NNBBasicDefine.h"

@interface QHTextField()<UITextFieldDelegate>

@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, copy) NSString *placeHolder;
@property (nonatomic, strong) UIView *verticalLineView;
@end

@implementation QHTextField

- (instancetype)initWithFrame:(CGRect)frame placeholder:(NSString *)placeholder{
   
    return [[QHTextField alloc] initWithFrame:frame placeholder:placeholder inputRegular:nil];
}
- (instancetype)initWithFrame:(CGRect)frame placeholder:(NSString *)placeholder inputRegular:(InputRegular)inputRegular{
    if (frame.size.height < 44){
        frame.size.height = 44;
    }
    self = [super initWithFrame:frame];
    if (self)  {
        [self addSubview:self.textField];
        [self addSubview:self.lineView];
        self.placeHolder = placeholder;
        self.textField.attributedPlaceholder = [self attributedPlaceHolder];
        self.textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        self.clipsToBounds = YES;
        self.inputRegular = inputRegular;
        __weak __typeof__(self) weakSelf = self;
        self.returnAction = ^(){
            [weakSelf.textField resignFirstResponder];
        };
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame placeholder:(NSString *)placeholder inputRegular:(InputRegular)inputRegular haveLine:(BOOL)have{
    if (frame.size.height < 44){
        frame.size.height = 44;
    }
    self = [super initWithFrame:frame];
    if (self)  {
        [self addSubview:self.textField];
        if (have) {
            [self addSubview:self.lineView];
        }
        self.placeHolder = placeholder;
        self.textField.attributedPlaceholder = [self attributedPlaceHolderWithAlignment:NSTextAlignmentLeft];
        self.textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        self.clipsToBounds = YES;
        self.inputRegular = inputRegular;
        self.textField.delegate = self;
        __weak __typeof__(self) weakSelf = self;
        self.returnAction = ^(){
            [weakSelf.textField resignFirstResponder];
        };
    }
    
    return self;
}



#pragma mark - private Method

- (void)updateFrame:(CGRect)frame {
    self.frame = frame;
    self.textField.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height-0.5);
}

- (NSAttributedString *)attributedPlaceHolder{
    
    return [self attributedPlaceHolderWithFontSize:16 textColor:kHexRGBA(0x000000, 0.4) alignment:NSTextAlignmentCenter];
}

- (NSAttributedString *)attributedPlaceHolderWithFontSize:(CGFloat)fontSize{
    return [self attributedPlaceHolderWithFontSize:fontSize textColor:kHexRGBA(0x000000, 0.4)];
}

- (NSAttributedString *)attributedPlaceHolderWithTextColor:(UIColor *)color{
    return [self attributedPlaceHolderWithTextColor:color alignment:NSTextAlignmentCenter];
}

- (NSAttributedString *)attributedPlaceHolderWithAlignment:(NSTextAlignment)alignment{
    return [self attributedPlaceHolderWithTextColor:kHexRGBA(0x000000, 0.4) alignment:alignment];
}

- (NSAttributedString *)attributedPlaceHolderWithFontSize:(CGFloat)fontSize
                                                textColor:(UIColor *)color{
    return [self attributedPlaceHolderWithFontSize:fontSize textColor:color alignment:NSTextAlignmentCenter];
}

- (NSAttributedString *)attributedPlaceHolderWithFontSize:(CGFloat)fontSize
                                                alignment:(NSTextAlignment)alignment{
   return [self attributedPlaceHolderWithFontSize:fontSize textColor:kHexRGBA(0x000000, 0.4) alignment:alignment];
}

- (NSAttributedString *)attributedPlaceHolderWithTextColor:(UIColor *)color
                                                 alignment:(NSTextAlignment)alignment{
    return [self attributedPlaceHolderWithFontSize:16 textColor:color alignment:alignment];
}

- (NSAttributedString *)attributedPlaceHolderWithFontSize:(CGFloat)fontSize
                                                  textColor:(UIColor *)color
                                                  alignment:(NSTextAlignment)alignment{
    NSString *placeHolder = self.placeHolder;
    
    NSMutableAttributedString *attriStr = [[NSMutableAttributedString alloc] initWithString:placeHolder];
    
    //设置字体格式和大小
    [attriStr addAttribute:NSFontAttributeName value:NNBFont(fontSize) range:NSMakeRange(0, [placeHolder length])];
    
    //设置字体颜色
    [attriStr addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(0, [placeHolder length])];
    
    //居中显示
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setAlignment:alignment];
    [attriStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [placeHolder length])];
    
    return [attriStr copy];
}

- (void)attributedPlaceHolderUpdateColor:(UIColor *)color{
    NSMutableAttributedString *attributePlaceHolder = [self.textField.attributedPlaceholder mutableCopy];
    NSString *placeHolder = self.placeHolder;
    //设置字体颜色
    [attributePlaceHolder addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(0, [placeHolder length])];
    self.textField.attributedPlaceholder = [attributePlaceHolder copy];
}

- (void)attributedPlaceHolderUpdateFontSize:(CGFloat )fontSize{
    NSMutableAttributedString *attributePlaceHolder = [self.textField.attributedPlaceholder mutableCopy];
    NSString *placeHolder = self.placeHolder;
    //设置字体格式和大小
    [attributePlaceHolder addAttribute:NSFontAttributeName value:NNBFont(fontSize) range:NSMakeRange(0, [placeHolder length])];
    self.textField.attributedPlaceholder = [attributePlaceHolder copy];
}

- (void)attributedPlaceHolderUpdateAlignment:(NSTextAlignment )alignment{
    NSMutableAttributedString *attributePlaceHolder = [self.textField.attributedPlaceholder mutableCopy];
    NSString *placeHolder = self.placeHolder;
    //居中显示
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setAlignment:alignment];
    [attributePlaceHolder addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [placeHolder length])];
    self.textField.attributedPlaceholder = [attributePlaceHolder copy];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    [QHTextFieldManager sharedManager].textField = self;
    self.textField.attributedPlaceholder = [self attributedPlaceHolderWithAlignment:NSTextAlignmentLeft];
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    NSString *newStr = [textField.text stringByReplacingCharactersInRange:range withString:string];
    BOOL isTrue = YES;
    if (self.regularString.length > 0)  {
        NSPredicate *regexPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", self.regularString];
        isTrue = [regexPredicate evaluateWithObject:newStr];
    }else if(self.inputRegular){
        isTrue =  self.inputRegular(newStr);
    }
    
    if (self.customView) {
        
        if (newStr.length == 11) {
            if (isTrue) {
                [self showCustomView];
            }
        }else{
            if (textField.text.length != 11 || newStr.length < 11){
                [self hidenCustomView];
            }
        }
    }
    
    return isTrue;
}

- (BOOL) textFieldShouldClear:(UITextField *)textField{
    [self hidenCustomView];
    if (self.regularString.length > 0)  {
    }else if(self.inputRegular){
        self.inputRegular(@"");
    }
    return YES;
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    if (self.returnAction) {
        self.returnAction();
    }
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    self.textField.attributedPlaceholder = [self attributedPlaceHolderWithAlignment:self.placeHolderAlignment];
    return YES;
}

#pragma mark private Method
- (void)showCustomView{
    if (self.customView){
        CGRect rect = self.customView.frame;
        
        CGRect customViewRect = rect;
        customViewRect.origin.x = self.bounds.size.width - rect.size.width;
        customViewRect.size.height = MAX(customViewRect.size.height, self.bounds.size.height);
        customViewRect.origin.y = (self.bounds.size.height - customViewRect.size.height)/2.0;
        
        CGRect newRect = customViewRect;
        newRect.origin.x = self.bounds.size.width;
        self.customView.frame = newRect;
        self.customView.hidden = NO;
        
        CGRect textFieldRect = self.textField.frame;
        textFieldRect.size.width = self.verticalLineView.frame.origin.x;
        
        self.verticalLineView.alpha = 0.0;
        self.verticalLineView.hidden = NO;
        
        [UIView animateWithDuration:0.25 animations:^{
            self.customView.frame = customViewRect;
            self.textField.frame = textFieldRect;
        } completion:^(BOOL finished) {
            if(finished){
                [UIView animateWithDuration:0.25 animations:^{
                    self.verticalLineView.alpha = 1.0;
                }];
            }
        }];
    }
}

- (void)hidenCustomView{
    if (self.customView){
        if (self.customView.hidden == YES)
            return;
        
        CGRect rect = self.customView.frame;
        CGRect newRect = rect;
        newRect.origin.x = self.bounds.size.width;
        
        CGRect textFieldRect = self.textField.frame;
        textFieldRect.size.width = self.bounds.size.width;
        
        [UIView animateWithDuration:0.25 animations:^{
            self.customView.frame = newRect;
            self.textField.frame = textFieldRect;
            self.verticalLineView.alpha = 0.0;
        } completion:^(BOOL finished) {
            if (finished){
                self.customView.hidden = YES;
                self.verticalLineView.hidden = YES;
            }
        }];
    }
}

#pragma mark - getter && setter
- (UIView *)lineView{
    if (_lineView==nil) {
        _lineView = [[UIView alloc] initWithFrame:CGRectMake(0, self.bounds.size.height-0.5, self.bounds.size.width, 0.5)];
        _lineView.backgroundColor = kHexRGBA(0x00000, 0.1);
    }
    return _lineView;
}

- (void)setHidenLine:(BOOL)hidenLine{
    _hidenLine = hidenLine;
    if (_hidenLine) {
        self.lineView.hidden = YES;
    }
}

- (UIView *)verticalLineView{
    if (_verticalLineView==nil) {
        _verticalLineView = [[UIView alloc] initWithFrame:CGRectMake(0, self.bounds.size.height*3/10, 0.5, self.bounds.size.height *2/5)];
        _verticalLineView.backgroundColor = kHexRGBA(0x00000, 0.1);
        _verticalLineView.hidden = YES;
    }
    return _verticalLineView;
}

- (UITextField *)textField{
    if (_textField==nil) {
        _textField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height-0.5)];
        _textField.backgroundColor = [UIColor clearColor];
        _textField.borderStyle = UITextBorderStyleNone;
        _textField.textColor = [UIColor blackColor];
        _textField.font = NNBFont(16);
        _textField.textAlignment = NSTextAlignmentLeft;
        _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    }
    return _textField;
}

- (void)setPlaceHolderColor:(UIColor *)placeHolderColor{
    _placeHolderColor = placeHolderColor;
    [self attributedPlaceHolderUpdateColor:placeHolderColor];
}

- (void)setTextColor:(UIColor *)textColor{
    self.textField.textColor = textColor;
}

- (void)setLineColor:(UIColor *)lineColor{
    self.lineView.backgroundColor = lineColor;
}

- (void)setRegularString:(NSString *)regularString{
    _regularString = [regularString copy];
    
    _textField.delegate = self;
}

- (void)setKeyboardType:(UIKeyboardType)keyboardType{
    self.textField.keyboardType = keyboardType;
}

- (void)setInputRegular:(InputRegular)inputRegular{
    _inputRegular = [inputRegular copy];
    if (_inputRegular){
        _textField.delegate = self;
    }
}

- (void)setCustomView:(UIView *)customView{
    _customView = customView;
    
    CGRect rect = self.verticalLineView.frame;
    rect.origin.x = self.bounds.size.width - customView.bounds.size.width ;
    self.verticalLineView.frame = rect;
    
    CGRect customViewRect = customView.frame;
    customViewRect.origin.x = self.bounds.size.width - customView.bounds.size.width;
    customViewRect.size.height = MAX(customViewRect.size.height, self.bounds.size.height);
    customViewRect.origin.y = (self.bounds.size.height - customViewRect.size.height)/2.0;
    _customView.frame = customViewRect;
    _customView.hidden = YES;
    [self addSubview:self.customView];
    [self addSubview:self.verticalLineView];
    self.textField.delegate = self;
}

- (void)setReturnAction:(InputReturnKeyAction)returnAction{
    _returnAction = [returnAction copy];
    self.textField.delegate = self;
}

- (void)setPlaceHolderAlignment:(NSTextAlignment)placeHolderAlignment{
    _placeHolderAlignment = placeHolderAlignment;
    self.textField.attributedPlaceholder =  [self attributedPlaceHolderWithFontSize:16 textColor:kHexRGBA(0x00000, 0.4) alignment:placeHolderAlignment];
}

- (void)updatePlaceHolder:(NSString *)placeHolder {
    self.placeHolder = placeHolder;
    self.textField.attributedPlaceholder = [self attributedPlaceHolderWithAlignment:self.placeHolderAlignment];
}

@end

@implementation QHTextFieldManager

+ (instancetype )sharedManager
{
    static QHTextFieldManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[QHTextFieldManager alloc] init];
    });
    return sharedInstance;
}

@end
