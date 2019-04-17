
//
//  EntryVC.m
//  AFNetworking
//
//  Created by admin on 2019/3/26.
//

#import "EntryVC.h"
#import "Masonry.h"
#import "RecommendedView.h"
#import "RecommendedModel.h"
#import "InputMessageVC.h"
#import "ReferralFeeRequest.h"

@interface EntryVC ()<RecommendedViewDelegate>

@property(nonatomic, strong)RecommendedView *recommendView;

@property(nonatomic, strong)NSMutableArray *dataArrM;
@property(nonatomic, assign)NSInteger requestPage;
@property(nonatomic, assign)NSInteger currentPage;

/**
 判断能不能上拉
 */
@property(nonatomic, assign)BOOL hasMore;
@end

@implementation EntryVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.requestPage = 0;
    self.currentPage = 1;
    [self recommendView];
    self.dataArrM = [NSMutableArray array];
    [self getData];
}
/**
 下拉刷新
 */
- (void)update {
    [self.recommendView headerFresh];
    [self getData];
}


- (void)getMore {

    self.requestPage = self.currentPage + 1;
   
    [ReferralFeeRequest recommendList:100 currentPage:self.requestPage success:^(NSArray * _Nonnull listModel) {
        self.currentPage = self.requestPage;
        //        [self.dataArrM addObjectsFromArray:listModel];
        [self.dataArrM addObjectsFromArray:listModel];
        self.recommendView.dataArr = self.dataArrM;
    } meta:^(id  _Nonnull meta) {
        self.recommendView.isHasmore = [meta[@"has_more"] boolValue];
    } fail:^{
        
    }];
}
- (void)getData {
    [ReferralFeeRequest recommendList:100 currentPage:1 success:^(NSArray * _Nonnull listModel) {
        self.currentPage = 1;
        self.dataArrM = listModel.mutableCopy;
        self.recommendView.dataArr = self.dataArrM;
        
    } meta:^(id  _Nonnull meta) {
        NSInteger count = [meta[@"result_count"] integerValue];
        [self.recommendView noDataViewCount:count];
        self.recommendView.isHasmore = [meta[@"has_more"] boolValue];
    } fail:^{
        
    }];
}

////RecommendedViewDelegate
- (void)didSelectModel:(RecommendedModel *)model {
    InputMessageVC *vc = [[InputMessageVC alloc] init];
    vc.isDetail = true;
    vc.listModel = model;
    vc.index = 2;
    vc.isEntry = true;
    [self.navigationController pushViewController:vc animated:true];
}
- (RecommendedView *)recommendView {
    if (_recommendView == nil) {
        _recommendView = [[RecommendedView alloc] init];
        _recommendView.isEditing = self.isEditing;
        _recommendView.delegate = self;
        _recommendView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:_recommendView];
        [_recommendView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(self.view);
            if (self.editing) {
                make.bottom.equalTo(self.view).offset(0);
            }else {
                make.bottom.equalTo(self.view).offset(-64);
            }
        }];
    }
    return _recommendView;
}

@end
