//
//  JYCPageView.m
//  NNBarKnight
//
//  Created by 贾远潮 on 2017/9/20.
//  Copyright © 2017年 贾远潮. All rights reserved.
//

#import "JYCPageView.h"
#import "JYCTitleView.h"
#import "JYCContentView.h"
#import "BossBasicDefine.h"

@interface JYCPageView ()<JYCTitleViewDelegate,JYCContentViewDelegate>

@property (nonatomic, strong) NSArray *titles;

@property (nonatomic, strong) NSArray *childVCs;

@property (nonatomic, strong) UIViewController *parentVC;

@property (nonatomic, strong) JYCPageStyle *pageStyle;

@property (nonatomic, strong) JYCTitleView *titleView;

@property (nonatomic, strong) JYCContentView *contentView;

@end


@implementation JYCPageView

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray<NSString *> *)titles childVCs:(NSArray<UIViewController *> *)childVCs parentVC:(UIViewController *)parentVC pageStyle:(JYCPageStyle *)pageStyle
{
    if (self = [super initWithFrame:frame]) {
        self.titles = titles;
        self.childVCs = childVCs;
        self.parentVC = parentVC;
        self.pageStyle = pageStyle;
        [self setupContentUI];
    }
    return self;
}

- (void)setupContentUI
{
    [self addSubview:self.titleView];
    [self addSubview:self.contentView];
    
    self.titleView.delegate = self;
    self.contentView.delegate = self;
}


- (void)JYCTitleView:(JYCTitleView *)titleView DidSelectIndex:(NSInteger)index
{
    [self.contentView scrollToIndex:index];
    if (self.selectIndexBlock) {
        self.selectIndexBlock(index);
    }
}

- (void)JYCContentView:(JYCContentView *)contentView scrollToIndex:(NSInteger)index
{
    if (![self.titleView selectTitleWithIndex:index]) {
        return;
    }
    if (self.selectIndexBlock) {
        self.selectIndexBlock(index);
    }
}

- (void)updateTitle:(NSString *)string index:(NSInteger)index
{
    [self.titleView updateTitle:string index:index];
}

#pragma mark -- LazyProperty

- (JYCTitleView *)titleView
{
    if (!_titleView) {
        _titleView = [[JYCTitleView alloc] initWithFrame:CGRectMake(0, 0, self.width, 40) titles:self.titles pageStyle:self.pageStyle];
    }
    return _titleView;
}

- (JYCContentView *)contentView
{
    if (!_contentView) {
        _contentView = [[JYCContentView alloc] initWithFrame:CGRectMake(0, 40, self.width, self.height - 40) childVCs:self.childVCs parentVC:self.parentVC];
    }
    return _contentView;
}


@end
