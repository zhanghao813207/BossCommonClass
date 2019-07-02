//
//  ChooseImageVc.m
//  BossCommonClass
//
//  Created by 高炀辉 on 2019/7/2.
//

#import "ChooseImageVc.h"

@interface ChooseImageVc ()
@property (weak, nonatomic) IBOutlet UIImageView *chooseImageView;

@end

@implementation ChooseImageVc

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:true];
    self.chooseImageView.image = self.image;
}
- (IBAction)pop:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:true];
}
- (IBAction)choose:(UIButton *)sender {
    
    if (self.chooseImageBlock2){
        self.chooseImageBlock2(self.image);
    }
    
    [self dismissViewControllerAnimated:true completion:nil];
//    self.dismiss(animated: true, completion: nil)
}


@end
