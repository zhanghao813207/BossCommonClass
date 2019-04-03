//
//  RecommendedVC.m
//  AFNetworking
//
//  Created by admin on 2019/3/27.
//

#import "RecommendedVC.h"
#import "InputMessageVC.h"
#import "BossBasicDefine.h"
#import "Masonry.h"
#import "MyRecommendationVC.h"
#import "JYCMethodDefine.h"

@interface RecommendedVC ()
@property(nonatomic, strong)UIButton *button;
@end

@implementation RecommendedVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"推荐员工";
    [self button];
    [self setRightItem];
}



- (void)setRightItem {
    
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightButton setTitle:@"我的推荐" forState:UIControlStateNormal];
    [rightButton setTitleColor:kHexRGB(0x1173E4) forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(rightAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
}

- (void)rightAction {
    MyRecommendationVC *vc = [[MyRecommendationVC alloc] init];
    
    [self.navigationController pushViewController:vc animated:YES];
}

- (UIButton *)button {
    if (_button == nil) {
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        [_button setTitle:@"我要推荐" forState:UIControlStateNormal];
        _button.layer.cornerRadius = 3;
        _button.layer.masksToBounds = true;
        _button.backgroundColor = kHexRGB(0x1173E4);
        _button.titleLabel.font = [UIFont systemFontOfSize:16];
        [_button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_button];
        [_button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.view).offset(-20);
            make.left.equalTo(self.view).offset(20);
            make.right.equalTo(self.view).offset(-20);
            make.height.equalTo(@44);
        }];
    }
    return _button;
}
- (void)buttonAction {
    InputMessageVC *vc = [[InputMessageVC alloc] init];
    vc.isDetail = false;
    [self.navigationController pushViewController:vc animated:true];
}
@end

