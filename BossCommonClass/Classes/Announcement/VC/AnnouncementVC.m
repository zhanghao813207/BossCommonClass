
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
@interface AnnouncementVC ()<UITableViewDelegate,UITableViewDataSource,PublishAnnouncementControllerDelegate>
@property(nonatomic, strong)UITableView *tableview;
@property(nonatomic, strong)NSMutableArray *testArrM;

/**
 发布按钮
 */
@property(nonatomic, strong)UIButton *publishButton;

/**
 判断是否是第一次进入
 */
@property(nonatomic, assign)BOOL isFirst;


@end

@implementation AnnouncementVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:245 / 255.0 green:247 / 255.0 blue:249 / 255.0 alpha:1];
    self.title = @"BOSS公告";
    self.isFirst = true;
//    [self setting];
    [self testArrM];
    [self tableview];
    [self.tableview.mj_header beginRefreshing];
    [self publishButton];
    NSLog(@"%@",kCurrentBossManagerAccount.tokenModel.account_id);
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
            make.bottom.equalTo(self.view).offset(-34);
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
//    vc.nav = self.navigationController;
//    [self presentViewController:vc animated:true completion:^{
//
//    }];
//    self.tool = [[PopTool alloc] init];
//    [self.tool popView:self.publishView animated:true];
//    UIImagePickerController *pic = [[UIImagePickerController alloc] init];
//    [self presentViewController:pic animated:true completion:^{
//
//    }];
}



/**
 获取最新的数据
 */
- (void)refreshLatestData {
    [AnnouncementRequest announcementListLastId:@"test" success:^{
        
    } fail:^(NSString * message) {
        
    }];
    [self.tableview reloadData];
    [self.tableview.mj_footer endRefreshing];
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
    for (NSInteger i = 0; i < 5; i ++) {
        TestModel *model = [[TestModel alloc] init];
        if (i % 3 == 0) {
            model.isMe = false;
            model.text = @"这是新添加";
        }else {
            model.imgUrl = @"http://gss0.baidu.com/9fo3dSag_xI4khGko9WTAnF6hhy/zhidao/pic/item/d833c895d143ad4bab65039c80025aafa40f0626.jpg";
            model.isMe = true;
            model.text = @"新新";
        }
        model.title = [NSString stringWithFormat:@"活动上线通知%ld",(long)i];
        [self.testArrM insertObject:model atIndex:0];
    }
    [self.tableview reloadData];
    [self.tableview.mj_header endRefreshing];
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
    AnnouncementDetailVC *vc = [[AnnouncementDetailVC alloc] init];
    [self.navigationController pushViewController:vc animated:true];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    [tableView tableViewDisplayWitMsg:@"无数据" imageName:@"" ifNecessaryForRowCount:self.testArrM.count];
    return self.testArrM.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AnnouncementCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.model = self.testArrM[indexPath.row];
    return cell;
}
- (NSMutableArray *)testArrM {
    if (_testArrM == nil) {
        _testArrM = [NSMutableArray array];
        for (NSInteger i = 0; i < 0; i ++) {
            TestModel *model = [[TestModel alloc] init];
            if (i % 3 == 0) {
                model.isMe = false;
                model.text = @"活动上线通知活动上线通知活动上线通知活动上线通知活动上线通知活动上线通知活动上线通知活动上线通知活动上线通知活动上线通知活动上线通知活动上线通知活动上线通知";
            }else {
                model.imgUrl = @"http://b-ssl.duitang.com/uploads/item/201507/14/20150714194421_TMKCh.jpeg";
                model.isMe = true;
                model.text = @"车辚辚 马萧萧";
            }
            model.title = [NSString stringWithFormat:@"活动上线通知%ld",(long)i];
            
            
            [_testArrM addObject:model];
        }
    }
    return _testArrM;
}
- (void)dealloc {
    NSLog(@"销毁");
}
@end
