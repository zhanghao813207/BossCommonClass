//
//  JYCTextField.h
//  NNB
//
//  Created by 贾远潮 on 2018/3/30.
//

#import <UIKit/UIKit.h>
@class JYCTextField;
@protocol JYCTextFieldDelegate <NSObject>

- (void)textFieldDeleteBackward:(JYCTextField *)textField;

@end

@interface JYCTextField : UITextField

@property (nonatomic, assign) id <JYCTextFieldDelegate> jyc_delegate;

@end
