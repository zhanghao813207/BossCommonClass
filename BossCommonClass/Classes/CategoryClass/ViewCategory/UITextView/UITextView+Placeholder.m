//
//  UITextView+Placeholder.m
//  AoAoMerchant
//
//  Created by white on 2016/11/15.
//  Copyright © 2016年 欧客云. All rights reserved.
//

#import "UITextView+Placeholder.h"
#import <objc/runtime.h>
#import "BossBasicDefine.h"

static const void *placeHolderKey = &placeHolderKey;
static const void *characterCountKey = &characterCountKey;
static const void *characterLabelKey = &characterLabelKey;

@implementation UITextView (Placeholder)
@dynamic placeHolder;
@dynamic characterCount;

+ (instancetype)textViewWithFrame:(CGRect)frame
                  placeHolder:(NSString *)placeHolder
                        characterCount:(NSInteger)count {
    
    UITextView *textView = [[UITextView alloc] initWithFrame:frame];
    textView.placeHolder = placeHolder;
    textView.characterCount = count;
    textView.delegate = textView;
    textView.backgroundColor = [UIColor colorNamed:@"boss_FFFFFF_2B2B2B"];
    textView.layer.masksToBounds = YES;
    textView.layer.borderWidth = .5;
    textView.layer.borderColor = [UIColor colorNamed:@"boss_DFDFDF_2B2B2B"].CGColor;
    textView.layer.cornerRadius = 2.0;
    textView.textColor = PlaceHolderColor;
    textView.text = placeHolder;
    textView.font = BossFont(14.f);
    
//    UILabel *countLabel = [[UILabel alloc] initWithFrame:CGRectMake(frame.size.width-80, frame.size.height-30, 70, 20)];
//    countLabel.backgroundColor = [UIColor clearColor];
//    countLabel.font = BossFont(14.f);
//    countLabel.textColor = kHexRGBA(0x000000, 0.6);
//    countLabel.textAlignment = NSTextAlignmentCenter;
//    countLabel.text = [NSString stringWithFormat:@"0/%2d字",(int)count];
//
//    textView.characterLabel = countLabel;
    
    [[NSNotificationCenter defaultCenter] addObserver:textView selector:@selector(textViewEditChanged:)
                                                name:@"UITextViewTextDidChangeNotification"
                                              object:textView];
//    [textView addSubview:countLabel];
    return textView;
}

- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
    [super traitCollectionDidChange:previousTraitCollection];
    if (@available(iOS 12.0, *)) {
        if (previousTraitCollection.userInterfaceStyle == UIUserInterfaceStyleDark) {
            self.layer.borderColor = kHexRGB(0xdfdfdf).CGColor;
        }else {
            self.layer.borderColor = kHexRGB(0x2B2B2B).CGColor;
        }
    }
}

#pragma mark private

- (void)resetInputLocation{
    NSRange range;
    range.location = 0;
    range.length = 0;
    self.selectedRange = range;
}

#pragma mark life cycle

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"UITextViewTextDidChangeNotification"
                                                  object:self];
}

#pragma mark UITextViewDelegate

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    if ([[textView.text stringByReplacingOccurrencesOfString:@" " withString:@""] isEqualToString:@""] || [[textView.text stringByReplacingOccurrencesOfString:@" " withString:@""] isEqualToString:self.placeHolder]){
        textView.textColor = PlaceHolderColor;
        textView.text = self.placeHolder;
        
        [self resetInputLocation];
    }else {
        textView.textColor = TextColor;
    }
    return YES;
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView{
    if ([[textView.text stringByReplacingOccurrencesOfString:@" "
                                                  withString:@""] isEqualToString:@""]
        || [[textView.text stringByReplacingOccurrencesOfString:@" "
                                                     withString:@""] isEqualToString:self.placeHolder]){
        
        [textView setSelectedRange:NSMakeRange(0, 0)];
        textView.textColor = PlaceHolderColor;
        textView.text = self.placeHolder;
        
        [self resetInputLocation];
    }else {
        textView.textColor = TextColor;
    }
    return YES;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    NSString *string ;
    if ([textView.text isEqualToString:self.placeHolder]) {
        
        textView.text = @"";
    }
    
    string = [textView.text stringByReplacingCharactersInRange:range withString:text];
    textView.textColor = TextColor;
    
    return YES;
}

