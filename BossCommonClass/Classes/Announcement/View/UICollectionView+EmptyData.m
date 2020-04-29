//
//  UICollectionView+EmptyData.m
//  AFNetworking
//
//  Created by 易庆萍 on 2020/4/16.
//

#import "UICollectionView+EmptyData.h"
#import "Masonry.h"
#import "BossMethodDefine.h"
#import "BossBasicDefine.h"

@implementation UICollectionView (EmptyData)
- (void)collectionViewDisplayWitMsg:(NSString *)message imageName:(NSString *)imgName ifNecessaryForRowCount:(NSUInteger)rowCount{
    if (rowCount == 0) {
        UIView *noDataView = [[UIView alloc] init];
        noDataView.backgroundColor = [UIColor whiteColor];
        self.backgroundView = noDataView;
        UIImageView *imgView = [[UIImageView alloc] init];
        UIImage *image = [UIImage imageNamed:@"NoDataIcon"];
//         [UIImage imageNamed:@"NoDataIcon" inBundle:QH_Bundle  compatibleWithTraitCollection:nil];
        //        UIImage *image = [UIImage imageNamed:@"camera"];
        imgView.image = image;
        //        imgView.backgroundColor = [UIColor redColor];
        //
        [noDataView addSubview:imgView];
        [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(noDataView);
            make.top.equalTo(noDataView).offset(150);
//            make.width.height.mas_equalTo(150);

            ////测试
            //            make.size.mas_equalTo(CGSizeMake(50, 50));
        }];
        
        UILabel *messageLabel = [[UILabel alloc] init];
        messageLabel.textColor = [UIColor colorNamed:@"boss_29314D-80_FFFFFF-90"];
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
