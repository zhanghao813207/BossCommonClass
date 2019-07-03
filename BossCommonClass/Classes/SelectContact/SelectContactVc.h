//
//  SelectContactVc.h
//  BossCommonClass
//
//  Created by 高炀辉 on 2019/6/17.
//

#import <UIKit/UIKit.h>
#import "BossViewController.h"
NS_ASSUME_NONNULL_BEGIN
typedef void(^selectArrBlock)(NSMutableArray *arr);
@interface SelectContactVc : BossViewController

@property (nonatomic, copy)selectArrBlock selectArrBlock;
@property (nonatomic,strong) NSMutableArray *contentArr;
@property (nonatomic, strong)NSString *wppId;
@end

NS_ASSUME_NONNULL_END
