
//
//  PersonAddressBookVC.m
//  AFNetworking
//
//  Created by admin on 2019/4/17.
//

#import "PersonAddressBookVC.h"
#import "ContactsPerson.h"
#import "PersonAddressBookCell.h"
#import "Masonry.h"
#import "JYCMethodDefine.h"
#import "AnnouncementRequest.h"
#import "UIView+ShowView.h"
#import "SendMessageStartVc.h"
#import "UIViewController+StoryBoard.h"
@interface PersonAddressBookVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic, strong)UITableView *tableview;

/**
 全选的父视图
 */
@property(nonatomic, strong)UIView *selecBar;
@property(nonatomic, strong)UIView *lineView;

/**
 全选按钮
 */
@property(nonatomic, strong)UIButton *allSelectButton;

/**
 完成按钮
 */
@property(nonatomic, strong)UIButton *finishButton;
@property(nonatomic, assign)BOOL isSelecAll;
@property(nonatomic, strong)NSMutableArray<ContactsPerson *> *arrM;
@property(nonatomic, strong)NSArray *allDataArr;
// 索引Arr
@property(nonatomic, strong)NSMutableArray *indexArr;
// 内容Arr
@property(nonatomic, strong)NSMutableArray *userContentArr;
@property(nonatomic, strong)NSMutableArray<ContactsPerson *> *selectArrM;
@end

@implementation PersonAddressBookVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kHexRGB(0xF9FBFC);
    self.navigationController.navigationBarHidden = false;
    self.title = self.group.name;
    self.arrM = [NSMutableArray array];
    self.selectArrM = [NSMutableArray array];
//    self.isinsertStartTolk = true;
    [self addSubviews];
    ////先隐藏掉
//    [self setSelectModel];
    [self getData];
}
- (void)addSubviews {
    [self tableview];
    [self selecBar];
//    [self lineView];
//    [self allSelectButton];
//    self.finishButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    self.finishButton.enabled = false;
//    self.finishButton.frame = CGRectMake(0, 0, 60, 35);
//    self.finishButton.layer.cornerRadius = 4;
//    self.finishButton.layer.masksToBounds = true;
//    [self.finishButton setTitle:@"完成" forState:UIControlStateNormal];
//    self.finishButton.backgroundColor = kHexRGB(0x34A9FF);
//    [self.finishButton addTarget:self action:@selector(finishAction) forControlEvents:UIControlEventTouchUpInside];
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.finishButton];
}
- (void)getData {
    WS(weakSelf);
    [self.view showLoadingView:@"数据加载中..."];
    [AnnouncementRequest announcementContactsMembersId:self.group._id Success:^(NSArray * _Nonnull dataArr) {
        self.arrM = [dataArr mutableCopy];
        [self setSelectModel];
        self.userContentArr = [self sortObjectsAccordingToInitialWith:self.arrM];
        [self.tableview reloadData];
        [weakSelf.view dismissLoadingViewWithCompletion:nil];
    } fail:^(NSString * _Nonnull message) {
        
    }];
}
/**
 处理上一个界面带回来的数据
 */
- (void)setSelectModel {
    [self.selectArrM removeAllObjects];
    if (self.isAll) {
        for (ContactsPerson *model in self.arrM) {
            model.isSelect = true;
            [self.selectArrM addObject:model];
        }
        self.isSelecAll = true;
        [self.tableview reloadData];
    }else {
        for (ContactsPerson *model in self.personSelectArr) {
            for (ContactsPerson *tempModel in self.arrM) {
                if ([model.nick_name isEqualToString:tempModel.nick_name]) {
                    tempModel.isSelect = true;
                    [self.selectArrM addObject:tempModel];
                }
            }
            
        }
        if (self.selectArrM.count == self.arrM.count && self.arrM.count != 0) {
            self.isSelecAll = true;
        }
        [self.tableview reloadData];
    }
    
}
- (void)finishAction {
   
    if (self.delegate && [self.delegate respondsToSelector:@selector(selectPerson:isAll:)]) {
        [self.delegate selectPerson:self.selectArrM isAll:self.isSelecAll];
        [self.navigationController popViewControllerAnimated:true];
    }
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = false;
}

