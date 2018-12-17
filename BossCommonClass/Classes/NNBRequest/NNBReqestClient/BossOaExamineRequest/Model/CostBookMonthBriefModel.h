//
//  CostBookMonthBriefModel.h
//  BossCommonClass
//
//  Created by 贾远潮 on 2018/12/14.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CostBookMonthBriefModel : NSObject

@property (nonatomic, strong) NSString *_id;

@property (nonatomic, strong) NSString *accounting_id;

@property (nonatomic, strong) NSString *cost_target_id;

@property (nonatomic, assign) NSInteger book_month;

@property (nonatomic, assign) NSInteger money;

@end

NS_ASSUME_NONNULL_END
