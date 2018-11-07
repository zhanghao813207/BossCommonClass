//
//  BattleParamModel.h
//  AFNetworking
//
//  Created by 贾远潮 on 2018/11/7.
//

#import <Foundation/Foundation.h>
#import "LadderModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface BattleParamModel : NSObject

/**
 设定名次
 */
@property (nonatomic, assign) NSInteger rank_sum;

/**
 名次奖励
 */
@property (nonatomic, strong) NSArray <LadderModel *>*ladder;


@end

NS_ASSUME_NONNULL_END
