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

@end

@implementation FinishRecommendVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor purpleColor];
    [self recommendView];
    self.dataArrM = [NSMutableArray array];
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
    [self getData];
}
- (void)getData {
    [ReferralFeeRequest recommendList:10 currentPage:1 success:^(NSArray * _Nonnull listModel) {
        self.dataArrM = listModel.mutableCopy;
        self.recommendView.dataArr = self.dataArrM;
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

NSInteger cpage = 1;
- (void)refresh {
    cpage ++;
    [ReferralFeeRequest recommendList:10 currentPage:cpage success:^(NSArray * _Nonnull listModel) {
//        self.dataArrM = listModel.mutableCopy;
        for (RecommendedModel *model in listModel) {
            [self.dataArrM insertObject:model atIndex:0];
        }
        self.recommendView.dataArr = self.dataArrM;
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
