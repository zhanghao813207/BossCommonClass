//
//  QHTextField.h
//  QHReceipt
//
//  Created by white on 2016/8/16.
//  Copyright © 2016年 欧客云. All rights reserved.
//  可控placehorler的textfield

#import <UIKit/UIKit.h>

typedef BOOL(^InputRegular)(NSString *str);
typedef void(^InputReturnKeyAction)();
@interface QHTextField : UIView
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UIView *customView;

@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, strong) UIColor *placeHolderColor;
@property (nonatomic, strong) UIColor *lineColor;
@property (nonatomic, assign) NSTextAlignment placeHolderAlignment;

@property (nonatomic, copy) NSString *regularString;
@property (nonatomic, assign) UIKeyboardType keyboardType;
@property (nonatomic, copy) InputRegular inputRegular;
@property (nonatomic, copy) InputReturnKeyAction returnAction;
@property (nonatomic, assign) BOOL hidenLine;

- (instancetype)initWithFrame:(CGRect)frame placeholder:(NSString *)placeholder;
- (instancetype)initWithFrame:(CGRect)frame placeholder:(NSString *)placeholder inputRegular:(InputRegular)inputRegular;

- (instancetype)initWithFrame:(CGRect)frame placeholder:(NSString *)placeholder inputRegular:(InputRegular)inputRegular haveLine:(BOOL)have;
- (void)updatePlaceHolder:(NSString *)placeHolder;

- (void)updateFrame:(CGRect)frame;
@end

@interface QHTextFieldManager:NSObject
@property (nonatomic, weak) QHTextField *textField;
+ (instancetype )sharedManager;
@end
