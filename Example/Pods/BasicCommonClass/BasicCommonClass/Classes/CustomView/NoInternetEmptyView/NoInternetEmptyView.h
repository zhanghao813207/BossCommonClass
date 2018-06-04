//
//  NoInternetEmptyView.h
//  Gtyk
//
//  Created by 贾远潮 on 2016/11/17.
//  Copyright © 2016年 GTYK. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "EmptyView.h"

@interface NoInternetEmptyView : UIView

@property (nonatomic, assign) EmptyViewType noInternetEmptyViewType;

@property (nonatomic, copy) void (^emptyButtonIsSelect)(BOOL isSelect);

@end