/////先隐藏掉
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    ContactsPerson *model = self.arrM[indexPath.row];
//    model.isSelect = !model.isSelect;
//    if (model.isSelect) {
//        [self.selectArrM addObject:model];
//    }else {
//        [self.selectArrM removeObject:model];
//    }
//    NSLog(@"%ld",self.selectArrM.count);
//    if (self.selectArrM.count > 0) {
//        self.finishButton.enabled = true;
//    }else {
//        self.finishButton.enabled = false;
//    }
//    if (self.selectArrM.count == self.arrM.count) {
//        self.isSelecAll = true;
//    }else {
//        self.isSelecAll = false;
//    }
//    NSLog(@"%@",self.selectArrM);
//    [tableView reloadData];
//}
-(NSMutableArray *)sortObjectsAccordingToInitialWith:(NSArray *)arr {
    
    // 初始化UILocalizedIndexedCollation
    UILocalizedIndexedCollation *collation = [UILocalizedIndexedCollation currentCollation];
    
    //得出collation索引的数量，这里是27个（26个字母和1个#）
    NSInteger sectionTitlesCount = [[collation sectionTitles] count];
    //初始化一个数组newSectionsArray用来存放最终的数据，我们最终要得到的数据模型应该形如@[@[以A开头的数据数组], @[以B开头的数据数组], @[以C开头的数据数组], ... @[以#(其它)开头的数据数组]]
    NSMutableArray *newSectionsArray = [[NSMutableArray alloc] initWithCapacity:sectionTitlesCount];
    
    //初始化27个空数组加入newSectionsArray
    for (NSInteger index = 0; index < sectionTitlesCount; index++) {
        NSMutableArray *array = [[NSMutableArray alloc] init];
        [newSectionsArray addObject:array];
    }
    
    //将每个名字分到某个section下
    for (ContactsPerson *personModel in self.arrM) {
        //获取name属性的值所在的位置，比如"林丹"，首字母是L，在A~Z中排第11（第一位是0），sectionNumber就为11
        NSInteger sectionNumber = [collation sectionForObject:personModel collationStringSelector:@selector(nick_name)];
        //把name为“林丹”的p加入newSectionsArray中的第11个数组中去
        NSMutableArray *sectionNames = newSectionsArray[sectionNumber];
        [sectionNames addObject:personModel];
    }
    
    //对每个section中的数组按照name属性排序
    for (NSInteger index = 0; index < sectionTitlesCount; index++) {
        NSMutableArray *personArrayForSection = newSectionsArray[index];
        NSArray *sortedPersonArrayForSection = [collation sortedArrayFromArray:personArrayForSection collationStringSelector:@selector(nick_name)];
        newSectionsArray[index] = sortedPersonArrayForSection;
    }
    
    //    //删除空的数组
    NSMutableArray *finalArr = [NSMutableArray new];
    NSMutableArray *indexArr = [NSMutableArray new];
    for (NSInteger index = 0; index < sectionTitlesCount; index++) {
        if (((NSMutableArray *)(newSectionsArray[index])).count != 0) {
            NSMutableArray *personModelArr = (NSMutableArray *)(newSectionsArray[index]);
            ContactsPerson *personModel = personModelArr[0];
            [indexArr addObject: [self getFirstLetterFromString:personModel.nick_name]];
            [finalArr addObject:personModelArr];
        }
    }
    self.indexArr = indexArr;
    return finalArr;
    
//    return newSectionsArray;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return self.userContentArr.count;
}
//返回每个section的title
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {

    return self.indexArr[section];
}
//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    return [[[UILocalizedIndexedCollation currentCollation] sectionTitles] objectAtIndex:section];
//}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return self.indexArr;
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    return [[UILocalizedIndexedCollation currentCollation] sectionForSectionIndexTitleAtIndex:index];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 35;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] init];
    view.frame = CGRectMake(0, 0, self.view.frame.size.width, 35);
    view.backgroundColor = kHexRGB(0xF2F3F4);
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(10, 0, 100, 35);
    label.textColor = UIColor.blackColor;
    label.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
    label.text = self.indexArr[section];
    [view addSubview:label];
    return view;
}
// 获取字符首字母拼音
- (NSString *)getFirstLetterFromString:(NSString *)aString
{
    //转成了可变字符串
    NSMutableString *str = [NSMutableString stringWithString:aString];
    //先转换为带声调的拼音
    CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformMandarinLatin,NO);
    //再转换为不带声调的拼音
    CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformStripDiacritics,NO);
    //转化为大写拼音
    NSString *strPinYin = [str capitalizedString];
    //获取并返回首字母
    return [strPinYin substringToIndex:1];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSMutableArray *contentArr = self.userContentArr[section];
    return contentArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PersonAddressBookCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    NSMutableArray *contentArr = self.userContentArr[indexPath.section];
    cell.model = contentArr[indexPath.row];
    return cell;
}

