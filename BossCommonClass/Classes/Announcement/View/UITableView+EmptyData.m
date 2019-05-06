
//
//  UITableView+EmptyData.m
//  BossCommonClass
//
//  Created by admin on 2019/4/19.
//

#import "UITableView+EmptyData.h"
#import "Masonry.h"
#import "BossMethodDefine.h"

@implementation UITableView (EmptyData)
- (void) tableViewDisplayWitMsg:(NSString *)message imageName:(NSString *)imgName ifNecessaryForRowCount:(NSUInteger)rowCount {
    if (rowCount == 0) {
        UIView *noDataView = [[UIView alloc] init];
        self.backgroundView = noDataView;
        UIImageView *imgView = [[UIImageView alloc] init];
        UIImage *image = [UIImage imageNamed:@"ic_arrow_right" inBundle:QH_Bundle  compatibleWithTraitCollection:nil];
        //        UIImage *image = [UIImage imageNamed:@"camera"];
        imgView.image = image;
//        imgView.backgroundColor = [UIColor whiteColor];
//
        
        [noDataView addSubview:imgView];
        [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(noDataView);
            make.top.equalTo(noDataView).offset(150);
            ////测试
//            make.size.mas_equalTo(CGSizeMake(50, 50));
        }];
      
        UILabel *messageLabel = [[UILabel alloc] init];
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