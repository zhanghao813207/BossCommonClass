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


@interface MessageContentVc ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *customTableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewForBottom;
@property (nonatomic, strong) NSMutableArray *contentArr;
@end

@implementation MessageContentVc

- (void)viewDidLoad {
    [super viewDidLoad];
    //键盘通知
    self.contentArr = [[NSMutableArray alloc] init];

    [self.customTableView setContentOffset:CGPointMake(0, self.customTableView.contentSize.height -self.customTableView.bounds.size.height) animated:YES];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillChangeFrameNotification:) name:UIKeyboardWillChangeFrameNotification object:nil];
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
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"userid = %@ AND sectionid = %@",
                         kCurrentBossOwnerAccount.accountModel.accountId,self.sectionid];
    [self.contentArr removeAllObjects];
    RLMResults<realmMessageModel *> *puppies = [realmMessageModel objectsWithPredicate:pred];
    if (puppies.count > 0) {
        realmMessageModel *puppies2 = [puppies firstObject];
        for (RLMObject *object in puppies2.realmRecordModel) {
            RealmRecordModel *model = [[RealmRecordModel alloc] initWithValue:object];
            [self.contentArr addObject:model];
        }
        return self.contentArr.count;
    } else {
        return 0;
    }
    
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
    NSLog(@"点击了发送");
    if (textField.text) {
        RLMRealm *realm = [RLMRealm defaultRealm];
        
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"userid = %@ AND sectionid = %@",
                             kCurrentBossOwnerAccount.accountModel.accountId,self.sectionid];
        
        RLMResults<realmMessageModel *> *puppies = [realmMessageModel objectsWithPredicate:pred];
        // 根据用户ID 查找
        realmMessageModel *MessageModel = [puppies firstObject];
        
        [NNBBasicRequest postJsonWithUrl:MessageBasicURLV2  parameters:@{@"session_id": self.sectionid, @"message_mime_kind": @(10), @"content": textField.text} CMD:@"ums.chat.add" success:^(id responseObject) {
            BOOL isok = responseObject[@"ok"];
            if (isok){
                NSDictionary *dic = responseObject[@"record"];
                // 子Model
                RealmRecordModel *model = [[RealmRecordModel alloc] initWithDictionary:dic];
                
                if (MessageModel) {
                    // 存到本地
                    [realm transactionWithBlock:^{
                        [MessageModel.realmRecordModel addObject:model];
                    }];
                } else {
                    // 第一次缓存
                    if (self.targetid && kCurrentBossOwnerAccount.accountModel.accountId) {
                        NSDictionary *basedic = @{
                                                  @"userid": kCurrentBossOwnerAccount.accountModel.accountId,
                                                  @"realmRecordModel" : @[model.toDictionary],
                                                  @"sectionid": self.sectionid
                                                  };
                        realmMessageModel *baseModel = [[realmMessageModel alloc] initWithDictionary:basedic];
                        [realm transactionWithBlock:^{
                            [realm addObject:baseModel];
                        }];
                    }
                }
                [self.customTableView reloadData];
            }
        } fail:^(id error) {
            NSLog(@"%@", error);
        }];
    }
    
    return YES;
}
@end
