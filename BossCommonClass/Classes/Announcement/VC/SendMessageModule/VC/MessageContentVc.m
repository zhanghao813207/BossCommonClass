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
#import "KNPhotoBrowser.h"

@interface MessageContentVc ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *customTableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewForBottom;

@property (weak, nonatomic) IBOutlet UIView *selectImageView;
//@property (weak, nonatomic) IBOutlet NSLayoutConstraint *SelectImageViewHeight;
@property (weak, nonatomic) IBOutlet UIButton *selectImageButton;

@property (weak, nonatomic) IBOutlet UIButton *CameraButton;

@property (weak, nonatomic) IBOutlet UIButton *AddImageButton;

@property (nonatomic, strong) NSArray *contentArr;
// 底部
@property (weak, nonatomic) IBOutlet UIView *bottomLineView;

@property (nonatomic, assign) BOOL isshowImageView;
//@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomViewHeight;

@property (weak, nonatomic) IBOutlet UITextField *textFieldContent;
@property (weak, nonatomic) IBOutlet UIView *textFIeldView;
@property (nonatomic, assign) CGFloat selectImageViewY;
@end

@implementation MessageContentVc
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // 请求历史聊天记录
    
    // 注册键盘通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillChangeFrameNotification:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardDidShowNotification:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardDidHideNotification:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    // 注册一对一消息通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveMessageList:) name:@"receiveMessage" object:nil];

    [self setUI];
    
    self.contentArr = [[RealmModule sharedInstance] getMessageListSectionID:self.sectionid];
    if (self.contentArr.count > 0) {
        RealmRecordModel *model = [self.contentArr lastObject];
        [self readedmsgid:model.idField Sectionid:self.sectionid];
        
    }
    [self getNewMessageOfMsgid:nil Sectionid:self.sectionid];
    
    _isshowImageView = false;
    
    [self.AddImageButton setSelected:false];
}
- (void)setIsshowImageView:(BOOL)isshowImageView{
    _isshowImageView = isshowImageView;
    
    if (isshowImageView) {
        self.selectImageViewY = self.textFIeldView.frame.origin.y - self.selectImageView.frame.size.height;
    } else {
        self.selectImageViewY = self.textFIeldView.frame.origin.y + self.selectImageView.frame.size.height;
    }
    
    [UIView animateWithDuration:.5f animations:
     ^{
         self.selectImageView.frame = CGRectMake(self.selectImageView.frame.origin.x, self.selectImageViewY, self.selectImageView.frame.size.width, self.selectImageView.frame.size.height);
         
     } completion:^(BOOL finished) {
         
     }];
    
    
}
// 选择图片
- (IBAction)SelectImageFunction:(UIButton *)sender {
    
    if (self.isshowImageView) {
        [sender setSelected:false];
    } else {
        [sender setSelected:true];
    }
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
    self.textFieldContent.enablesReturnKeyAutomatically = YES;
    self.textFieldContent.layer.cornerRadius = 7;
    
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
    
    double delayInSeconds = 0.1;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        
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
//-(void)keyboardDidShowNotification:(NSNotification *)note{
//    CGRect frame = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
//    self.viewForBottom.constant = -([UIScreen mainScreen].bounds.size.height - frame.origin.y - 34);
//}
-(void)keyboardDidHideNotification:(NSNotification *)note{
    
//    CGRect frame = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
//    self.viewForBottom.constant = -([UIScreen mainScreen].bounds.size.height - frame.origin.y);
}
-(void)keyboardWillChangeFrameNotification:(NSNotification *)note{
    //获取键盘的饿frame
    CGRect frame = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    //让TextFiled的底部约束间距为屏幕高度减去键盘顶部的y值即可
    //注意 这里不要使其等于键盘的高度，因为高度时死的，会导致键盘下去后，TextField并未下去的结果。
    if (self.viewForBottom.constant <= -([UIScreen mainScreen].bounds.size.height - frame.origin.y - self.bottomLineView.frame.size.height)) {
        self.viewForBottom.constant = -([UIScreen mainScreen].bounds.size.height - frame.origin.y);
    } else {
        self.viewForBottom.constant = -([UIScreen mainScreen].bounds.size.height - frame.origin.y - self.bottomLineView.frame.size.height);
    }
    //获取键盘的动画时间，使TextField与键盘的形态一致
    CGFloat interval = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    //设置Text的动画
    [UIView animateWithDuration:interval animations:^{
        
        //注意这里不是改变值，之前已经改变值了，
        //在这里需要做的事强制布局
        [self.view layoutIfNeeded];
        
    }];
    self.isshowImageView = false;
    [self.AddImageButton setSelected:false];
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
// 上传图片
- (void)getQiniuTockenforImage:(UIImage *)Image {
    WS(weakSelf);
    [NNBUtilRequest UtilRequestGetQNTokenWithOperateType:nil Success:^(NSString *path, NSString *qiniu_token) {
        NSLog(@"%@, %@", path, qiniu_token);
        if (qiniu_token) {
            UIImage *imageNew = [NNBUploadManager compressionImage:Image proportion:1];
            NSData *data = [JYCSimpleToolClass dataByImage:imageNew];
            [[NNBUploadManager defaultManager] putData:data key:path token:qiniu_token progressHandler:^(NSString *key, float percent) {
                DLog(@"key = %@,percent = %f", key, percent);
            } complete:^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
                DLog(@"%@", info);
                DLog(@"%@", key);
                DLog(@"%@",resp);
                [weakSelf addmedia:key];

            } fail:^(id error) {
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
    // 聊天图片处理
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
        cell.sendInfoNameLabel.text = [kCurrentBossOwnerAccount.accountModel.name substringFromIndex:kCurrentBossOwnerAccount.accountModel.name.length - 1];
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
        cell.sendInfoNameLabel.text = [kCurrentBossOwnerAccount.accountModel.name substringFromIndex:kCurrentBossOwnerAccount.accountModel.name.length - 1];
        cell.imageclick = ^{
            RealmRecordModel *selectmodel = self.contentArr[indexPath.row];
            if (selectmodel.messageMimeKind == 40) {
                
                NSMutableArray *imageArr = [NSMutableArray array];
                NSMutableArray *imageModelArr = [NSMutableArray array];
                for (RealmRecordModel *model in self.contentArr) {
                    if (model.messageMimeKind == 40) {
                        KNPhotoItems *items = [[KNPhotoItems alloc] init];
                        if (model.mediaInfoList.count > 0) {
                            mediainfoListModel *rmodel = [[mediainfoListModel alloc] initWithValue:model.mediaInfoList[0]];
                            items.url = rmodel.url;
                            [imageArr addObject:items];
                        }
                        [imageModelArr addObject:model];
                    }
                }
                if ([imageModelArr containsObject:selectmodel]) {
                    NSInteger index = [imageModelArr indexOfObject:selectmodel];
                    NSLog(@"-1---%ld---",index);
                    KNPhotoBrowser *photoBrower = [[KNPhotoBrowser alloc] init];
                    photoBrower.itemsArr = [imageArr copy];
                    photoBrower.isNeedPageControl = true;
                    photoBrower.isNeedPageNumView = true;
                    photoBrower.isNeedRightTopBtn = true;
                    photoBrower.isNeedPictureLongPress = true;
                    photoBrower.isNeedPrefetch = true;
                    photoBrower.isNeedPictureLongPress = false;
                    photoBrower.currentIndex = index;
                    [photoBrower present];
                }
            }
        };
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
        cell.receiveInfoNameLabel.text = [self.title substringFromIndex:self.title.length - 1];
        
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
        cell.imageclick = ^{
            RealmRecordModel *selectmodel = self.contentArr[indexPath.row];
            if (selectmodel.messageMimeKind == 40) {
                
                NSMutableArray *imageArr = [NSMutableArray array];
                NSMutableArray *imageModelArr = [NSMutableArray array];
                for (RealmRecordModel *model in self.contentArr) {
                    if (model.messageMimeKind == 40) {
                        KNPhotoItems *items = [[KNPhotoItems alloc] init];
                        if (model.mediaInfoList.count > 0) {
                            mediainfoListModel *rmodel = [[mediainfoListModel alloc] initWithValue:model.mediaInfoList[0]];
                            items.url = rmodel.url;
                            [imageArr addObject:items];
                        }
                        [imageModelArr addObject:model];
                    }
                }
                if ([imageModelArr containsObject:selectmodel]) {
                    NSInteger index = [imageModelArr indexOfObject:selectmodel];
                    NSLog(@"-1---%ld---",index);
                    KNPhotoBrowser *photoBrower = [[KNPhotoBrowser alloc] init];
                    photoBrower.itemsArr = [imageArr copy];
                    photoBrower.isNeedPageControl = true;
                    photoBrower.isNeedPageNumView = true;
                    photoBrower.isNeedRightTopBtn = true;
                    photoBrower.isNeedPictureLongPress = true;
                    photoBrower.isNeedPrefetch = true;
                    photoBrower.isNeedPictureLongPress = false;
                    photoBrower.currentIndex = index;
                    [photoBrower present];
                }
            }
        };
        cell.receiveInfoNameLabel.text = [self.title substringFromIndex:self.title.length - 1];
        return cell;
        
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
}
// 解决手势冲突
//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
//    if (touch.view != self.customTableView) {
//        return NO;
//    }else {
//        return YES;
//    }
//}
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
        // 通讯录
    } fail:^(id error) {
        [self.view endEditing:true];
        if (Block) {
            Block(false);
        }
//        [self.view showAnimationErrorStaus:@"发送失败" completion:nil];
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
