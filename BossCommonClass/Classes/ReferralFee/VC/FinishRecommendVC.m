//
//  FinishRecommendVC.m
//  AFNetworking
//
//  Created by admin on 2019/3/26.
//

#import "FinishRecommendVC.h"
#import "Masonry.h"
#import "RecommendedView.h"
#import "RecommendedModel.h"
#import "InputMessageVC.h"
#import "ReferralFeeRequest.h"
#import "JYCMethodDefine.h"


@interface FinishRecommendVC ()<RecommendedViewDelegate>

@property(nonatomic, strong)RecommendedView *recommendView;

@property(nonatomic, strong)NSMutableArray *dataArrM;


@property(nonatomic, assign)NSInteger requestPage;
@property(nonatomic, assign)NSInteger currentPage;
/**
 判断能不能上拉
 */
@property(nonatomic, assign)BOOL hasMore;
@end

@implementation FinishRecommendVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor purpleColor];
    [self recommendView];
    self.dataArrM = [NSMutableArray array];
    self.requestPage = 0;
    self.currentPage = 1;
    [self getData];
    self.title = @"已推荐";
    if (self.isEditing) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:@"取消" forState:UIControlStateNormal];
        [button setTitleColor:kHexRGB(0x1173E4) forState:UIControlStateNormal];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:[UIView new]];
    }
}
- (void)cancel {
    [self.navigationController popViewControllerAnimated:true];
}

- (void)update {
    [self.recommendView headerFresh];
    [self getData];
}
////RecommendedViewDelegate
- (void)didSelectModel:(RecommendedModel *)model {

    if (self.isEditing) {
        return;
    }
    InputMessageVC *vc = [[InputMessageVC alloc] init];
    vc.isDetail = true;
    vc.listModel = model;
    vc.index = 1;
    [self.navigationController pushViewController:vc animated:true];
}

- (void)deleteAll:(nonnull NSArray *)modelArr {
    NSMutableArray *tempArr = [NSMutableArray array];
    for (RecommendedModel *model in modelArr) {
        [tempArr addObject:model._id];
    }
    [ReferralFeeRequest deleteRecommend:tempArr success:^{
        if (self.delegate && [self.delegate respondsToSelector:@selector(deleteModel)]) {
            [self.delegate deleteModel];
        }
        [self.navigationController popViewControllerAnimated:true];
    } fail:^{
        
    }];
}

- (void)refresh {
    [self getData];
}

- (void)getData {
    [ReferralFeeRequest recommendList:10 currentPage:1 success:^(NSArray * _Nonnull listModel) {
        self.dataArrM = listModel.mutableCopy;
        self.recommendView.dataArr = self.dataArrM;
        self.currentPage = 1;
    } meta:^(id  _Nonnull meta) {
        BOOL hasMore = [meta[@"has_more"] boolValue];
        self.hasMore = hasMore;
    } fail:^{
        
    }];
}

- (void)getMore {
    if (self.hasMore == false) {
        [self.recommendView noDataView];
        return;
    }
    self.requestPage = self.currentPage + 1;
    [ReferralFeeRequest recommendList:10 currentPage:self.requestPage success:^(NSArray * _Nonnull listModel) {
        self.currentPage = self.requestPage;
        [self.dataArrM addObjectsFromArray:listModel];
        self.recommendView.dataArr = self.dataArrM;
    } meta:^(id  _Nonnull meta) {
        
    } fail:^{
        
    }];
}


- (void)submitAll:(nonnull NSArray *)modelArr {
//    [ReferralFeeRequest submitArrs:modelArr success:^(NSArray * _Nonnull sucessarr) {
//        [self.navigationController popViewControllerAnimated:true];
//    } fail:^(NSArray * _Nonnull failArr) {
//
//    }];
}

- (RecommendedView *)recommendView {
    if (_recommendView == nil) {
        _recommendView = [[RecommendedView alloc] init];
        _recommendView.isEditing = self.isEditing;
        _recommendView.delegate = self;
        _recommendView.isFinish = self.isFinish;
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
