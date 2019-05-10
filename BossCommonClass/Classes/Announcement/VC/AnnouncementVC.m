
//
//  AnnouncementVC.m
//  AFNetworking
//
//  Created by admin on 2019/4/14.
//

#import "AnnouncementVC.h"
#import "JYCMethodDefine.h"
#import "TestModel.h"
#import "Masonry.h"
#import "AnnouncementCell.h"
#import "MJRefresh.h"
#import "AnnouncementDetailVC.h"
#import "PublishAnnouncementController.h"
#import "BossMethodDefine.h"
#import "BossManagerAccount.h"
#import "UITableView+EmptyData.h"
#import "AnnouncementRequest.h"
#import "BossConstDataDefine.h"
#import "UIView+ShowView.h"
#import "AnnoucementList.h"
#import "MQTTClientModel.h"
#import "JYCSimpleToolClass.h"
#include <CommonCrypto/CommonHMAC.h>
#import "QLifeAES256.h"
#import "MQTTClientModel.h"
#define isiPhone (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define iPhoneX [[UIScreen mainScreen] bounds].size.width >= 375.0f && [[UIScreen mainScreen] bounds].size.height >= 812.0f && isiPhone
@interface AnnouncementVC ()<UITableViewDelegate,UITableViewDataSource,PublishAnnouncementControllerDelegate,MQTTClientModelDelegate>
@property(nonatomic, strong)UITableView *tableview;
@property(nonatomic, strong)NSMutableArray *dataArrM;
/**
 发布按钮
 */
@property(nonatomic, strong)UIButton *publishButton;

/**
 判断是否是第一次进入
 */
@property(nonatomic, assign)BOOL isFirst;

/**
 当前页
 */
@property(nonatomic, assign)NSInteger currentPage;
@property(nonatomic, assign)BOOL hasMore;
@property (nonatomic, strong) dispatch_source_t timer;
@property(nonatomic, copy)NSString *key;
@end

@implementation AnnouncementVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:245 / 255.0 green:247 / 255.0 blue:249 / 255.0 alpha:1];
    self.title = @"BOSS公告";
    self.key = @"cc6803a649ff7f3f036566d1421c4315";
    self.currentPage = 1;
    self.isFirst = true;
//    [self setting];
    [self dataArrM];
    [self tableview];
    
    [self publishButton];
//    [AnnouncementRequest getNewtokenSuccess:^(id response) {
//        [AnnouncementRequest registerSession];
////        [[MQTTClientModel sharedInstance] subscribeTopic:response[@"account_id"]];
////        [MQTTClientModel sharedInstance].delegate = self;
////        [self countDownWithTopic:response[@"account_id"]];
////        [self.tableview.mj_header beginRefreshing];
//    }];
    if ([kUserDefault objectForKey:@"newToken"]) {
        [MQTTClientModel sharedInstance].delegate = self;
        [self countDownWithTopic:[kUserDefault objectForKey:@"account_id"]];
        [self.tableview.mj_header beginRefreshing];
    }
#ifdef kBossKnight
    self.publishButton.hidden = true;
    [self.tableview mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.publishButton.mas_top).offset(46);
    }];
#elif defined kBossManager
    self.publishButton.hidden = false;
#else
    self.publishButton.hidden = true;
#endif

}

- (void)MQTTClientModel_handleMessage:(NSData *)data onTopic:(NSString *)topic retained:(BOOL)retained {
    NSLog(@"%@",data);

    NSLog(@"数据");
    [self refreshLatestData];
}
-(NSString*)dictionaryToJson:(NSDictionary *)dic
{
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}


///定时器
- (void)countDownWithTopic:(NSString *)topic {
    
    /** 获取一个全局的线程来运行计时器*/
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    /** 创建一个计时器*/
    self.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
    /** 设置计时器, 这里是每10毫秒执行一次*/
    dispatch_source_set_timer(self.timer, dispatch_walltime(nil, 0), 60000*NSEC_PER_MSEC, 0);
    /** 设置计时器的里操作事件*/
    dispatch_source_set_event_handler(self.timer, ^{
        NSDictionary *dic = @{@"event_name":@"heartbeat",@"payload":@{@"account_id":topic}};
        NSData *encodedData = [QLifeAES256 dataWithEncodeObj:dic password:self.key];
        [[MQTTClientModel sharedInstance] sendDataToTopic:@"ums/" data:encodedData];
       
    });
    dispatch_resume(self.timer);
}
- (void)back {
//    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"newToken"];
    [kUserDefault removeObjectForKey:@"uploadImage"];
    [self.navigationController popViewControllerAnimated:true];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
//    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"newToken"];
    [kUserDefault removeObjectForKey:@"uploadImage"];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = false;
}
/**
 设置按钮
 */
- (void)setting {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"设置" forState:UIControlStateNormal];
    [button setTitleColor:kHexRGB(0x1173E4) forState:UIControlStateNormal];
    [button addTarget:self action:@selector(setAction) forControlEvents:UIControlEventTouchUpInside];
    button.titleLabel.font = [UIFont systemFontOfSize:17];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
}
- (void)setAction {
    
}

