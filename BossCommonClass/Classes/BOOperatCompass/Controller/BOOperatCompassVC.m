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
#import "MaskView.h"
#import "ZFJCacheProtocol.h"
#import "UINavigationBar+BackgroundColor.h"
#import "BOOperatCollectionViewCell.h"
#import "BooperatMonthObject.h"

@interface BOOperatCompassVC ()<WKUIDelegate,WKNavigationDelegate, UICollectionViewDelegate, UICollectionViewDataSource>

@property(nonatomic, strong) UICollectionView *selectedTimeView;
@property(nonatomic, strong) WKWebView *webView;

@property(nonatomic, strong) BOOpenSelectTimeView *openSelectView;

@property(nonatomic, strong) BOOpenSelectbusinessDistrictView *districtSelectView;

@property(nonatomic, copy) NSString *baseUrl;

@property (nonatomic,strong)NSString *currentYear;
@property (nonatomic,strong)NSString *currentMouth;
@property (nonatomic,strong)NSString *currentBizDistrictId;
@property (nonatomic,strong)NSString *currentBizDistrictName;
@property (nonatomic,strong)PGDatePickManager *datePickManager;
@property (nonatomic,strong)UIView *maskView;
@property (nonatomic,strong)NSMutableArray *dataSourceArr;

@end

@implementation BOOperatCompassVC


- (void)viewDidLoad{
    
    [super viewDidLoad];

    [ZFJCacheProtocol startMonitorRequest:ZFJCacheAllType];
    
    self.dataSourceArr = [self setMonthDataSource:0];
    
    [self setUI];

    [self setLeftItem];
    
    [self getBaseUrl];
    
    if (@available(iOS 13.0, *)) {
        self.maskView = [[UIView alloc] initWithFrame:CGRectMake(0, 44, kScreenWidth, kScreenHeight - 44*2)];
        self.maskView.userInteractionEnabled = false;
        self.maskView.backgroundColor = [UIColor colorNamed:@"boss_000000-50"];
        if (self.view.traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark){
            [self.view addSubview:self.maskView];
        }
    }
}
-(void)getBaseUrl{
    __weak typeof(self) weakSelf = self;
        
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
    //    [self.selectedTimeView setupDefault:self.currentBizDistrictName];
    #else
        cmdString = @"jump_to_datahub.jump_to_datahub.jump";
        // 之家
        NSDictionary *dict = @{@"domain":@"private-app-center"};
    #endif
        
    // 获取url
    [NNBBasicRequest postJsonWithUrl:kUrl parameters:dict CMD:cmdString success:^(id responseObject){
        
         NSDictionary *dic = responseObject;
         NSLog(@"返回url%@",responseObject);
         if(dic){
//             NSDate *date =[NSDate date];//简书 FlyElephant
             // 获取 两天前的时间 T+2
             NSDate *date = [NSDate dateWithTimeInterval:-48*60*60 sinceDate:[NSDate date]];
             
             NSDateFormatter *formatter = [[NSDateFormatter alloc]init];

             [formatter setDateFormat:@"yyyy"];
             // 最大年份为当前年份
             
             int currentYear = [[formatter stringFromDate:date] intValue];
             [formatter setDateFormat:@"MM"];
             // 最大时间为当前月份 -1
             int currentMonth = [[formatter stringFromDate:date] intValue];
             
             
             self.baseUrl = [dic objectForKey:@"url"];
             if (self.baseUrl)
             {
                 weakSelf.currentYear = [NSString stringWithFormat:@"%d", currentYear];
                 weakSelf.currentMouth = [NSString stringWithFormat:@"%d", currentMonth];
                 
#ifdef kBossOwner
                 NSString *url = [self.baseUrl stringByAppendingString:[NSString stringWithFormat:@"&date=%02ld%02ld&biz_district_id=%@",currentYear,currentMonth,firstDistrictId]];
#else
                 NSString *url = [self.baseUrl stringByAppendingString:[NSString stringWithFormat:@"&date=%02d%02d", currentYear,currentMonth]];
#endif
                 NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60];
                 [weakSelf.webView loadRequest:request];
             }
         }
     } fail:^(id error) {
         
     }];
}
-(void)setUI{
    self.view.backgroundColor = [UIColor colorNamed:@"bgcolor_FFFFFF_000000"];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        //设置collectionView滚动方向
    [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    layout.itemSize = CGSizeMake(kScreenWidth / 5 , 44);
    
    
    self.selectedTimeView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 44) collectionViewLayout:layout];
    self.selectedTimeView.backgroundColor = [UIColor colorNamed:@"boss_2052BB_2052BB"];
    self.selectedTimeView.delegate = self;
    self.selectedTimeView.dataSource = self;
    [self.selectedTimeView registerNib:[UINib nibWithNibName:@"BOOperatCollectionViewCell" bundle:[self getThreeCurrentBundle]] forCellWithReuseIdentifier:@"cell"];
    [self.view addSubview:self.selectedTimeView];
    [self.selectedTimeView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:self.dataSourceArr.count - 1 inSection: 0] atScrollPosition:UICollectionViewScrollPositionRight animated:true];
