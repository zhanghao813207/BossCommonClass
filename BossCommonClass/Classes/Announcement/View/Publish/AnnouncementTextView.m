
//
//  AnnouncementTextView.m
//  AFNetworking
//
//  Created by admin on 2019/4/15.
//

#import "AnnouncementTextView.h"
#import "Masonry.h"


@interface AnnouncementTextView ()<UITextViewDelegate>

@end

@implementation AnnouncementTextView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.delegate = self;
        // 设置默认字体
        self.font = [UIFont systemFontOfSize:15];
        
        // 设置默认颜色
        self.placeholderColor = [UIColor grayColor];
        
        // 使用通知监听文字改变
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange:) name:UITextViewTextDidChangeNotification object:self];
    }
    return self;
}

- (void)textDidChange:(NSNotification *)note {
    // 会重新调用drawRect:方法
    [self setNeedsDisplay];
}
- (void)textViewDidChange:(UITextView *)textView {
    CGFloat height = [textView sizeThatFits:CGSizeMake(textView.frame.size.width, MAXFLOAT)].height;
    textView.scrollEnabled = false;
    [textView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(height));
    }];
}
- (void)drawRect:(CGRect)rect {
    if (self.hasText) {
        return;
    }
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = self.font;
    attrs[NSForegroundColorAttributeName] = self.placeholderColor;
    
    // 画文字
    rect.origin.x = 1;
    rect.origin.y = 10;
    rect.size.width -= 2 * rect.origin.x;
    [self.placeholder drawInRect:rect withAttributes:attrs];
}


- (void)setPlaceholder:(NSString *)placeholder {
    _placeholder = placeholder;
    [self setNeedsDisplay];
}
- (void)setPlaceholderColor:(UIColor *)placeholderColor {
    _placeholderColor = placeholderColor;
    [self setNeedsDisplay];
}
- (void)setFont:(UIFont *)font {
    [super setFont:font];
    [self setNeedsDisplay];
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
