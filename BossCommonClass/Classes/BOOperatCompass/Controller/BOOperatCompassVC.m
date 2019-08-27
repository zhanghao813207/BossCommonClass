//
//  BOOperatCompassVC.m
//  BossKnight
//
//  Created by admin on 2019/7/19.
//  Copyright © 2019 贾远潮. All rights reserved.
//
#import <WebKit/WebKit.h>
#import "BOOperatCompassVC.h"
#import "BOSelectTimeView.h"
#import "BOOpenSelectTimeView.h"
#import "NNBBasicRequest.h"
#import "BossBasicDefine.h"
#import "TeamListModel.h"
#import "BOOpenSelectbusinessDistrictView.h"
@interface BOOperatCompassVC ()<WKUIDelegate,WKNavigationDelegate>

@property(nonatomic, strong) BOSelectTimeView *selectedTimeView;
@property(nonatomic, strong) WKWebView *webView;

@property(nonatomic, strong) BOOpenSelectTimeView *openSelectView;

@property(nonatomic, strong) BOOpenSelectbusinessDistrictView *districtSelectView;

@property(nonatomic, copy) NSString *baseUrl;

@property (nonatomic,strong)NSString *currentYear;
@property (nonatomic,strong)NSString *currentMouth;
@property (nonatomic,strong)NSString *currentBizDistrictId;
@property (nonatomic,strong)NSString *currentBizDistrictName;



@end

@implementation BOOperatCompassVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setLeftItem];
    __weak typeof(self) weakSelf = self;
    //    NSLog(self.teamList);
    self.selectedTimeView = [[BOSelectTimeView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 44)];
    
    NSCalendar *calendar = [[NSCalendar alloc]
                            initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth;
    NSDateComponents *comp = [calendar components: unitFlags fromDate:[NSDate date]];
    NSString *cmdString = @"jump_to_datahub.jump_to_datahub.jump";
#ifdef kBossKnight
    // 骑士
    NSDictionary *dict = @{@"team_account_map_id":self.teamId,@"domain":@"worker-kanban"};
#elif defined kBossOwner
    // 老板
    NSDictionary *dict = @{@"merchant_id":self.teamId,@"domain":@"owner-app-center"};
    NSString *firstDistrictId;
    if (self.teamList.count > 0){
        TeamListModel *list  = self.teamList[0];
        firstDistrictId = list.biz_district_id;
        self.currentBizDistrictName = list.bizDistrictName;
    }
    [self.selectedTimeView setupDefault:self.currentBizDistrictName];
#else
    cmdString = @"jump_to_datahub.jump_to_datahub.jump";
    // 之家
    NSDictionary *dict = @{@"domain":@"private-app-center"};
#endif
    
    
    [NNBBasicRequest postJsonWithUrl:kUrl parameters:dict CMD:cmdString success:^(id responseObject)
     {
         NSDictionary *dic = responseObject;
         NSLog(@"返回url%@",responseObject);
         if(dic)
         {
             self.baseUrl = [dic objectForKey:@"url"];
             if (self.baseUrl)
             {
                 weakSelf.currentYear = @"2019";
                 weakSelf.currentMouth = @"06";
                 
#ifdef kBossOwner
                 NSString *url = [self.baseUrl stringByAppendingString:[NSString stringWithFormat:@"&date=%02ld%02ld&biz_district_id=%@",2019,6,firstDistrictId]];
#else
                 NSString *url = [self.baseUrl stringByAppendingString:[NSString stringWithFormat:@"&date=%02ld%02ld",2019,6]];
#endif
                 
                 
                 
                 NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
                 [weakSelf.webView loadRequest:request];
             }
         }
     } fail:^(id error) {
         
     }];
    [self.view addSubview:self.selectedTimeView];
    
    self.openSelectView = [[BOOpenSelectTimeView alloc]init];
    [[UIApplication sharedApplication].keyWindow addSubview:self.openSelectView];
    
    self.selectedTimeView.openSelectBlock = ^{
        [weakSelf.openSelectView show];
    };
    
    self.districtSelectView = [[BOOpenSelectbusinessDistrictView alloc]init];
    [self.districtSelectView setupData:self.teamList];
    [[UIApplication sharedApplication].keyWindow addSubview:self.districtSelectView];
    self.selectedTimeView.openSelectDistrictBlock = ^{
        [weakSelf.districtSelectView show];
    };
    
    
    
    
    
    self.openSelectView.sureSelectBlock = ^(NSString * _Nonnull year, NSString * _Nonnull mouth) {
        weakSelf.currentYear = year;
        weakSelf.currentMouth = mouth;
        weakSelf.selectedTimeView.selectTimeStr = [NSString stringWithFormat:@"%@-%@",year,mouth];
        //        NSString *url = [weakSelf.baseUrl stringByAppendingString:[NSString stringWithFormat:@"&date=%@%@",year,mouth]];
        NSString *url = [weakSelf.baseUrl stringByAppendingString:[NSString stringWithFormat:@"&date=%@%@&biz_district_id=%@",weakSelf.currentYear,weakSelf.currentMouth,weakSelf.currentBizDistrictId]];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
        [weakSelf.webView loadRequest:request];
    };
    
    
    self.districtSelectView.sureSelectBlock = ^(NSString *name,NSString *dizId) {
        NSLog(@"你选择的商圈:%@ ---- id %@",name,dizId);
        weakSelf.currentBizDistrictId = dizId;
        weakSelf.currentBizDistrictName = name;
        [weakSelf.selectedTimeView setupDefault:weakSelf.currentBizDistrictName];
        NSString *url = [weakSelf.baseUrl stringByAppendingString:[NSString stringWithFormat:@"&date=%@%@&biz_district_id=%@",weakSelf.currentYear,weakSelf.currentMouth,weakSelf.currentBizDistrictId]];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
        [weakSelf.webView loadRequest:request];
    };
    
    //创建网页配置对象
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    
    // 创建设置对象
    WKPreferences *preference = [[WKPreferences alloc]init];
    //最小字体大小 当将javaScriptEnabled属性设置为NO时，可以看到明显的效果
    preference.minimumFontSize = 0;
    //设置是否支持javaScript 默认是支持的
    preference.javaScriptEnabled = YES;
    
    _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 44, kScreenWidth, kScreenHeight - 44*2) configuration:config];
    // UI代理
    _webView.UIDelegate = self;
    // 导航代理
    _webView.navigationDelegate = self;
    // 是否允许手势左滑返回上一级, 类似导航控制的左滑返回
    _webView.allowsBackForwardNavigationGestures = YES;
    [self.view addSubview:_webView];
    
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.openSelectView  remove];
}

-(void)setLeftItem
{
    UIBarButtonItem *buttonItem_back = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"popBack"] style:UIBarButtonItemStyleDone target:self action:@selector(popViewControllerAnimated)];
    [buttonItem_back setTintColor:[UIColor blackColor]];
    self.navigationItem.leftBarButtonItem = buttonItem_back;
}
-(void)popViewControllerAnimated
{
    [self.navigationController popViewControllerAnimated:true];
    
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */


@end
