//
//  ContactListVc.m
//  BossCommonClass
//
//  Created by 高炀辉 on 2019/6/19.
//

#import "ContactListVc.h"
#import "AnnouncementRequest.h"
#import "PersonAddressBookCell.h"

@interface ContactListVc ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *customTableView;

@property (nonatomic, strong)NSArray *arrM;

@end

@implementation ContactListVc

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self getList];
    [self setUI];
    [self.customTableView registerClass:[PersonAddressBookCell class] forCellReuseIdentifier:@"cell"];
}
- (void)getList{
    [AnnouncementRequest announcementContactsMembersId:self.group_id Success:^(NSArray * _Nonnull dataArr) {
        self.arrM = [dataArr mutableCopy];
        [self.customTableView reloadData];
    } fail:^(NSString * _Nonnull message) {
        
    }];
}
- (void)setUI{
    _customTableView.tableFooterView = [[UIView alloc] init];
    _customTableView.backgroundColor = [UIColor clearColor];
    _customTableView.rowHeight = 60;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arrM.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PersonAddressBookCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.model = self.arrM[indexPath.row];
    return cell;
}

@end
