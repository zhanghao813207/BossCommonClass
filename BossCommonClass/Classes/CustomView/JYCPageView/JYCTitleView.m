//
//  JYCTitleView.m
//  NNBarKnight
//
//  Created by 贾远潮 on 2017/9/20
//

#import "JYCTitleView.h"
#import "JYCContentView.h"
#import "BossBasicDefine.h"

@interface JYCTitleView ()
{
    NSInteger currentSelect;
}

@property (nonatomic, strong) NSArray *titles;

@property (nonatomic, strong) JYCPageStyle *pageStyle;

@property (nonatomic, strong) UIScrollView *titleSV;

@property (nonatomic, strong) UIView *line;

@property (nonatomic, strong) NSMutableArray *titleLabelArray;

@end

@implementation JYCTitleView

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray <NSString *>*)titles pageStyle:(JYCPageStyle *)pageStyle
{
    if (self = [super initWithFrame:frame]) {
        self.titles = titles;
        self.pageStyle = pageStyle;
        currentSelect = 0;
        self.translatesAutoresizingMaskIntoConstraints = YES;
        [self setUI];
    }
    return self;
}

- (void)setUI
{
    self.backgroundColor = [UIColor whiteColor];
    self.height = 40;
    [self addSubview:self.titleSV];
    [self setLabel];
    [self setLabelFrame];
    [self.titleSV addSubview:self.line];
}

- (void)updateTitle:(NSString *)string index:(NSInteger)index
{
    if (index < self.titles.count) {
        UILabel *titleLabel = self.titleLabelArray[index];
        titleLabel.text = string;
    }
}

- (void)setLabel
{
    if (self.titles.count < 1) {
        return;
    }
    for (NSInteger i = 0; i < self.titles.count; i++) {
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.text = self.titles[i];
        titleLabel.textColor = i == 0 ? self.pageStyle.selectColor : self.pageStyle.normalColor;
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.font = self.pageStyle.titleFont;
        titleLabel.tag = i;
        [titleLabel sizeToFit];
        [self.titleSV addSubview:titleLabel];
        [self.titleLabelArray addObject:titleLabel];
        UITapGestureRecognizer  *tapGR  = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGRAction:)];
        titleLabel.userInteractionEnabled = YES;
        [titleLabel addGestureRecognizer:tapGR];

    }

}

- (void)setLabelFrame
{
    if (self.titles.count < 1) {
        return;
    }
    NSInteger titleCount = self.titleLabelArray.count;
    for (NSInteger i = 0; i < titleCount; i++) {
        UILabel *titleLabel = self.titleLabelArray[i];
        CGFloat labX = 0;
        CGFloat labY = 0;
        CGFloat labW = titleLabel.bounds.size.width;
        CGFloat labH = 40;
        
        if (self.pageStyle.titleIsRoll) {
            labX = i == 0 ? 0.5 * self.pageStyle.titleSpace : CGRectGetMaxX([(UILabel *)(self.titleLabelArray[i - 1]) frame]) + self.pageStyle.titleSpace;
        } else {
            labW = self.bounds.size.width / (titleCount * 1.0);
            labX = i * labW;
        }
        titleLabel.frame = CGRectMake(labX, labY, labW, labH);
    }
    if (self.pageStyle.titleIsRoll) {
        self.titleSV.contentSize = CGSizeMake(CGRectGetMaxX([(UILabel *)(self.titleLabelArray.lastObject) frame]) + self.pageStyle.titleSpace * 0.5, 40);
    }
}

- (void)tapGRAction:(UITapGestureRecognizer *)sender
{
    UILabel *label = (UILabel *)sender.view;
    if (![label isKindOfClass:[UILabel class]]) {
        return;
    }
    [self selectTitleWithIndex:label.tag];
}

- (BOOL)selectTitleWithIndex:(NSInteger)index
{
    if (currentSelect == index) {
        return NO;
    }
    
    UILabel *lastLabel = self.titleLabelArray[currentSelect];
    lastLabel.textColor = self.pageStyle.normalColor;
    
    UILabel *label = self.titleLabelArray[index];
    
    label.textColor = self.pageStyle.selectColor;
    
    currentSelect = label.tag;
    
    [UIView animateWithDuration:0.5f animations:^{
        if (self.pageStyle.titleIsRoll) {
            self.line.x = label.x;
            self.line.width = label.width;
        } else {
            self.line.x = label.x + (self.width / self.titles.count - (label.font.pointSize * label.text.length + 20)) / 2.0;
            self.line.width = label.font.pointSize * label.text.length + 20;
        }
    }];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(JYCTitleView:DidSelectIndex:)]) {
        [self.delegate JYCTitleView:self DidSelectIndex:currentSelect];
    }
    
    [self selectLabelToCenter:label];
    return YES;
    
}

- (void)selectLabelToCenter:(UILabel *)label
{
    if (!self.pageStyle.titleIsRoll) {
        return;
    }
    
    CGFloat contentOffsetX = label.center.x - self.bounds.size.width * 0.5;
    if (contentOffsetX < 0) {
        contentOffsetX = 0;
    }
    
    if (contentOffsetX > self.titleSV.contentSize.width - self.bounds.size.width) {
        contentOffsetX = self.titleSV.contentSize.width - self.bounds.size.width;
    }
    CGPoint point = CGPointMake(contentOffsetX, 0);
    [self.titleSV setContentOffset:point animated:YES];

}


#pragma mark --LazyProperty
- (UIScrollView *)titleSV
{
    if (!_titleSV) {
        _titleSV = [[UIScrollView alloc] initWithFrame:self.bounds];
        _titleSV.showsHorizontalScrollIndicator = NO;
        _titleSV.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _titleSV;
}

- (NSMutableArray *)titleLabelArray
{
    if (!_titleLabelArray) {
        _titleLabelArray = [NSMutableArray array];
    }
    return _titleLabelArray;
}

- (UIView *)line
{
    if (!_line) {
        UILabel *label;
        if (self.titleLabelArray.count > 0) {
            label = self.titleLabelArray[0];
        }
        if (self.pageStyle.titleIsRoll) {
            _line = [[UIView alloc] initWithFrame:CGRectMake(self.pageStyle.titleSpace * 0.5, self.height - 2,label ? label.width : self.width / self.titles.count, 2)];
        } else {
            _line = [[UIView alloc] initWithFrame:CGRectMake((self.width / self.titles.count - (label.font.pointSize * label.text.length + 20)) / 2.0, self.height - 2,label?label.font.pointSize * label.text.length + 20 : self.width / self.titles.count, 2)];
        }
        _line.backgroundColor = self.pageStyle.selectColor;
    }
    return _line;
}

@end
