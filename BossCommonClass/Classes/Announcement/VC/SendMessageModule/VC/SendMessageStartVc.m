//
//  SendMessageStartVc.m
//  BossOwner
//
//  Created by 高炀辉 on 2019/6/21.
//  Copyright © 2019 欧客云. All rights reserved.
//

#import "SendMessageStartVc.h"
#import "MessageContentVc.h"
#import "NNBBasicRequest.h"
#import "BossConstDataDefine.h"
#import "MessageContentVc.h"
#import "UIViewController+StoryBoard.h"
#import "recordModel.h"

@interface SendMessageStartVc ()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *teamLabel;
@property (weak, nonatomic) IBOutlet UIView *sendMessageView;

@end

@implementation SendMessageStartVc

- (void)viewDidLoad {
    [super viewDidLoad];
    self.nameLabel.text = self.name;
    self.teamLabel.text = self.teamName;
    
    self.headerNameLabel.text = [self.name substringFromIndex:self.name.length - 1];
    self.headerLabelView.layer.cornerRadius = 67 / 2;
    self.sendMessageView.hidden = YES;
    
    self.view.backgroundColor = [UIColor colorNamed:@"bgcolor_F5F5F5_000000"];
}
- (IBAction)beginSendMessage:(UITapGestureRecognizer *)sender {
    if (self.targetid){
        [NNBBasicRequest postJsonWithUrl:MessageBasicURLV2  parameters:@{@"target_id": self.targetid, @"target_type": @(20)} CMD:@"ums.chat.bind" success:^(id responseObject) {
            BOOL isok = responseObject[@"ok"];
            if (isok){
                MessageContentVc *vc = [MessageContentVc storyBoardCreateViewControllerWithBundle:@"BossCommonClass" StoryBoardName:@"EntrustAccountRegistration"];
                NSDictionary *dic = responseObject[@"record"];
                recordModel *recordmodel = [[recordModel alloc] initWithDictionary:dic];
                vc.sectionid = recordmodel.idField;
                vc.targetid = self.targetid;
                vc.title = self.name;
                [self.navigationController pushViewController:vc animated:true];
            }
        } fail:^(id error) {
            NSLog(@"%@", error);
        }];
    }
    
}


@end
