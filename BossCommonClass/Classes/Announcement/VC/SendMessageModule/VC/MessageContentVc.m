//
//  MessageContentVc.m
//  BossOwner
//
//  Created by 高炀辉 on 2019/6/21.
//  Copyright © 2019 高炀辉. All rights reserved.
//

#import "MessageContentVc.h"
#import "ReceiveMessageCell.h"
#import "SendMessageCell.h"
#import "ReceiveImageCell.h"
#import "SendImageCell.h"
#import "NNBBasicRequest.h"
#import "BossConstDataDefine.h"
#import "SendResultModel.h"
#import "RLMRealm.h"
#import "realmMessageModel.h"
#import "RealmRecordModel.h"
#import "BossOwnerAccount.h"
#import "BossCache.h"
#import "RealmModule.h"


@interface MessageContentVc ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *customTableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewForBottom;

@property (weak, nonatomic) IBOutlet UIView *selectImageView;
//@property (weak, nonatomic) IBOutlet NSLayoutConstraint *SelectImageViewHeight;
@property (weak, nonatomic) IBOutlet UIButton *selectImageButton;
@property (weak, nonatomic) IBOutlet UIButton *CameraButton;

@property (weak, nonatomic) IBOutlet UIButton *AddImageButton;

@property (nonatomic, strong) NSArray *contentArr;

@property (nonatomic, assign) BOOL isshowImageView;

@property (nonatomic, assign) CGFloat selectImageViewheight;
@end

