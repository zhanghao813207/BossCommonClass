//
//  SendMessageStartVc.m
//  BossOwner
//
//  Created by 高炀辉 on 2019/6/21.
//  Copyright © 2019 高炀辉. All rights reserved.
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

@end

@implementation SendMessageStartVc

- (void)viewDidLoad {
    [super viewDidLoad];
    self.nameLabel.text = self.name;
    self.teamLabel.text = self.teamName;
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
                [self.navigationController pushViewController:vc animated:true];
            }
        } fail:^(id error) {
            NSLog(@"%@", error);
        }];
    }
    
}


@end