// 隐藏最后一行分割线
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.01f;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    UIView *view =[ [UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    return view;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.iscloseTalk) {
        SendMessageStartVc * vc = [SendMessageStartVc storyBoardCreateViewControllerWithBundle:@"BossCommonClass" StoryBoardName:@"EntrustAccountRegistration"];
        NSMutableArray *contentArr = self.userContentArr[indexPath.section];
        ContactsPerson *model = contentArr[indexPath.row];
        vc.name = model.nick_name;
        vc.teamName = self.title;
        vc.targetid = model._id;
        #ifdef kBossKnight
        return;
        #else
        [self.navigationController pushViewController:vc animated:true];
        #endif
    }
}
- (UITableView *)tableview {
    if (_tableview == nil) {
        _tableview = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableview.rowHeight = 60;
        _tableview.delegate = self;
        _tableview.dataSource = self;
//        _tableview.separatorInset = UIEdgeInsetsMake(0, 50, 0, 0);
        _tableview.tableFooterView = [[UIView alloc] init];
        _tableview.backgroundColor = [UIColor clearColor];
        [_tableview registerClass:[PersonAddressBookCell class] forCellReuseIdentifier:@"cell"];
//        [_tableview registerNib:[UINib nibWithNibName:@"HeaderIndexCell" bundle:[self getCurrentBundle]] forCellReuseIdentifier:@"index"];
        [self.view addSubview:_tableview];
        [_tableview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.view);
            make.top.equalTo(self.view);
//            make.bottom.equalTo(self.selecBar.mas_top);
            make.bottom.equalTo(self.view);
        }];
    }
    return _tableview;
}
- (NSBundle *)getCurrentBundle {
    NSBundle *baseBundle = [NSBundle bundleForClass:[self class]];
    
    NSURL *bundleUrl = [baseBundle URLForResource:@"BossCommonClass" withExtension:@"bundle"];
    if(!bundleUrl){
        
        [self.navigationController.view showStatus:@"文件路径有误!"];
        
    }
    NSBundle *bundle = [NSBundle bundleWithURL:bundleUrl];
    
    return bundle;
}
- (UIView *)selecBar {
    if (_selecBar == nil) {
        _selecBar = [[UIView alloc] init];
        [self.view addSubview:_selecBar];
        [_selecBar mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self.view);
            make.height.mas_equalTo(78);
        }];
    }
    return _selecBar;
}
- (UIButton *)allSelectButton {
    if (_allSelectButton == nil) {
        _allSelectButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_allSelectButton setTitle:@"全选" forState:UIControlStateNormal];
        _allSelectButton.titleLabel.textColor = kHexRGB(0x0A86F9);
//        _allSelectButton.backgroundColor = [UIColor purpleColor];
        [_allSelectButton setTitleColor:kHexRGB(0x0A86F9) forState:UIControlStateNormal];
        [_allSelectButton addTarget:self action:@selector(allSelect) forControlEvents:UIControlEventTouchUpInside];
        [self.selecBar addSubview:_allSelectButton];
        [_allSelectButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.selecBar).offset(16);
            make.top.equalTo(self.selecBar).offset(10);
        }];
    }
    return _allSelectButton;
}
- (void)allSelect {
    for (ContactsPerson *model in self.arrM) {
        model.isSelect = true;
    }
    [self.selectArrM  removeAllObjects];
    [self.selectArrM addObjectsFromArray:self.arrM];
    self.isSelecAll = true;
    self.finishButton.enabled = true;
    [self.tableview reloadData];
}
- (UIView *)lineView {
    if (_lineView == nil) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = [UIColor lightGrayColor];
        [self.selecBar addSubview:_lineView];
        [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.selecBar);
            make.height.mas_equalTo(1 / UIScreen.mainScreen.scale);
        }];
    }
    return _lineView;
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
//    self.navigationController.navigationBarHidden = true;
}
#pragma mark tapGestureRecgnizerdelegate 解决手势冲突
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if ([touch.view isKindOfClass:[UITableView class]]){
        return NO;
    }
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {
        return NO;
    }
    return YES;
}

@end
