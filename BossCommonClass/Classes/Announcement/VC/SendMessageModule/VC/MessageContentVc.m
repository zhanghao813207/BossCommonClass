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
#import "NNBUploadManager.h"
#import "UIView+ImagePick.h"
#import "NNBUtilRequest.h"
#import "AnnouncementRequest.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "mediainfoListModel.h"
#import "JYCSimpleToolClass.h"

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

@property (nonatomic, assign) CGFloat selectImageViewY;
@end

@implementation MessageContentVc
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // 请求历史聊天记录
    
    // 注册键盘通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillChangeFrameNotification:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    // 注册一对一消息通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveMessageList:) name:@"receiveMessage" object:nil];

    [self setUI];
    
    self.contentArr = [[RealmModule sharedInstance] getMessageListSectionID:self.sectionid];
    if (self.contentArr.count > 0) {
        RealmRecordModel *model = [self.contentArr lastObject];
        [self readedmsgid:model.idField Sectionid:self.sectionid];
        
    }
    [self getNewMessageOfMsgid:nil Sectionid:self.sectionid];
}
- (void)setIsshowImageView:(BOOL)isshowImageView{
    _isshowImageView = isshowImageView;
    if (isshowImageView) {
        self.selectImageViewY = self.selectImageView.frame.origin.y - self.selectImageView.frame.size.height;
    } else {
        self.selectImageViewY = self.selectImageView.frame.origin.y + self.selectImageView.frame.size.height;
    }
    
    [UIView animateWithDuration:.5f animations:
     ^{
         self.selectImageView.frame = CGRectMake(self.selectImageView.frame.origin.x, self.selectImageViewY, self.selectImageView.frame.size.width, self.selectImageView.frame.size.height);
         
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
    
}
- (void)setUI{
    self.CameraButton.layer.cornerRadius = 20;
    self.selectImageButton.layer.cornerRadius = 20;
    if (self.isshowImageView) {
        self.isshowImageView = false;
    }
    
}
// 接收消息通知
- (void)receiveMessageList:(NSNotification *)noti{
    NSDictionary *msgDic = [noti object];
    NSDictionary *payload = msgDic[@"payload"];
    NSString * msgid = payload[@"msg_id"];
    NSString * sectionid = payload[@"session_id"];
    
    [self getNewMessageOfMsgid:msgid Sectionid:sectionid];
//    [self getContentDetaileMsgid:msgid Sectionid:sectionid];
}
- (void)viewWillDisappear:(BOOL)animated {
    // 注销消息通知
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
// 新消息来了
- (void)getContentDetaileMsgid:(NSString *)msgid Sectionid:(NSString *)sectionid{
    [NNBBasicRequest postJsonWithUrl:MessageBasicURLV2  parameters:@{@"message_id": msgid} CMD:@"ums.message.get" success:^(id responseObject) {
        NSDictionary *dic = responseObject;
        RealmRecordModel *model = [[RealmRecordModel alloc] initWithDictionary:dic];
        model.sectionid = sectionid;
        model.userid = kCurrentBossOwnerAccount.accountModel.accountId;
        [[RealmModule sharedInstance] saveMessagetoRealm:model Sectionid:sectionid];
        [self scrollViewToBottom:true];
        [self.customTableView reloadData];
    } fail:^(id error) {
        NSLog(@"%@", error);
    }];
}
/// 动画效果滚动到最末尾
- (void)scrollViewToBottom:(BOOL)animated{
//    [self.customTableView setContentOffset:CGPointMake(CGFLOAT_MAX, CGFLOAT_MAX)];
    
    double delayInSeconds = 0.1;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        
//        if ([self.contentArr count] > 1){
//            // 动画之前先滚动到倒数第二个消息
//            [self.customTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:[self.self.contentArr count] - 2 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:NO];
//        }
        //self.chatTableView.hidden = NO;
        if (self.contentArr.count > 0) {
            NSIndexPath* path = [NSIndexPath indexPathForRow:[self.contentArr count] - 1 inSection:0];
            [self.customTableView scrollToRowAtIndexPath:path atScrollPosition:UITableViewScrollPositionBottom animated:animated];
        }
    });
}
// 获取最新的消息
- (void)getNewMessageOfMsgid: (NSString *)msgid Sectionid:(NSString *)sectionid{
    
    if (sectionid) {
        [NNBBasicRequest postJsonWithUrl:MessageBasicURLV2  parameters:@{@"_meta": @{@"page": @(1),  @"limit": @(0)}, @"session_id": sectionid } CMD:@"ums.message.find_session_message" success:^(id responseObject) {
            NSArray *msgList = responseObject[@"data"];
            for (NSDictionary *dic in msgList) {
                RealmRecordModel *model = [[RealmRecordModel alloc] initWithDictionary:dic];
                model.sectionid = sectionid;
                model.userid = kCurrentBossOwnerAccount.accountModel.accountId;
                [[RealmModule sharedInstance] saveMessagetoRealm:model Sectionid:sectionid];
            }
            // 是否是当前控制器
            if ([[self getCurrentVC] isKindOfClass:[self class]]) {
                [self scrollViewToBottom:true];
                self.contentArr = [[RealmModule sharedInstance] getMessageListSectionID:self.sectionid];
                if (self.contentArr.count > 0) {
                    RealmRecordModel *model = [self.contentArr lastObject];
                    [self readedmsgid:model.idField Sectionid:sectionid];
                }
                
                [self.customTableView reloadData];
            }
            
        } fail:^(id error) {
            NSLog(@"%@", error);
        }];
    }
}
- (void)readedmsgid:(NSString *)msgid Sectionid:(NSString *)sectionid{
    
    [NNBBasicRequest postJsonWithUrl:MessageBasicURLV2  parameters:@{@"session_id": sectionid, @"last_message_id": msgid} CMD:@"ums.message.mark_read" success:^(id responseObject) {
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
    
    [self scrollViewToBottom:true];
    
}
- (void)setContentArr:(NSArray *)contentArr{
    _contentArr = contentArr;
    if (self.contentArr.count > 0) {
        [self scrollViewToBottom:false];
    }
}
- (IBAction)cameraSelect:(UIButton *)sender {
    
    // 0是相机 1是相册
    if (sender.tag == 0) {
        [sender fromCamera];
        
    } else {
        [sender fromPhotos];
    }
    [sender pickImageFromPhotoOrCameraWithImageBlock:^(UIImage *imageResult) {
        NSLog(@"%@", imageResult);
        [self getQiniuTockenforImage:imageResult];
    }];
    [sender removeImageFromPhotoOrCamera];
}
- (void)getQiniuTockenforImage:(UIImage *)Image {
    WS(weakSelf);
    [NNBUtilRequest UtilRequestGetQNTokenWithOperateType:nil Success:^(NSString *path, NSString *qiniu_token) {
        NSLog(@"%@, %@", path, qiniu_token);
        if (qiniu_token) {
            [weakSelf.view showLoadingView:@"上传中"];
            UIImage *imageNew = [NNBUploadManager compressionImage:Image proportion:1];
            NSData *data = [JYCSimpleToolClass dataByImage:imageNew];
            [[NNBUploadManager defaultManager] putData:data key:path token:qiniu_token progressHandler:^(NSString *key, float percent) {
                DLog(@"key = %@,percent = %f", key, percent);
            } complete:^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
                DLog(@"%@", info);
                DLog(@"%@", key);
                DLog(@"%@",resp);
                [weakSelf.view dismissLoadingViewWithCompletion:nil];
                
                [self addmedia:key];

            } fail:^(id error) {
                [weakSelf.view dismissLoadingViewWithCompletion:nil];
            }];
        } else {
            // 提示网络故障
            [self.view dismissLoadingViewWithCompletion:^(BOOL finish) {
                [self.view showAnimationErrorStaus:@"当前网络状态不佳，请重试" completion:nil];
            }];
        }
    } fail:nil];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    self.contentArr = [[RealmModule sharedInstance] getMessageListSectionID:self.sectionid];
    return self.contentArr.count;
}
- (NSTimeInterval)pleaseInsertStarTime:(NSString *)starTime andInsertEndTime:(NSString *)endTime{
    NSDateFormatter* formater = [[NSDateFormatter alloc] init];
    [formater setDateFormat:@"yyyy-MM-dd HH:mm:ss"];//根据自己的需求定义格式
    NSDate* startDate = [formater dateFromString:starTime];
    NSDate* endDate = [formater dateFromString:endTime];
    NSTimeInterval time = [endDate timeIntervalSinceDate:startDate];
    return time;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    RealmRecordModel *model = self.contentArr[indexPath.row];
    if (indexPath.row == 0) {
        model.isShowTime = YES;
    }
    
    if (self.contentArr.count > indexPath.row + 1) {
        RealmRecordModel *Nextmodel = self.contentArr[indexPath.row + 1];
        NSString *nextTime = [JYCSimpleToolClass fastChangeToNormalTimeWithString:Nextmodel.createdAt];
        NSString *startTime = [JYCSimpleToolClass fastChangeToNormalTimeWithString:model.createdAt];
        int a = [self pleaseInsertStarTime:startTime andInsertEndTime:nextTime];
        if (a > 180) {
            model.isShowTime = true;
        }
    }
    if (model.messageMimeKind == 10  && [model.senderId isEqualToString:[BossCache defaultCache].umsAccessTokenModel.accountId]) {
        
        SendMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SendMCell" forIndexPath:indexPath];
        cell.contentLabel.text = model.content;
        if (model.isShowTime) {
            [cell.timeLabel setHidden:false];
            cell.timeLabel.text = model.showAt_time;
        } else {
            cell.timeLabel.text = @"";
            [cell.timeLabel setHidden:true];
        }
        
        return cell;
        
    } else if (model.messageMimeKind == 40 && [model.senderId isEqualToString:[BossCache defaultCache].umsAccessTokenModel.accountId]){
        
        SendImageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SendICell" forIndexPath:indexPath];
        NSLog(@"%@", model.mediaInfoList);
        if (model.mediaInfoList.count > 0) {
            mediainfoListModel *rmodel = [[mediainfoListModel alloc] initWithValue:model.mediaInfoList[0]];
             [cell.sendImageView sd_setImageWithURL:[NSURL URLWithString: rmodel.url]];
        }
        if (model.isShowTime) {
            [cell.timeLabel setHidden:false];
            cell.timeLabel.text = model.showAt_time;
        } else {
            cell.timeLabel.text = @"";
            [cell.timeLabel setHidden:true];
        }
        return cell;
        
    } else if (![model.senderId isEqualToString:[BossCache defaultCache].umsAccessTokenModel.accountId] && model.messageMimeKind == 10) {
        
        ReceiveMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ReceiveMCell" forIndexPath:indexPath];
        cell.contentLabel.text = model.content;
        if (model.isShowTime) {
            [cell.timeLabel setHidden:false];
            cell.timeLabel.text = model.showAt_time;
        } else {
            cell.timeLabel.text = @"";
            [cell.timeLabel setHidden:true];
        }
        return cell;
        
    } else {
        
        ReceiveImageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ReceiveICell" forIndexPath:indexPath];
        if (model.mediaInfoList.count > 0) {
            mediainfoListModel *rmodel = [[mediainfoListModel alloc] initWithValue:model.mediaInfoList[0]];
            [cell.receiveImageView sd_setImageWithURL:[NSURL URLWithString: rmodel.url]];
        }
        if (model.isShowTime) {
            [cell.timeLabel setHidden:false];
            cell.timeLabel.text = model.showAt_time;
        } else {
            cell.timeLabel.text = @"";
            [cell.timeLabel setHidden:true];
        }
        return cell;
        
    }
}
- (void)addmedia:(NSString *)key{
    
    [AnnouncementRequest uploadDomain_type:Domain_typeMessage Storage_type:Storage_typeQIniu file_type:@"jpg" file_key:key Success:^(id  _Nonnull response) {
        NSArray * imageKeyArr = @[response[@"record"][@"_id"]];
        
        [self SendMessage:nil imageList: imageKeyArr type:40 SendStatusBlock:^(BOOL isSuccess) {
            // 刷新列表
            [self scrollViewToBottom:true];
            [self.customTableView reloadData];
        }];
        
    } fail:^(NSString * _Nonnull message) {
        
    }];
}
- (void)SendMessage:(NSString *)content imageList:(NSArray *)imageListarray type:(int) type SendStatusBlock:(void (^)(BOOL isSuccess))Block{
    NSDictionary *dic;
    if (type == 10) {
        dic = @{@"session_id": self.sectionid, @"message_mime_kind": @(type), @"content": content};
    } else {
        dic = @{@"session_id": self.sectionid, @"message_mime_kind": @(type), @"media_ids": imageListarray};
    }
    [NNBBasicRequest postJsonWithUrl:MessageBasicURLV2  parameters:dic CMD:@"ums.chat.add" success:^(id responseObject) {
        BOOL isok = responseObject[@"ok"];
        if (isok){
            NSDictionary *dic = responseObject[@"record"];
            // 子Model
            RealmRecordModel *model = [[RealmRecordModel alloc] initWithDictionary:dic];
            model.sectionid = self.sectionid;
            model.userid = kCurrentBossOwnerAccount.accountModel.accountId;
            // 保存记录到本地 (同步操作)
            [[RealmModule sharedInstance] saveMessagetoRealm:model Sectionid:self.sectionid];
            
            if (Block) {
               Block(true);
            }
        }
    } fail:^(id error) {
        if (Block) {
            Block(false);
        }
    }];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    textField.enablesReturnKeyAutomatically = true;
    if (textField.text && ![textField.text isEqualToString:@""]) {
        [self SendMessage:textField.text imageList:nil type:10 SendStatusBlock:^(BOOL isSuccess) {
            // 刷新列表
            textField.text = @"";
            [self scrollViewToBottom:true];
            [self.customTableView reloadData];
        }];
    }
    return YES;
}
@end
