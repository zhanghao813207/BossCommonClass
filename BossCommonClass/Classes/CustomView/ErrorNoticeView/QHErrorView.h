//
//  QHErrorView.h
//  QHReceipt
//
//  Created by white on 2016/8/24.
//  Copyright © 2016年 QuHuo. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM (int, QHErrorViewType) {
    QHErrorViewType_error = 1,//
    QHErrorViewType_alert = 2,//
};

@interface QHErrorView : UIView
- (instancetype)initWithFrame:(CGRect)frame
                     errorMsg:(NSString *)errorMsg
                    errorType:(QHErrorViewType)type;
- (void)showInView:(UIView *)view;
- (void)showInView:(UIView *)view atUp:(BOOL)up;
- (void)dismiss;

- (instancetype)initWithTitle:(NSString *)string;

@end
