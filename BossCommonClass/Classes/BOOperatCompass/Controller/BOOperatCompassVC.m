//
//  BOOperatCompassVC.m
//  BossKnight
//
//  Created by admin on 2019/7/19.
//
#import <WebKit/WebKit.h>
#import "BOOperatCompassVC.h"
#import "BOSelectTimeView.h"
#import "BOOpenSelectTimeView.h"
#import "NNBBasicRequest.h"
#import "BossBasicDefine.h"
#import "TeamListModel.h"
#import "BOOpenSelectbusinessDistrictView.h"
#import "PGDatePickManager.h"

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
@property (nonatomic,strong)PGDatePickManager *datePickManager;




@end

@implementation BOOperatCompassVC
- (void)pickDateCreate{
    self.datePickManager = [[PGDatePickManager alloc]init];
    PGDatePicker *datePicker = self.datePickManager.datePicker;
    datePicker.datePickerMode = PGDatePickerModeYearAndMonth;
    NSDate *date =[NSDate date];//简书 FlyElephant
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];

    [formatter setDateFormat:@"yyyy"];
    // 最大年份为当前年份
    int currentYear = [[formatter stringFromDate:date] intValue];
    [formatter setDateFormat:@"MM"];
    // 最大时间为当前月份 -1
    int currentMonth = [[formatter stringFromDate:date] intValue] - 1;
    // 拼接字符串
    NSString *maxStr = [NSString stringWithFormat:@"%d-%.2d", currentYear, currentMonth];
    // 拼接字符串
    NSString *minStr = @"2019-05";
    // 获取 formatter
    NSDateFormatter *nextformatter = [[NSDateFormatter alloc] init] ;
    [nextformatter setDateFormat:@"yyyy-MM"];
    // 转为 NSDate 格式 (结束时间)
    NSDate *maxDate=[nextformatter dateFromString:maxStr];
    // 转为 NSDate 格式 (开始时间)
    NSDate *minDate=[nextformatter dateFromString:minStr];
    datePicker.maximumDate = maxDate;
    
    datePicker.minimumDate = minDate;
    __weak typeof(self) weakSelf = self;
    datePicker.selectedDate = ^(NSDateComponents *dateComponents) {
//        NSLog(@"dateComponents = %.d", dateComponents.month);
//        NSLog(@"dateComponents = %.2d", dateComponents.year);
        weakSelf.currentYear = [NSString stringWithFormat:@"%ld",  dateComponents.year];
        weakSelf.currentMouth = [NSString stringWithFormat:@"%.2ld",  dateComponents.month];
        weakSelf.selectedTimeView.selectTimeStr = [NSString stringWithFormat:@"%@-%@",weakSelf.currentYear,weakSelf.currentMouth];
        //        NSString *url = [weakSelf.baseUrl stringByAppendingString:[NSString stringWithFormat:@"&date=%@%@",year,mouth]];
        NSString *url = [weakSelf.baseUrl stringByAppendingString:[NSString stringWithFormat:@"&date=%@%@&biz_district_id=%@",weakSelf.currentYear,weakSelf.currentMouth,weakSelf.currentBizDistrictId]];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
        [weakSelf.webView loadRequest:request];
    };
    [self presentViewController:self.datePickManager animated:false completion:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
//    [self pickDateCreate];
    self.view.backgroundColor = [UIColor colorNamed:@"bgcolor_FFFFFF_000000"];
    
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
             NSDate *date =[NSDate date];//简书 FlyElephant
             NSDateFormatter *formatter = [[NSDateFormatter alloc]init];

             [formatter setDateFormat:@"yyyy"];
             // 最大年份为当前年份
             int currentYear = [[formatter stringFromDate:date] intValue];
             [formatter setDateFormat:@"MM"];
             // 最大时间为当前月份 -1
             int currentMonth = [[formatter stringFromDate:date] intValue] - 1;
             self.baseUrl = [dic objectForKey:@"url"];
             if (self.baseUrl)
             {
                 weakSelf.currentYear = [NSString stringWithFormat:@"%d", currentYear];
                 weakSelf.currentMouth = [NSString stringWithFormat:@"%d", currentMonth];
                 
#ifdef kBossOwner
                 NSString *url = [self.baseUrl stringByAppendingString:[NSString stringWithFormat:@"&date=%02ld%02ld&biz_district_id=%@",currentYear,currentMonth,firstDistrictId]];
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
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf pickDateCreate];
        });

    };
    
    self.districtSelectView = [[BOOpenSelectbusinessDistrictView alloc]init];
    [self.districtSelectView setupData:self.teamList];
    [[UIApplication sharedApplication].keyWindow addSubview:self.districtSelectView];
    self.selectedTimeView.openSelectDistrictBlock = ^{
        [weakSelf.districtSelectView show];
    };
    
    
    
    
    
    self.openSelectView.sureSelectBlock = ^(NSString * _Nonnull year, NSString * _Nonnull mouth) {
        
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
-(void)tapView:(UITapGestureRecognizer *)sender{
    //设置轻拍事件改变testView的颜色
    // UI更新代码
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.openSelectView  remove];
}

-(void)setLeftItem
{
    UIBarButtonItem *buttonItem_back = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"popBack"] style:UIBarButtonItemStyleDone target:self action:@selector(popViewControllerAnimated)];
    [buttonItem_back setTintColor:[UIColor colorNamed:@"boss_000000_FFFFFF"]];
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
