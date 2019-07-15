//
//  Message_counter_info.h
//  AFNetworking
//
//  Created by admin on 2019/4/25.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Message_counter_info : NSObject
@property(nonatomic, strong)NSString *_id;

/**
 已读数
 */
@property(nonatomic, assign)NSInteger read_counter;

/**
 已接受数
 */
@property(nonatomic, assign)NSInteger receive_counter;

/**
 总数
 */
@property(nonatomic, assign)NSInteger total_counter;

@end

NS_ASSUME_NONNULL_END
