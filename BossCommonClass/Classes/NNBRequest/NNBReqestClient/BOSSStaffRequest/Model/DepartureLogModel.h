//
//  DepartureLogModel.h
//  Pods-BossKnight
//
//  Created by 贾远潮 on 2018/5/23.
//

#import <Foundation/Foundation.h>

@interface DepartureLogModel : NSObject

/**
 离职审核状态
 */
@property (nonatomic, assign) NSInteger state;

/**
 操作时间
 */
@property (nonatomic, strong) NSString *time;

/**
 操作人姓名
 */
@property (nonatomic, strong) NSString *operatorName;

/**
 操作时间戳
 */
@property (nonatomic, assign) NSInteger timestamp;

/**
 操作类型id
 */
@property (nonatomic, assign) NSInteger action_type_id;

/**
 操作备注
 */
@property (nonatomic, strong) NSString *action_note;

- (NSDictionary *)decodeToDic;
@end
