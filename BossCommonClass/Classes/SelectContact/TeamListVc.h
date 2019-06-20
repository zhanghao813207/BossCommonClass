//
//  TeamListVc.h
//  BossCommonClass
//
//  Created by 高炀辉 on 2019/6/17.
//

#import <UIKit/UIKit.h>
#import "BossViewController.h"
NS_ASSUME_NONNULL_BEGIN
//
typedef void(^selectStatus_type2)(NSInteger , int );

@interface TeamListVc : BossViewController
@property (nonatomic,strong) NSArray *contentArr;
@property (nonatomic,assign) NSInteger index;
@property (nonatomic,assign) NSInteger SupplierIndex;
@property (nonatomic,assign) NSInteger cityIndex;
@property (nonatomic,copy) selectStatus_type2 selectStatus_type;
// 团队名
@property (nonatomic, strong) NSString *supplierTitle;
// 团队名
@property (nonatomic, strong) NSString *platformTitle;

@property (nonatomic,strong) NSArray *allContentArr;

@end

NS_ASSUME_NONNULL_END
