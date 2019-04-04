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
@end

@implementation WaitRecommendVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"待推荐";
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

- (void)getData {

    [ReferralFeeRequest recommendList:1 currentPage:1 success:^(NSArray * _Nonnull listModel) {
        self.dataArrM = listModel.mutableCopy;
        self.recommendView.dataArr = self.dataArrM;
    } fail:^{

    }];
}

/**
 下拉刷新
 */
NSInteger page = 1;
- (void)refresh {
    page ++;
    [ReferralFeeRequest recommendList:1 currentPage:page success:^(NSArray * _Nonnull listModel) {
//        [self.dataArrM addObjectsFromArray:listModel];
        for (RecommendedModel *model in listModel) {
            [self.dataArrM insertObject:model atIndex:0];
        }

//        self.dataArrM = listModel.mutableCopy;
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
