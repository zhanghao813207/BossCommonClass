//
//  SelectLocationVc.h
//  BossCommonClass
//
//  Created by 高炀辉 on 2020/2/9.
//

#import <UIKit/UIKit.h>
#import "BossViewController.h"
#import "joinedRootClass.h"

typedef void(^selectLocationBlock)(joinedData * _Nullable model);
typedef void(^selectcancleBlock)(void);
NS_ASSUME_NONNULL_BEGIN

@interface SelectLocationVc : BossViewController

@property (nonatomic, copy)selectLocationBlock selectLocationBlock;

@property (nonatomic, copy)selectcancleBlock selectcancleBlock;

@property (nonatomic, strong)NSMutableArray *TeamListArray;

@end

NS_ASSUME_NONNULL_END