- (UIButton *)publishButton {
    if (_publishButton == nil) {
        _publishButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _publishButton.backgroundColor = kHexRGB(0x1173E4);
        _publishButton.titleLabel.font = [UIFont systemFontOfSize:16];
        _publishButton.layer.cornerRadius = 4;
        _publishButton.layer.masksToBounds = true;
        [_publishButton setTitle:@"新建公告" forState:UIControlStateNormal];
        [_publishButton addTarget:self action:@selector(publishAction) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_publishButton];
        [_publishButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view).offset(20);
            make.right.equalTo(self.view).offset(-20);
            if (iPhoneX) {
               make.bottom.equalTo(self.view).offset(-30);
            }else {
               make.bottom.equalTo(self.view).offset(-10);
            }
            
            make.height.mas_equalTo(46);
        }];
    }
    return _publishButton;
}
//PublishAnnouncementControllerDelegate
- (void)publishSuccess {
    NSLog(@"发布成功");
    [self refreshLatestData];
}
- (void)publishAction {
    PublishAnnouncementController *vc = [[PublishAnnouncementController alloc] init];
    vc.delegate = self;
    [self.navigationController pushViewController:vc animated:false];

}

/**
 获取最新的数据
 */
- (void)refreshLatestData {
    
    self.currentPage  = 1;
    [AnnouncementRequest announcementListLastId:@"" page:self.currentPage  success:^(NSArray * _Nonnull dataArr, AnnounceListHeader * _Nonnull header) {
        self.dataArrM = [dataArr mutableCopy];
        self.currentPage = 1;
        self.hasMore = header.has_more;
        
        [self.tableview reloadData];
        [self.tableview.mj_footer endRefreshing];
        self.tableview.mj_footer = nil;
        if (self.currentPage == 1 && dataArr.count > 0) {
            NSIndexPath *indesPath = [NSIndexPath indexPathForRow:self.dataArrM.count - 1 inSection:0];
            [self.tableview scrollToRowAtIndexPath:indesPath atScrollPosition:UITableViewScrollPositionBottom animated:false];
        }
        
    } fail:^(NSString * message) {
        [self.tableview.mj_footer endRefreshing];
    }];
}

/**
 获取历史数据
 */
- (void)refreshMoreData {
    if (self.isFirst) {
        [self refreshLatestData];
        self.isFirst = false;
        [self.tableview.mj_header endRefreshing];
        return;
    }
    if (!self.hasMore) {
//        [self.view showStatus:@"没有更多数据"];
        [self.tableview.mj_header endRefreshing];
        return;
    }
    self.currentPage ++;
    
    [AnnouncementRequest announcementListLastId:@"" page:self.currentPage  success:^(NSArray * _Nonnull dataArr, AnnounceListHeader * _Nonnull header) {
        self.hasMore = header.has_more;
        for (AnnoucementList *list in dataArr) {
            [self.dataArrM insertObject:list atIndex:0];
        }
        [self.tableview reloadData];
        if (self.dataArrM.count > 10) {
            NSIndexPath *indesPath = [NSIndexPath indexPathForRow: 9 inSection:0];
            [self.tableview scrollToRowAtIndexPath:indesPath atScrollPosition:UITableViewScrollPositionBottom animated:false];
        }
        [self.tableview reloadData];
        [self.tableview.mj_header endRefreshing];
    } fail:^(NSString * message) {
        [self.tableview.mj_header endRefreshing];
    }];
//    [self.tableview reloadData];
//    [self.tableview.mj_header endRefreshing];
}
- (UITableView *)tableview {
    if (_tableview == nil) {
        _tableview = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.backgroundColor = [UIColor colorWithRed:245 / 255.0 green:247 / 255.0 blue:249 / 255.0 alpha:1];
        _tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshMoreData)];
        _tableview.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(refreshLatestData)];
        [_tableview registerClass:[AnnouncementCell class] forCellReuseIdentifier:@"cell"];
        _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:_tableview];
        [_tableview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(self.view);
            make.bottom.equalTo(self.publishButton.mas_top).offset(-34);
        }];
    }
    return _tableview;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    AnnoucementList *list = self.dataArrM[indexPath.row];
    AnnouncementDetailVC *vc = [[AnnouncementDetailVC alloc] init];
    vc.block = ^(NSInteger count) {
        if (list.sender_info.isMe) {//是我发的才刷新
            list.message_counter_info.read_counter = count;
            [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        }
    };
    vc.idStr = list.message_summary_info._id;
    vc.isMe = list.sender_info.isMe;
    list.is_read = true;
    
    [self.navigationController pushViewController:vc animated:true];
    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    [tableView tableViewDisplayWitMsg:@"暂无消息" imageName:@"" ifNecessaryForRowCount:self.dataArrM.count];
    return self.dataArrM.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AnnouncementCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.model = self.dataArrM[indexPath.row];
    return cell;
}
- (NSMutableArray *)dataArrM {
    if (_dataArrM == nil) {
        _dataArrM = [NSMutableArray array];
    }
    return _dataArrM;
}
- (void)dealloc {
    NSLog(@"销毁");
}
@end
