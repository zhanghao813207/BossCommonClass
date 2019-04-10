//
//  WaitRecommendVC.m
//  AFNetworking
//
//  Created by admin on 2019/3/26.
//

#import "WaitRecommendVC.h"
#import "Masonry.h"
#import "RecommendedView.h"
#import "RecommendedModel.h"
#import "InputMessageVC.h"
#import "ReferralFeeRequest.h"
#import "JYCMethodDefine.h"

@interface WaitRecommendVC ()<RecommendedViewDelegate,InputMessageVCDelegate>

@property(nonatomic, strong)RecommendedView *recommendView;

@property(nonatomic, strong)NSMutableArray *dataArrM;

@property(nonatomic, assign)NSInteger requestPage;

@property(nonatomic, assign)NSInteger currentPage;
/**
 判断能不能上拉
 */
@property(nonatomic, assign)BOOL hasMore;
@end

@implementation WaitRecommendVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"待推荐";
    self.requestPage = 0;
    self.currentPage = 1;
    [self recommendView];
    self.dataArrM = [NSMutableArray array];
    [self getData];
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
- (void)updateWithIds:(NSArray *)ids {
    [self getData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.recommendView.isEditing = self.isEditing;
}

/**
 下拉刷新
 */

- (void)refresh {
    [self.recommendView headerFresh];
    [self getData];
}

- (void)getData {
    [ReferralFeeRequest recommendList:1 currentPage:1 success:^(NSArray * _Nonnull listModel) {
        self.currentPage = 1;
        self.dataArrM = listModel.mutableCopy;
        self.recommendView.dataArr = self.dataArrM;
    } meta:^(id  _Nonnull meta) {
        NSLog(@"%@",meta);
        NSInteger count = [meta[@"result_count"] integerValue];
        [self.recommendView noDataViewCount:count];
        self.recommendView.isHasmore = [meta[@"has_more"] boolValue];
    } fail:^{
        
    }];
}

- (void)getMore {
  
    self.requestPage = self.currentPage + 1;
    [ReferralFeeRequest recommendList:1 currentPage:self.requestPage success:^(NSArray * _Nonnull listModel) {
        self.currentPage = self.requestPage;
        //        [self.dataArrM addObjectsFromArray:listModel];
        [self.dataArrM addObjectsFromArray:listModel];
        self.recommendView.dataArr = self.dataArrM;
        
    } meta:^(id  _Nonnull meta) {
        self.recommendView.isHasmore = [meta[@"has_more"] boolValue];
    } fail:^{
        
    }];
}

////RecommendedViewDelegate
- (void)didSelectModel:(RecommendedModel *)model {
    if (self.isEditing) {
        return;
    }
    InputMessageVC *vc = [[InputMessageVC alloc] init];
    vc.isDetail = true;
    vc.listModel = model;
    vc.index = 0;
    vc.delegate = self;
    [self.navigationController pushViewController:vc animated:true];
}
//InputMessageVCDelegate
- (void)InputMessageVCTypeStr:(NSString *)typeStr {
    [self getData];
}

/**
 提交全部
 */
- (void)submitAll:(NSArray *)modelArr {
    [ReferralFeeRequest submitArrs:modelArr success:^(NSArray * _Nonnull sucessarr) {
        NSLog(@"%@",sucessarr);
        if (self.delegate && [self.delegate respondsToSelector:@selector(waitRecommendVCfailIds:)]) {
            [self.delegate waitRecommendVCfailIds:sucessarr];
        }
        [self.navigationController popViewControllerAnimated:true];
    } fail:^(NSArray * _Nonnull failArr) {
        NSLog(@"%@",failArr);
    }];
}

- (void)deleteAll:(NSArray *)modelArr {
    NSMutableArray *ids = [NSMutableArray array];
    for (RecommendedModel *model in modelArr) {
        [ids addObject:model._id];
    }
    [ReferralFeeRequest deleteRecommend:ids success:^{
        if (self.delegate) {
            [self.delegate deletAll:ids];
        }
        [self.navigationController popViewControllerAnimated:true];
    } fail:^{
        
    }];
}
- (RecommendedView *)recommendView {
    if (_recommendView == nil) {
        _recommendView = [[RecommendedView alloc] init];
        _recommendView.isEditing = self.isEditing;
        _recommendView.isWait = true;
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
