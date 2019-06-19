//
//  SupplierVc.h
//  BossCommonClass
//
//  Created by 高炀辉 on 2019/6/17.
//

#import <UIKit/UIKit.h>
#import "BossViewController.h"
NS_ASSUME_NONNULL_BEGIN
// type 0 全没 1 全中 2部分
typedef void(^selectStatus_type2)(NSInteger , int);

@interface SupplierVc : BossViewController

@property (nonatomic,strong) NSArray *contentArr;
// 是否全部选中
@property (nonatomic,strong) NSString *platformType;
@property (nonatomic,assign) NSInteger index;

@property (nonatomic,copy) selectStatus_type2 selectStatus_type;
@end

NS_ASSUME_NONNULL_END
