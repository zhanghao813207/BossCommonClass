//
//  SelectLocationVc.m
//  BossCommonClass
//
//  Created by 高炀辉 on 2020/2/9.
//

#import "SelectLocationVc.h"
#import "SelectLocationCell.h"
#import "NNBBasicRequest.h"
#import "BossLoginEnumDefine.h"
#import "BossBasicDefine.h"
#import "MJRefresh.h"

@interface SelectLocationVc ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *locationTableView;
@property (nonatomic, strong)NSMutableArray *TeamListArray;
// 分页数据
@property (assign, nonatomic) int page;

// 选中的model
@property (nonatomic, strong)joinedData *s_model;

@end

@implementation SelectLocationVc

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.locationTableView.mj_header beginRefreshing];
}
- (void)setUI{
    self.locationTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshLatestData)];
    self.locationTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(refreshMoreData)];
    
    self.page = 1;
    
    self.TeamListArray = [[NSMutableArray alloc] init];
}
- (void)getTeamList{
    __weak __typeof__(self) weakSelf = self;
    
    NSArray *stateArr = @[@(TeamInvitationStateDone)];
    [NNBBasicRequest postJsonWithUrl:kUrl parameters:@{@"_meta": @{@"page": @(self.page),  @"limit": @(30)}, @"role": @[@(1)], @"state":stateArr} CMD:@"team.team.my_teams" success:^(id responseObject) {
        NSDictionary *dic = responseObject;
        
        NSLog(@"工作台数据:%@",dic);
        
        joinedRootClass *baseModel = [[joinedRootClass alloc] initWithDictionary:dic];
        
        if (weakSelf.page == 1) {
            [weakSelf.TeamListArray removeAllObjects];
            [weakSelf.locationTableView.mj_footer resetNoMoreData];
            [weakSelf.locationTableView.mj_header endRefreshing];
        } else {
            [weakSelf.locationTableView.mj_footer endRefreshing];
        }
        if (baseModel.data.count > 0) {
            weakSelf.locationTableView.backgroundColor = kHexRGB(0xF9FBFC);
            for(joinedData *model in baseModel.data) {
                [weakSelf.TeamListArray addObject:model];
            }
        } else {
            weakSelf.locationTableView.backgroundColor = UIColor.clearColor;
        }
        
        if (baseModel.meta.hasMore == false) {
            weakSelf.locationTableView.mj_footer = nil;
        } else {
            weakSelf.locationTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(refreshMoreData)];
        }
        
        [weakSelf.locationTableView reloadData];
        
    } fail:^(id error) {
        
    }];
}
- (void)refreshMoreData {
    self.page ++;
    [self getTeamList];
}

- (void)refreshLatestData {
    self.page = 1;
    [self getTeamList];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.TeamListArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SelectLocationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    joinedData *model = self.TeamListArray[indexPath.row];
    cell.nameLabel.text = model.teamInfo.name;
    if (model.isselect){
        [cell.selectIconImageView setImage:[UIImage imageNamed:@"selectImage_p" inBundle:QH_Bundle  compatibleWithTraitCollection:nil]];
    } else {
        [cell.selectIconImageView setImage:[UIImage imageNamed:@""]];
    }
    return cell;
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {
        return NO;
    }
    return  YES;
}
// tag 0 取消 1 确定
- (IBAction)chooseButtonClicked:(UIButton *)sender {
    if (sender.tag == 0){
        [self dismissViewControllerAnimated:true completion:nil];
        return;
    }
    
    if (sender.tag == 1){
        // 选中的model
        if (self.selectLocationBlock){
            self.selectLocationBlock(self.s_model);
        }
        [self dismissViewControllerAnimated:true completion:nil];
    }
    
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    joinedData *model = self.TeamListArray[indexPath.row];
    model.isselect = true;
    for(joinedData *models in self.TeamListArray){
        if (model.hash != models.hash){
            model.isselect = false;
        }
    }
    self.s_model = model;
    [tableView reloadData];
}
@end
