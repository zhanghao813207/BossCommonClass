//
//  LocalAuthorityManage.m
//  AFNetworking
//
//  Created by admin on 2019/10/16.
//

#import "LocalAuthorityManage.h"
#import "BossBasicDefine.h"
#import "BossOwnerAccount.h"

@interface LocalAuthorityManage ()

@property (nonatomic,strong)CLLocationManager *locationManager;

@property (nonatomic,assign) BOOL showThreeAuth; // 展示三方权限

@end


@implementation LocalAuthorityManage

#pragma mark - 检查授权状态
+ (void)checkLocalAuthorizationStatus{
    [CLLocationManager authorizationStatus];
    [[LocalAuthorityManage sharedLocalAuthorityManage] checkLocationServicesAuthorizationStatus];
}

+(void)showThreePartyConfigWithShow:(BOOL)show;
{
    [[LocalAuthorityManage sharedLocalAuthorityManage] setThreeConfigWithShow:show];

}


-(void)setThreeConfigWithShow:(BOOL)show
{
    self.showThreeAuth = show;
}

+ (instancetype)sharedLocalAuthorityManage
{
    static LocalAuthorityManage *localAuthorityManage;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        localAuthorityManage = [[LocalAuthorityManage alloc] init];
    });
    return localAuthorityManage;
}

-(instancetype)init
{
    self = [super init];
    return self;
}

-(void)checkLocationServicesAuthorizationStatus {
    BOOL gloabal = [CLLocationManager locationServicesEnabled];
    if(gloabal){
        [self reportLocationServicesAuthorizationStatus:[CLLocationManager authorizationStatus]];

    }else{
        [self alertViewWithMessageWithTitle:@"定位服务未开启，请到手机系统的【设置】-【隐私】-【定位】中打开开关，并允许Boss骑士使用定位服务"];
    }
    
}


- (void)reportLocationServicesAuthorizationStatus:(CLAuthorizationStatus)status
{
    if(status == kCLAuthorizationStatusNotDetermined)
    {
        //未决定，继续请求授权
        [self requestLocationServicesAuthorization];
        
    }
    else if(status == kCLAuthorizationStatusRestricted || status == kCLAuthorizationStatusDenied)
    {
        //受限制，尝试提示然后进入设置页面进行处理（根据API说明一般不会返回该值）
        [self alertViewWithMessageWithTitle:@"需要您允许BOSS骑士访问 定位 权限才能使用哦~去设置开启一下吧"];
    }
   
    else if(status == kCLAuthorizationStatusAuthorizedWhenInUse || status == kCLAuthorizationStatusAuthorizedAlways)
    {
        //授权使用，如果展示三方权限,发送通知
        if(self.showThreeAuth ){
            [[NSNotificationCenter defaultCenter]postNotificationName:@"ThreePartyAuthNotification" object:nil];
        }
    }
}

#pragma mark - Helper methods


- (void)alertViewWithMessageWithTitle:(NSString *)titleStr {
    UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"提示" message:titleStr delegate:self cancelButtonTitle:@"暂不" otherButtonTitles:@"去设置", nil];
    [alter show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        
    }
    else
    {
        //进入系统设置页面，APP本身的权限管理页面
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
    }
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    [self reportLocationServicesAuthorizationStatus:status];
}
#pragma mark - 获取授权

-(void)requestLocationServicesAuthorization
{
    //CLLocationManager的实例对象一定要保持生命周期的存活
    if (!self.locationManager) {
        self.locationManager  = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self;
    }
    
    [self.locationManager requestWhenInUseAuthorization];
    [self.locationManager startUpdatingLocation];
}
#pragma mark - CLLocationMangerDelegate methods

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    
    [self.locationManager stopUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    
    [self.locationManager stopUpdatingLocation];
}

@end
