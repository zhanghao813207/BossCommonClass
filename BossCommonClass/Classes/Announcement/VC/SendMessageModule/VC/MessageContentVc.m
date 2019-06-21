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

@interface MessageContentVc ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *customTableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewForBottom;

@end

@implementation MessageContentVc

- (void)viewDidLoad {
    [super viewDidLoad];
    //简历通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillChangeFrameNotification:) name:UIKeyboardWillChangeFrameNotification object:nil];
}
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
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.row == 2) {
        ReceiveImageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ReceiveICell" forIndexPath:indexPath];
        return cell;
    } else if (indexPath.row == 0) {
        ReceiveMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ReceiveMCell" forIndexPath:indexPath];
        if (indexPath.row == 0) {
            cell.contentLabel.text = @"你好";
        }
        return cell;
    } else if (indexPath.row == 3){
        SendImageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SendICell" forIndexPath:indexPath];
        return cell;
    } else {
        SendMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SendMCell" forIndexPath:indexPath];
        if (indexPath.row == 3) {
            cell.contentLabel.text = @"你好";
        }
        return cell;
    }
    
}

@end
