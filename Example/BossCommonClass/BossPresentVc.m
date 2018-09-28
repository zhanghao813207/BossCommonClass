//
//  BossPresentVc.m
//  BossCommonClass_Example
//
//  Created by 贾远潮 on 2018/9/19.
//  Copyright © 2018年 JiaYuanchao. All rights reserved.
//

#import "BossPresentVc.h"
#import "BossDismissTranstion.h"
@interface BossPresentVc ()


@end

@implementation BossPresentVc

- (instancetype)init
{
    if (self = [super init]) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"presentVc";
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 50, 200, 50)];
    label.text = @"presentVc";
    
    label.backgroundColor = [UIColor greenColor];
    
    [self.view addSubview:label];
}





/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
