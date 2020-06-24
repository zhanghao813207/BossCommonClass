//
//  AgreementVc.h
//  BossCommonClass
//
//  Created by 高炀辉 on 2019/5/7.
//

#import <UIKit/UIKit.h>
#import "BossViewController.h"
NS_ASSUME_NONNULL_BEGIN

typedef void(^AgreementBackBlock)(void); //返回

@interface AgreementVc : BossViewController

@property (nonatomic, strong) NSString *url;

@property (nonatomic, assign) BOOL isAddPresent;

@property (nonatomic, copy) AgreementBackBlock backBlock;

@end

NS_ASSUME_NONNULL_END