- (void)textViewDidChangeSelection:(UITextView *)textView
{
    
    if (([[textView.text stringByReplacingOccurrencesOfString:@" "
                                                   withString:@""] isEqualToString:@""]
         || [[textView.text stringByReplacingOccurrencesOfString:@" "
                                                      withString:@""] isEqualToString:self.placeHolder])
        && !NSEqualRanges(textView.selectedRange, NSMakeRange(0, 0))){
        
        [self resetInputLocation];
    }
}

- (void)textViewDidChange:(UITextView *)textView {
    if ([[textView.text stringByReplacingOccurrencesOfString:@" "
                                                  withString:@""] isEqualToString:@""]
        || [[textView.text stringByReplacingOccurrencesOfString:@" "
                                                  withString:@""] isEqualToString:self.placeHolder]){
        
        textView.textColor = PlaceHolderColor;
        textView.text = self.placeHolder;
    }else {
        textView.textColor = TextColor;
    }
}


-(void)textViewEditChanged:(NSNotification *)obj{
    
    UITextView *textView = (UITextView *)obj.object;
    NSString *toBeString = textView.text;
    
    // 键盘输入模式
    NSString *lang = [[UITextInputMode activeInputModes][0] primaryLanguage];
    
    if ([lang isEqualToString:@"zh-Hans"]) {
        
        // 简体中文输入，包括简体拼音，健体五笔，简体手写
        UITextRange *selectedRange = [textView markedTextRange];
        
        //获取高亮部分
        UITextPosition *position = [textView positionFromPosition:selectedRange.start offset:0];
        
        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if (!position) {
            
            if (toBeString.length > self.characterCount) {
                textView.text = [toBeString substringToIndex:self.characterCount];
            }
            
            if ([self.text isEqualToString:self.placeHolder]) {
                
                self.characterLabel.text = [NSString stringWithFormat:@"0/%d字",(int)self.characterCount];
            }else {
                
                self.characterLabel.text = [NSString stringWithFormat:@"%2d/%d字",(int)self.text.length,(int)self.characterCount];
            }
            
        } else {
            // 有高亮选择的字符串，则暂不对文字进行统计和限制
            
        }
    } else {
        
        // 中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
        
        if (toBeString.length > self.characterCount) {
            textView.text = [toBeString substringToIndex:self.characterCount];
        }
        
        if ([self.text isEqualToString:self.placeHolder]) {
            
            self.characterLabel.text = [NSString stringWithFormat:@"0/%d字",(int)self.characterCount];
        }else {
            
            self.characterLabel.text = [NSString stringWithFormat:@"%2d/%d字",(int)self.text.length,(int)self.characterCount];
        }
        
    }
}

#pragma mark getter && setter

- (NSString *)placeHolder {
    return objc_getAssociatedObject(self, placeHolderKey);
}

- (void)setPlaceHolder:(NSString *)placeHolder {
    objc_setAssociatedObject(self, placeHolderKey, placeHolder, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSInteger )characterCount {
    return [objc_getAssociatedObject(self, characterCountKey) integerValue];
}

- (void)setCharacterCount:(NSInteger)characterCount {
    objc_setAssociatedObject(self, characterCountKey, @(characterCount), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UILabel *)characterLabel {
    return objc_getAssociatedObject(self, characterLabelKey);
}

- (void)setCharacterLabel:(UILabel *)characterLabel {
    objc_setAssociatedObject(self, characterLabelKey, characterLabel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
