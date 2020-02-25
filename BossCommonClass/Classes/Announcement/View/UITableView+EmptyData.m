
//
//  UITableView+EmptyData.m
//  BossCommonClass
//
//  Created by admin on 2019/4/19.
//qhbad

#import "UITableView+EmptyData.h"
#import "Masonry.h"
#import "BossMethodDefine.h"
#import "BossBasicDefine.h"

@implementation UITableView (EmptyData)
- (void) tableViewDisplayWitMsg:(NSString *)message imageName:(NSString *)imgName ifNecessaryForRowCount:(NSUInteger)rowCount {
    if (rowCount == 0) {
        UIView *noDataView = [[UIView alloc] init];
        noDataView.backgroundColor = [UIColor whiteColor];
        self.backgroundView = noDataView;
        UIImageView *imgView = [[UIImageView alloc] init];
        UIImage *image = [UIImage imageNamed:@"NoDataIcon" inBundle:QH_Bundle  compatibleWithTraitCollection:nil];
        //        UIImage *image = [UIImage imageNamed:@"camera"];
        imgView.image = image;
//        imgView.backgroundColor = [UIColor redColor];
//
        
        [noDataView addSubview:imgView];
        [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(noDataView);
            make.top.equalTo(noDataView).offset(150);
            ////测试
//            make.size.mas_equalTo(CGSizeMake(50, 50));
        }];
      
        UILabel *messageLabel = [[UILabel alloc] init];
        messageLabel.textColor = kHexRGBA(0x29314D, 0.8);
        messageLabel.font = [UIFont fontWithName:@"PingFangSC" size: 16];
        messageLabel.text = message;
        [noDataView addSubview:messageLabel];
        [messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(imgView.mas_bottom).offset(20);
            make.centerX.equalTo(self);
        }];
        
    }else {
        self.backgroundView = nil;
    }
}
@end
