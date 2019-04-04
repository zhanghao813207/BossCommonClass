
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

@end

@implementation EntryVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self recommendView];
    //    NSMutableArray *tempArr = [NSMutableArray array];
    //    for (NSInteger i = 0; i < 60; i ++) {
    //        RecommendedModel *model = [[RecommendedModel alloc] init];
    //        model.isEditing = self.isEditing;
    //        model.isSelected = false;
    //        model.testStr = [NSString stringWithFormat:@"%ld",(long)i];
    //        [tempArr addObject:model];
    //    }
    //    self.recommendView.dataArr = tempArr;
    self.dataArrM = [NSMutableArray array];
    [self getData];
}
/**
 下拉刷新
 */
NSInteger finishpage = 1;
- (void)refresh {
    finishpage ++;
    [ReferralFeeRequest recommendList:1 currentPage:finishpage success:^(NSArray * _Nonnull listModel) {
        //        [self.dataArrM addObjectsFromArray:listModel];
        for (RecommendedModel *model in listModel) {
            [self.dataArrM insertObject:model atIndex:0];
        }

        //        self.dataArrM = listModel.mutableCopy;
        self.recommendView.dataArr = self.dataArrM;
    } fail:^{

    }];
}
- (void)getData {
    [ReferralFeeRequest recommendList:100 currentPage:1 success:^(NSArray * _Nonnull listModel) {
        self.dataArrM = listModel.mutableCopy;
        self.recommendView.dataArr = self.dataArrM;
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