//    .scrollToRow(at: indexPath, at:.bottom, animated: true)
    _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 44, kScreenWidth, kScreenHeight - 44*2)];
    // UI代理
    _webView.UIDelegate = self;
    // 导航代理
    _webView.navigationDelegate = self;
    // 是否允许手势左滑返回上一级, 类似导航控制的左滑返回
    _webView.allowsBackForwardNavigationGestures = false;
    
    [self.view addSubview:_webView];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar lt_setBackgroundColor: [UIColor colorNamed:@"boss_2052BB_2052BB"] showdowColor:[UIColor colorNamed:@"boss_2052BB_2052BB"]];
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
}
-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    [self.openSelectView  remove];
    [ZFJCacheProtocol cancelMonitorRequest];
    
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor whiteColor] showdowColor:[UIColor whiteColor]];
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]}];
}
- (NSBundle *)getThreeCurrentBundle{
     NSBundle *baseBundle = [NSBundle bundleForClass:[self class]];
     NSURL *bundleUrl = [baseBundle URLForResource:@"BossCommonClass" withExtension:@"bundle"];
     NSBundle *bundle = [NSBundle bundleWithURL:bundleUrl];
     return bundle;
}
- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection{
    [super traitCollectionDidChange:previousTraitCollection];
    if (@available(iOS 13.0, *)) {
        if (self.view.traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark){
            [self.view addSubview:self.maskView];
        } else {
            [self.maskView removeFromSuperview];
        }
    }
}
-(void)setLeftItem{
    
    UIBarButtonItem *buttonItem_back = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"popBack"] style:UIBarButtonItemStyleDone target:self action:@selector(popViewControllerAnimated)];
    [buttonItem_back setTintColor:[UIColor colorNamed:@"boss_FFFFFF_FFFFFF"]];
    self.navigationItem.leftBarButtonItem = buttonItem_back;
}

// 输入当前选中年份 获取 当前选中年份的月的数量
- (NSMutableArray *)setMonthDataSource:(int)selectYear{
    // 起始时间为 2019-05
    // 当前时间 2天前
    NSDate *date = [NSDate dateWithTimeInterval:-48*60*60 sinceDate:[NSDate date]];
    // 最大年份为当前年份
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    
    [formatter setDateFormat:@"yyyy"];
    
    int currentYear = [[formatter stringFromDate:date] intValue];
    
    if (selectYear == 0){
        selectYear = currentYear;
    }
    
    int startIndex = 0;
    
    int endIndex = 12;
    
    NSMutableArray *mutableArr = [[NSMutableArray alloc] init];
    
    if (selectYear == 2019){
        startIndex = 4;
        
    }
    // 选中年份 = 当前年份
    if (currentYear == selectYear){
        
        [formatter setDateFormat:@"MM"];
        // 获取月份
        endIndex = [[formatter stringFromDate:date] intValue];
    }
    
    for (int i = startIndex; i < endIndex; i++) {
        NSString *str = [NSString stringWithFormat:@"%d月", i + 1];
        BOOL isSelect = false;
        if (i == endIndex - 1){
            isSelect = true;
        }
        NSDictionary *dic = @{@"month": str, @"selectStatus": [NSNumber numberWithBool:isSelect], @"month_int": [NSNumber numberWithInt:i + 1]};
        BooperatMonthObject * model = [[BooperatMonthObject alloc] initWithDictionary:dic];
        [mutableArr addObject:model];
    }
    return mutableArr;
}
-(void)popViewControllerAnimated{
    [self.navigationController popViewControllerAnimated:true];
}


// mark: ----
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
//    [self.view showLoadingView:@"加载中..."];
    NSLog(@"页面开始加载:%s",__FUNCTION__);
}
// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
//    navigation.
    NSLog(@"内容开始返回:%s",__FUNCTION__);
}
// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    NSLog(@"页面加载完成:%s",__FUNCTION__);
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataSourceArr.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    BOOperatCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    BooperatMonthObject * model = self.dataSourceArr[indexPath.row];
    [cell.lineLabel setHidden:!model.isselect];
    cell.titleLabel.alpha = model.isselect ? 1 : 0.5;
    cell.titleLabel.text = model.name;
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    BooperatMonthObject * model = self.dataSourceArr[indexPath.row];
    model.isselect = true;
    for (BooperatMonthObject * sModel in self.dataSourceArr) {
        if (model != sModel){
            sModel.isselect = false;
        }
    }
    NSString *url = [self.baseUrl stringByAppendingString:[NSString stringWithFormat:@"&date=%@%02d", self.currentYear,model.month_int]];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60];
    [self.webView loadRequest:request];
    [collectionView reloadData];
}
// 解决手势冲突
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if (touch.view != self.selectedTimeView) {
        return NO;
    }else {
        return YES;
    }
}
@end
