//
//  NNBAlertView.m
//  NNBarKnight
//
//  Created by 贾远潮 on 2017/10/9.
//

#import "NNBAlertView.h"
#import "JYCAlertView.h"
#import "BossBasicDefine.h"
@interface NNBAlertView()<JYCAlertViewDatasource>

@property (nonatomic, strong) JYCAlertView *alertView;

@property (nonatomic, assign) NNBAlertViewType alertType;

@property (nonatomic, strong) UIView *alertContentView;

@property (nonatomic, assign) BOOL isPickUp;

@end

@implementation NNBAlertView

- (instancetype)initWithFrame:(CGRect)frame AlertType:(NNBAlertViewType)alertType pickup:(BOOL)isPickUp
{
    if (self = [super initWithFrame:frame]) {
        self.alertType = alertType;
        self.isPickUp = isPickUp;
        [self addSubview:self.alertView];
    }
    return self;
}

- (void)refreshButtonAction:(UIButton *)sender
{
    DLog(@"点击了刷新查看");
    if (self.refreshBlock) {
        self.refreshBlock();
    }
}

- (void)countingButtonAction:(UIButton *)sender
{
    DLog(@"点击了开始清点");
    if (self.countingBlock) {
        self.countingBlock();
    }
}

- (void)signButtonAction:(UIButton *)sender
{
    DLog(@"点击了签字确认");
    if (self.signBlock) {
        self.signBlock();
    }
}

#pragma mark -- view的展示取消
- (void)show
{
   [self.alertView showJYCAlertView];
}

- (void)dismissWithCompletion:(void(^)(BOOL complete))completionBlcok
{
    [self.alertView dismissJYCAlertViewWithCompletion:^(BOOL finish) {
        [self removeFromSuperview];
        self.alertView = nil;
        if (completionBlcok) {
            completionBlcok(finish);
        }
    }];
}

#pragma makr -- lazy property

- (UIView *)JYCAlertView:(JYCAlertView *)alertView
{
    return self.alertContentView;
}

- (JYCAlertView *)alertView
{
    if (!_alertView) {
        _alertView = [[JYCAlertView alloc] initWithFrame:self.bounds];
        _alertView.datasource = self;
    }
    return _alertView;

}

