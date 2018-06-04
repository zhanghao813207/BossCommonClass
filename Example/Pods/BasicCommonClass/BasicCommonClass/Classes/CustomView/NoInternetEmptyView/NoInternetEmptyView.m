//
//  NoInternetEmptyView.m
//  Gtyk
//
//  Created by 贾远潮 on 2016/11/17.
//  Copyright © 2016年 GTYK. All rights reserved.
//

#import "NoInternetEmptyView.h"

@interface NoInternetEmptyView ()

@property (nonatomic, strong) EmptyView *emptyView;

@end

@implementation NoInternetEmptyView

- (EmptyView *)emptyView
{
    if (!_emptyView) {
        _emptyView = [[EmptyView alloc] initWithFrame:self.bounds];
    }
    return _emptyView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.emptyView];
    }
    return self;
}

- (void)setNoInternetEmptyViewType:(EmptyViewType)noInternetEmptyViewType
{
    _noInternetEmptyViewType = noInternetEmptyViewType;
    if (noInternetEmptyViewType == EmptyViewTypeNoButton) {
        
        self.emptyView.emptyImage = [UIImage imageNamed:@"NoInternet_empty_icon"];
        self.emptyView.emptyString = @"网络请求失败";
        self.emptyView.emptyDetailString = @"请检查您的网络\n下拉刷新加载";

    } else if (noInternetEmptyViewType == EmptyViewTypeHasButton){
        self.emptyView.emptyImage = [UIImage imageNamed:@"NoInternet_empty_icon"];
        self.emptyView.emptyString = @"网络请求失败";
        self.emptyView.emptyDetailString = @"请检查您的网络\n重新加载吧";
        self.emptyView.emptyButtonTitle = @"重新加载";
        if (self.emptyButtonIsSelect) {
            self.emptyView.emptyButtonIsSelect = self.emptyButtonIsSelect;
        }
    }
    self.emptyView.emptyViewType = noInternetEmptyViewType;
}

- (void)setEmptyButtonIsSelect:(void (^)(BOOL))emptyButtonIsSelect
{
    if (_emptyButtonIsSelect != emptyButtonIsSelect) {
        _emptyButtonIsSelect = emptyButtonIsSelect;
        if (self.emptyButtonIsSelect) {
            self.emptyView.emptyButtonIsSelect = emptyButtonIsSelect;
        }
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
