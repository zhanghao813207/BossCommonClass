//
//  UITextView+Placeholder.h
//  AoAoMerchant
//
//  Created by white on 2016/11/15.
//  Copyright © 2016年 欧客云. All rights reserved.
//

#import <UIKit/UIKit.h>

#define TextColor [UIColor colorNamed:@"boss_000000-80_FFFFFF-90"]
#define PlaceHolderColor [UIColor colorNamed:@"boss_000000-40_FFFFFF-40"]

@interface UITextView (Placeholder) <UITextViewDelegate>
@property (nonatomic,   copy) NSString *placeHolder;
@property (nonatomic, assign) NSInteger characterCount;
@property (nonatomic, strong) UILabel *characterLabel;

+ (instancetype)textViewWithFrame:(CGRect)frame
                      placeHolder:(NSString *)placeHolder
                   characterCount:(NSInteger)count ;

@end