@implementation MessageContentVc
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // 请求历史聊天记录
    [self setUI];
    
}
- (void)setIsshowImageView:(BOOL)isshowImageView{
    _isshowImageView = isshowImageView;
    if (isshowImageView) {
        self.selectImageViewheight = 128;
    } else {
        self.selectImageViewheight = 0;
    }
    
    [UIView animateWithDuration:1 animations:
     ^{
         self.selectImageView.frame = CGRectMake(0, self.selectImageView.frame.origin.y + self.selectImageViewheight, self.selectImageView.frame.size.width, 0);//可以在completion里继续写动画
     } completion:^(BOOL finished) {
         
     }];
}
// 选择图片
- (IBAction)SelectImageFunction:(UIButton *)sender {
    
    self.isshowImageView = !self.isshowImageView;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    //键盘通知
    self.contentArr = [[NSMutableArray alloc] init];
    
    // 注册键盘通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillChangeFrameNotification:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    // 注册一对一消息通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveMessageList:) name:@"receiveMessage" object:nil];
    
    
}
- (void)setUI{
    self.CameraButton.layer.cornerRadius = 20;
    self.selectImageButton.layer.cornerRadius = 20;
    self.isshowImageView = false;
}
- (void)receiveMessageList:(NSNotification *)noti{
    NSDictionary *msgDic = [noti object];
    NSDictionary *payload = msgDic[@"payload"];
    NSString * msgid = payload[@"msg_id"];
    NSString * sectionid = payload[@"session_id"];
    [self getNewMessageOfMsgid:msgid Sectionid:sectionid];
}
- (void)viewWillDisappear:(BOOL)animated {
    // 注销消息通知
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
// 获取最新的消息
- (void)getNewMessageOfMsgid: (NSString *)msgid Sectionid:(NSString *)sectionid{
    
    if (msgid && sectionid) {
        [NNBBasicRequest postJsonWithUrl:MessageBasicURLV2  parameters:@{@"_meta": @{@"page": @(0),  @"limit": @(300)},@"session_id": sectionid, @"last_message_id": msgid, @"sort_type": @(20)} CMD:@"ums.message.find_session_message" success:^(id responseObject) {
            NSArray *msgList = responseObject[@"data"];
            if (msgList.count > 0) {
                NSDictionary *dic = msgList[0];
                RealmRecordModel *model = [[RealmRecordModel alloc] initWithDictionary:dic];
                [[RealmModule sharedInstance] saveMessagetoRealm:model Sectionid:sectionid];
            }
            // 是否是当前控制器
            if ([[self getCurrentVC] isKindOfClass:[self class]]) {
                [self.customTableView reloadData];
            }
            
        } fail:^(id error) {
            NSLog(@"%@", error);
        }];
    }
}
- (void)readedmsgid:(NSString *)msgid Sectionid:(NSString *)sectionid{
    [NNBBasicRequest postJsonWithUrl:MessageBasicURLV2  parameters:@{@"session_id": sectionid, @"last_message_id": msgid} CMD:@"ums.message.mark_read" success:^(id responseObject) {
        [self getNewMessageOfMsgid:msgid Sectionid:sectionid];
        NSLog(@"%@", responseObject);
    } fail:^(id error) {
        NSLog(@"%@", error);
    }];
}
// 获取当前显示控制器
- (UIViewController *)getCurrentVC
{
    UIViewController *result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    if ([window subviews].count>0) {
        UIView *frontView = [[window subviews] objectAtIndex:0];
        id nextResponder = [frontView nextResponder];
        
        if ([nextResponder isKindOfClass:[UIViewController class]]){
            result = nextResponder;
        }
        else{
            result = window.rootViewController;
        }
    }
    else{
        result = window.rootViewController;
    }
    if ([result isKindOfClass:[UITabBarController class]]) {
        result = [((UITabBarController*)result) selectedViewController];
    }
    if ([result isKindOfClass:[UINavigationController class]]) {
        result = [((UINavigationController*)result) visibleViewController];
    }
    
    return result;
}
// 键盘通知
-(void)keyboardWillChangeFrameNotification:(NSNotification *)note{
    //获取键盘的饿frame
    CGRect frmae = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    //让TextFiled的底部约束间距为屏幕高度减去键盘顶部的y值即可
    //注意 这里不要使其等于键盘的高度，因为高度时死的，会导致键盘下去后，TextField并未下去的结果。
    self.viewForBottom.constant = -([UIScreen mainScreen].bounds.size.height - frmae.origin.y);
    
    //获取键盘的动画时间，使TextField与键盘的形态一致
    CGFloat interval = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    //设置Text的动画
    [UIView animateWithDuration:interval animations:^{
        
        //注意这里不是改变值，之前已经改变值了，
        //在这里需要做的事强制布局
        [self.view layoutIfNeeded];
        
    }];
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    self.contentArr = [[RealmModule sharedInstance] getMessageListSectionID:self.sectionid];
    return self.contentArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RealmRecordModel *model = self.contentArr[indexPath.row];
    NSLog(@"%@", [BossCache defaultCache].umsAccessToken);
    if (model.messageMimeKind == 10  && [model.senderId isEqualToString:[BossCache defaultCache].umsAccessTokenModel.accountId]) {
        SendMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SendMCell" forIndexPath:indexPath];
        cell.contentLabel.text = model.content;
        return cell;
    } else if (model.messageMimeKind == 40 && [model.senderId isEqualToString:[BossCache defaultCache].umsAccessTokenModel.accountId]){
        SendImageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SendICell" forIndexPath:indexPath];
        return cell;
    } else if (![model.senderId isEqualToString:[BossCache defaultCache].umsAccessTokenModel.accountId] && model.messageMimeKind == 10) {
        ReceiveMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ReceiveMCell" forIndexPath:indexPath];
        cell.contentLabel.text = model.content;
        return cell;
    } else {
        ReceiveImageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ReceiveICell" forIndexPath:indexPath];
        return cell;
    }
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    textField.enablesReturnKeyAutomatically = true;
    if (textField.text && ![textField.text isEqualToString:@""]) {
        
        [NNBBasicRequest postJsonWithUrl:MessageBasicURLV2  parameters:@{@"session_id": self.sectionid, @"message_mime_kind": @(10), @"content": textField.text} CMD:@"ums.chat.add" success:^(id responseObject) {
            BOOL isok = responseObject[@"ok"];
            if (isok){
                NSDictionary *dic = responseObject[@"record"];
                // 子Model
                RealmRecordModel *model = [[RealmRecordModel alloc] initWithDictionary:dic];
                // 保存记录到本地 (同步操作)
                [[RealmModule sharedInstance] saveMessagetoRealm:model Sectionid:self.sectionid];
                // 消息置空
                textField.text = @"";
                // 设为不可点击
                
                // 刷新列表
                [self.customTableView reloadData];
            }
        } fail:^(id error) {
            NSLog(@"%@", error);
        }];
    }
    return YES;
}
@end
