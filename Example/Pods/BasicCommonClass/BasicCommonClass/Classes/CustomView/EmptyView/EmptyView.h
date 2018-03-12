//
//  EmptyView.h
//  Gtyk
//
//  Created by 贾远潮 on 2016/11/17.
//  Copyright © 2016年 GTYK. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, EmptyViewType){
    EmptyViewTypeNoButton,
    EmptyViewTypeHasButton,
};

@interface EmptyView : UIView

@property (nonatomic, assign) EmptyViewType emptyViewType;

@property (nonatomic, strong) UIImage *emptyImage;

@property (nonatomic, strong) NSString *emptyString;

@property (nonatomic, strong) NSString *emptyDetailString;

@property (nonatomic, strong) NSString *emptyButtonTitle;

@property (nonatomic, copy) void (^emptyButtonIsSelect)(BOOL isSelect);

@end
