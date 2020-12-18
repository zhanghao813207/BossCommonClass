
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

@property(nonatomic, strong)NSMutableDictionary *titleDict;
@property(nonatomic, strong)NSMutableArray *titleArr;

@end

@implementation PersonAddressBookVC

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = kHexRGB(0xF9FBFC);
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
//    [self selecBar];
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
        [self sortObjectsAccordingToInitialWith:self.arrM];
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

-(void)sortObjectsAccordingToInitialWith:(NSArray *)arr {
    
    self.titleDict = [NSMutableDictionary dictionary];
    self.titleArr = [NSMutableArray array];
    for (ContactsPerson *model in arr) {
       
        //获取到姓名的大写首字母
          NSString *firstLetterString = [self getFirstLetterFromString:model.nick_name];
          //如果该字母对应的联系人模型不为空,则将此联系人模型添加到此数组中
          if (self.titleDict[firstLetterString])
          {
              [self.titleDict[firstLetterString] addObject:model];
          }else//没有出现过该首字母，则在字典中新增一组key-value
          {
              //创建新发可变数组存储该首字母对应的联系人模型
              NSMutableArray *arrGroupNames = [NSMutableArray array];
              [arrGroupNames addObject:model];
              //将首字母-姓名数组作为key-value加入到字典中
              [self.titleDict setObject:arrGroupNames forKey:firstLetterString];
          }
    }
    
     NSArray *nameKeys  = [[self.titleDict allKeys] sortedArrayUsingSelector:@selector(compare:)];
    self.titleArr = nameKeys.mutableCopy;
       // 将 "#" 排列在 A~Z 的后面
       if ([nameKeys.firstObject isEqualToString:@"#"])
       {
           NSMutableArray *mutableNamekeys = [NSMutableArray arrayWithArray:nameKeys];
           [mutableNamekeys insertObject:nameKeys.firstObject atIndex:nameKeys.count];
           [mutableNamekeys removeObjectAtIndex:0];
           self.titleArr = mutableNamekeys;
       }

}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.titleArr.count;
}
//返回每个section的title
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    return self.titleArr[section];
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return self.titleArr;
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
    view.backgroundColor = [UIColor colorNamed:@"boss_F3F3F3_000000"];
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(10, 0, 100, 35);
    label.textColor = [UIColor colorNamed:@"boss_000000_FFFFFF"];
    label.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
    label.text = self.titleArr[section];
    [view addSubview:label];
    return view;
}
// 获取字符首字母拼音
- (NSString *)getFirstLetterFromString:(NSString *)aString
{
    NSMutableString *mutableString = [NSMutableString stringWithString:aString];
    CFStringTransform((CFMutableStringRef)mutableString, NULL, kCFStringTransformToLatin, NO);
    NSString *pinyinString = [mutableString stringByFoldingWithOptions:NSDiacriticInsensitiveSearch locale:[NSLocale currentLocale]];
    // 将拼音首字母装换成大写
    NSString *strPinYin = [[self polyphoneStringHandle:aString pinyinString:pinyinString] uppercaseString];
   // 截取大写首字母
   NSString *firstString = [strPinYin substringToIndex:1];
   // 判断姓名首位是否为大写字母
   NSString * regexA = @"^[A-Z]$";
   NSPredicate *predA = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regexA];
   // 获取并返回首字母
   return [predA evaluateWithObject:firstString] ? firstString : @"#";
       
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSString * firstStr = self.titleArr[section];
    NSMutableArray *contentArr = [self.titleDict valueForKey:firstStr];
    return contentArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PersonAddressBookCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    NSString * firstStr = self.titleArr[indexPath.section];
    NSMutableArray *contentArr = [self.titleDict valueForKey:firstStr];
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
//        NSMutableArray *contentArr = self.userContentArr[indexPath.section];
        NSString * firstStr = self.titleArr[indexPath.section];
        NSMutableArray *contentArr = [self.titleDict valueForKey:firstStr];
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


// 多音字处理
 - (NSString *)polyphoneStringHandle:(NSString *)aString pinyinString:(NSString *)pinyinString
{
    if ([aString hasPrefix:@"长"]) { return @"chang";}
    if ([aString hasPrefix:@"沈"]) { return @"shen"; }
    if ([aString hasPrefix:@"厦"]) { return @"xia";  }
    if ([aString hasPrefix:@"地"]) { return @"di";   }
    if ([aString hasPrefix:@"重"]) { return @"chong";}
    return pinyinString;
}
@end
