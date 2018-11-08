//
//  JYCContentView.m
//  NNBarKnight
//
//  Created by 贾远潮 on 2017/9/21.
//  Copyright © 2017年 贾远潮. All rights reserved.
//

#import "JYCContentView.h"
#import "JYCTitleView.h"
#import "UICollectionView+ScrollEdge.h"
#define kContentCellID  @"kContentCellID"

@interface JYCContentView ()<UICollectionViewDelegate,UICollectionViewDataSource,JYCTitleViewDelegate,UIGestureRecognizerDelegate>

@property (nonatomic, strong) NSArray *childVCs;

@property (nonatomic, strong) UIViewController *parentVC;

@property (nonatomic, strong) UICollectionView *contenCV;

@property (nonatomic, assign, readonly) NSInteger currentIndex;

@end

@implementation JYCContentView

- (instancetype)initWithFrame:(CGRect)frame childVCs:(NSArray<UIViewController *> *)childVCs parentVC:(UIViewController *)parentVC
{
    if (self = [super initWithFrame:frame]) {
        self.childVCs = childVCs;
        self.parentVC = parentVC;
        for (UIViewController *vc in childVCs) {
            [self.parentVC addChildViewController:vc];
        }
        [self setUI];
    }
    return self;
}

- (void)setUI
{
    [self addSubview:self.contenCV];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.childVCs.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kContentCellID forIndexPath:indexPath];
    [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    UIViewController *vc = self.childVCs[indexPath.row];
    vc.view.frame = cell.contentView.bounds;
    [cell.contentView addSubview:vc.view];

    
//    UILabel *label = [[UILabel alloc] initWithFrame:cell.contentView.bounds];
//    label.text = [NSString stringWithFormat:@"%ld",indexPath.row];
//    label.textAlignment = NSTextAlignmentCenter;
//    label.font = NNBBlodFont(30);
//    [cell.contentView addSubview:label];

    return cell;
}

- (void)scrollToIndex:(NSInteger)index
{
    if (self.currentIndex != index) {
        [self.contenCV setContentOffset:CGPointMake(index * self.bounds.size.width, 0) animated:YES];
    }
}

#pragma mark -- scrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(JYCContentView:scrollToIndex:)]) {
        [self.delegate JYCContentView:self scrollToIndex:self.currentIndex];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (!decelerate) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(JYCContentView:scrollToIndex:)]) {
            [self.delegate JYCContentView:self scrollToIndex:self.currentIndex];
        }
    }
}

#pragma mark --lazyProperty

- (UICollectionView *)contenCV
{
    if (!_contenCV) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = self.bounds.size;
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        _contenCV = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
        _contenCV.dataSource = self;
        _contenCV.delegate = self;
        _contenCV.pagingEnabled = YES;
        _contenCV.bounces = NO;
        [_contenCV registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:kContentCellID];
        _contenCV.showsHorizontalScrollIndicator = NO;
    }
    return _contenCV;
}

- (NSInteger)currentIndex
{
    return self.contenCV.contentOffset.x / self.bounds.size.width;
}

@end
