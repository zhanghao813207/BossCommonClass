
//
//  MyRecommendationVC.m
//  AFNetworking
//
//  Created by admin on 2019/3/26.
//

#import "MyRecommendationVC.h"
#import "SGPagingView.h"
#import "WaitRecommendVC.h"
#import "FinishRecommendVC.h"
#import "EntryVC.h"
#import "JYCMethodDefine.h"
#import "EditRecommendVC.h"

typedef NS_ENUM(NSInteger, SubVCType) {
    SubVCTypeWait,
    SubVCTypeFinish,
    SubVCTypeEntry
};

@interface MyRecommendationVC ()<SGPageTitleViewDelegate, SGPageContentCollectionViewDelegate,WaitRecommendVCDelgate,FinishRecommendVCDelegate>
@property (nonatomic, strong) SGPageTitleView *pageTitleView;
@property (nonatomic, strong) SGPageContentCollectionView *pageContentCollectionView;
@property(nonatomic, strong)WaitRecommendVC *waitVc;
@property(nonatomic, strong)FinishRecommendVC *finishVC;
@property(nonatomic, strong)EntryVC *entryVC;
/**
 记录当前所在的控制器
 */
@property(nonatomic, assign)SubVCType VCType;
@end

@implementation MyRecommendationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"我的推荐";
    [self setupPageView];
    [self setRightItem];
   
}

- (void)setRightItem {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"编辑" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    [button setTitleColor:kHexRGB(0x1173E4) forState:UIControlStateNormal];
    [button addTarget:self action:@selector(rightAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
}
- (void)waitRecommendVCfailIds:(NSArray *)ids {
    NSLog(@"%@",ids);
    [self.waitVc updateWithIds:ids];
}
- (void)deletAll:(NSArray *)ids {
    [self.waitVc updateWithIds:ids];
}
- (void)deleteModel {
    [self.finishVC update];
}
- (void)rightAction {
    switch (self.VCType) {
        case SubVCTypeWait: {
            WaitRecommendVC *vc = [[WaitRecommendVC alloc] init];
            vc.isEditing = true;
            vc.delegate = self;
            [self.navigationController pushViewController:vc animated:true];
        }
            break;
        case SubVCTypeFinish: {
            FinishRecommendVC *vc = [[FinishRecommendVC alloc] init];
            vc.delegate = self;
            vc.isFinish = true;
            vc.isEditing = true;
            [self.navigationController pushViewController:vc animated:true];
        }
            break;
        case SubVCTypeEntry:{
            EntryVC *vc = [[EntryVC alloc] init];
            vc.isEditing = true;
            [self.navigationController pushViewController:vc animated:true];
        }
            break;
        default:
            break;
    }
}

- (void)setupPageView {
    self.VCType = SubVCTypeWait;
//    CGFloat statusHeight = CGRectGetHeight([UIApplication sharedApplication].statusBarFrame);
    CGFloat pageTitleViewY = 0;

    
    NSArray *titleArr = @[@"待推荐", @"已推荐", @"已入职"];
    SGPageTitleViewConfigure *configure = [SGPageTitleViewConfigure pageTitleViewConfigure];
    configure.indicatorStyle = SGIndicatorStyleDefault;
    configure.titleAdditionalWidth = 35;
    
    /// pageTitleView
    self.pageTitleView = [SGPageTitleView pageTitleViewWithFrame:CGRectMake(0, pageTitleViewY, self.view.frame.size.width, 44) delegate:self titleNames:titleArr configure:configure];
//    #007AFF
    
    [self.pageTitleView resetIndicatorColor:kHexRGB(0x007AFF)];
    [self.pageTitleView resetTitleColor:kHexRGBA(0x050505, 0.3) titleSelectedColor:kHexRGB(0x007AFF)];
    self.pageTitleView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_pageTitleView];
    
    self.waitVc = [[WaitRecommendVC alloc] init];
    self.waitVc .isEditing = false;
    self.finishVC = [[FinishRecommendVC alloc] init];
    self.finishVC.isEditing = false;
    self.entryVC = [[EntryVC alloc] init];
    self.entryVC.isEditing = false;
    
 
    NSArray *childArr = @[self.waitVc, self.finishVC, self.entryVC];
    /// pageContentCollectionView
    CGFloat ContentCollectionViewHeight = self.view.frame.size.height - CGRectGetMaxY(_pageTitleView.frame);
    self.pageContentCollectionView = [[SGPageContentCollectionView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_pageTitleView.frame), self.view.frame.size.width, ContentCollectionViewHeight) parentVC:self childVCs:childArr];
    /////是否需要滑动
    self.pageContentCollectionView.isScrollEnabled = false;
    _pageContentCollectionView.delegatePageContentCollectionView = self;
    [self.view addSubview:_pageContentCollectionView];
}

- (void)pageTitleView:(SGPageTitleView *)pageTitleView selectedIndex:(NSInteger)selectedIndex {
    
    self.VCType = selectedIndex;
    if (selectedIndex == 0) {
        [self setRightItem];
        [self.waitVc refresh];
    }else if (selectedIndex == 1) {
        [self setRightItem];
        [self.finishVC update];
    }else {
        [self.entryVC update];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:[UIView new]];
    }
    
    
    
    [self.pageContentCollectionView setPageContentCollectionViewCurrentIndex:selectedIndex];
}
- (void)pageContentScrollView:(SGPageContentScrollView *)pageContentScrollView index:(NSInteger)index {
    if (index == 0) {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    } else {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
}
- (void)pageContentCollectionView:(SGPageContentCollectionView *)pageContentCollectionView progress:(CGFloat)progress originalIndex:(NSInteger)originalIndex targetIndex:(NSInteger)targetIndex {
    self.VCType = targetIndex;
    [self.pageTitleView setPageTitleViewWithProgress:progress originalIndex:originalIndex targetIndex:targetIndex];
}





@end