- (UIView *)alertContentView
{
    if (!_alertContentView) {
        switch (self.alertType) {
            case NNBAlertViewTypeWaitAudit:
            {
                UIView *BGView = [[UIView alloc] initWithFrame:CGRectMake((self.width - 300) / 2.0, (self.height - 154) / 2.0, 300, 154)];
                BGView.layer.cornerRadius = 2.f;
                BGView.layer.masksToBounds = YES;
                BGView.backgroundColor = [UIColor whiteColor];
                _alertContentView = BGView;
                
                UILabel *dontLeaveLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 30, BGView.width, 30)];
                dontLeaveLabel.text = @"请不要离开微仓";
                dontLeaveLabel.textColor = kHexRGB(0xFF000A);
                dontLeaveLabel.font = BossBlodFont(30);
                dontLeaveLabel.textAlignment = NSTextAlignmentCenter;
                [BGView addSubview:dontLeaveLabel];
                
                UILabel *waitLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(dontLeaveLabel.frame) + 10, BGView.width, 22)];
                if (self.isPickUp) {
                    waitLabel.text = @"等待微仓审核确认";
                } else {
                    waitLabel.text = @"请等候...";
                }
                waitLabel.textColor = kHexRGBA(0x000000, 0.6);
                waitLabel.font = BossRegularFont(16);
                waitLabel.textAlignment = NSTextAlignmentCenter;
                [BGView addSubview:waitLabel];

                UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 112, BGView.width, 1)];
                line.backgroundColor = kHexRGB(0xE5E5E5);
                [BGView addSubview:line];
                
                UIButton *refreshButton = [UIButton buttonWithType:UIButtonTypeSystem];
                refreshButton.frame = CGRectMake(0, 113, BGView.width, 41);
                [refreshButton setTitle:@"刷新查看" forState:UIControlStateNormal];
                [refreshButton setTitleColor:kHexRGB(0xFF6000) forState:UIControlStateNormal];
                refreshButton.titleLabel.font = BossBlodFont(14.f);
                [refreshButton addTarget:self action:@selector(refreshButtonAction:) forControlEvents:UIControlEventTouchUpInside];
                [BGView addSubview:refreshButton];
                break;
            }
            case NNBAlertViewTypeThrough:
            {
                if (self.isPickUp) {
                    UIView *BGView = [[UIView alloc] initWithFrame:CGRectMake((self.width - 300) / 2.0, (self.height - 122) / 2.0, 300, 122)];
                    BGView.layer.cornerRadius = 2.f;
                    BGView.layer.masksToBounds = YES;
                    BGView.backgroundColor = [UIColor whiteColor];
                    _alertContentView = BGView;
                    
                    UILabel *dontLeaveLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 30, BGView.width, 30)];
                    dontLeaveLabel.text = @"微仓已通过";
                    dontLeaveLabel.textColor = kHexRGB(0x67B412);
                    dontLeaveLabel.font = BossBlodFont(30);
                    dontLeaveLabel.textAlignment = NSTextAlignmentCenter;
                    [BGView addSubview:dontLeaveLabel];
                    
                    UILabel *waitLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(dontLeaveLabel.frame) + 10, BGView.width, 22)];
                    waitLabel.text = @"请前往门店";
                    waitLabel.textColor = kHexRGBA(0x000000, 0.6);
                    waitLabel.font = BossRegularFont(16);
                    waitLabel.textAlignment = NSTextAlignmentCenter;
                    [BGView addSubview:waitLabel];
                } else {
                    UIView *BGView = [[UIView alloc] initWithFrame:CGRectMake((self.width - 300) / 2.0, (self.height - 154) / 2.0, 300, 154)];
                    BGView.layer.cornerRadius = 2.f;
                    BGView.layer.masksToBounds = YES;
                    BGView.backgroundColor = [UIColor whiteColor];
                    _alertContentView = BGView;
                    
                    UILabel *dontLeaveLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 30, BGView.width, 30)];
                    dontLeaveLabel.text = @"微仓已清点完退货";
                    dontLeaveLabel.textColor = kHexRGB(0x67B412);
                    dontLeaveLabel.font = BossBlodFont(30);
                    dontLeaveLabel.textAlignment = NSTextAlignmentCenter;
                    [BGView addSubview:dontLeaveLabel];
                    
                    UILabel *waitLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(dontLeaveLabel.frame) + 10, BGView.width, 22)];
                    waitLabel.text = @"请查看并签收";
                    waitLabel.textColor = kHexRGBA(0x000000, 0.6);
                    waitLabel.font = BossRegularFont(16);
                    waitLabel.textAlignment = NSTextAlignmentCenter;
                    [BGView addSubview:waitLabel];
                    
                    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 112, BGView.width, 1)];
                    line.backgroundColor = kHexRGB(0xE5E5E5);
                    [BGView addSubview:line];
                    
                    UIButton *countingButton = [UIButton buttonWithType:UIButtonTypeSystem];
                    countingButton.frame = CGRectMake(0, 113, BGView.width, 41);
                    [countingButton setTitle:@"查看结果并签收" forState:UIControlStateNormal];
                    [countingButton setTitleColor:kHexRGB(0xFF6000) forState:UIControlStateNormal];
                    countingButton.titleLabel.font = BossBlodFont(14.f);
                    [countingButton addTarget:self action:@selector(signButtonAction:) forControlEvents:UIControlEventTouchUpInside];
                    [BGView addSubview:countingButton];
                }

                break;
            }
            case NNBAlertViewTypeReject:
            {
                UIView *BGView = [[UIView alloc] initWithFrame:CGRectMake((self.width - 300) / 2.0, (self.height - 154) / 2.0, 300, 154)];
                BGView.layer.cornerRadius = 2.f;
                BGView.layer.masksToBounds = YES;
                BGView.backgroundColor = [UIColor whiteColor];
                _alertContentView = BGView;
                
                UILabel *dontLeaveLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 30, BGView.width, 30)];
                dontLeaveLabel.text = @"微仓已驳回";
                dontLeaveLabel.textColor = kHexRGB(0xFF000A);
                dontLeaveLabel.font = BossBlodFont(30);
                dontLeaveLabel.textAlignment = NSTextAlignmentCenter;
                [BGView addSubview:dontLeaveLabel];
                
                UILabel *waitLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(dontLeaveLabel.frame) + 10, BGView.width, 22)];
                waitLabel.text = @"请重新清点货品";
                waitLabel.textColor = kHexRGBA(0x000000, 0.6);
                waitLabel.font = BossRegularFont(16);
                waitLabel.textAlignment = NSTextAlignmentCenter;
                [BGView addSubview:waitLabel];
                
                UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 112, BGView.width, 1)];
                line.backgroundColor = kHexRGB(0xE5E5E5);
                [BGView addSubview:line];
                
                UIButton *countingButton = [UIButton buttonWithType:UIButtonTypeSystem];
                countingButton.frame = CGRectMake(0, 113, BGView.width, 41);
                [countingButton setTitle:@"开始清点" forState:UIControlStateNormal];
                [countingButton setTitleColor:kHexRGB(0xFF6000) forState:UIControlStateNormal];
                countingButton.titleLabel.font = BossBlodFont(14.f);
                [countingButton addTarget:self action:@selector(countingButtonAction:) forControlEvents:UIControlEventTouchUpInside];
                [BGView addSubview:countingButton];
                break;
            }
            default:
                break;
        }
    }
    return _alertContentView;
}

@end
