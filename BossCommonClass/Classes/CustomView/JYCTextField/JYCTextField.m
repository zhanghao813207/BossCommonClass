//
//  JYCTextField.m
//  NNB
//
//  Created by 贾远潮 on 2018/3/30.
//

#import "JYCTextField.h"

@implementation JYCTextField


- (void)deleteBackward {
//    ！！！这里要调用super方法，要不然删不了东西
    [super deleteBackward];
    
    if ([self.jyc_delegate respondsToSelector:@selector(textFieldDeleteBackward:)]) {
        [self.jyc_delegate textFieldDeleteBackward:self];
    }
}

@end
