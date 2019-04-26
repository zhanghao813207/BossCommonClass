//
//  Message_summary_info.h
//  AFNetworking
//
//  Created by admin on 2019/4/24.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Message_summary_info : NSObject
@property(nonatomic, copy)NSString *_id;
@property(nonatomic, copy)NSString *content;
@property(nonatomic, copy)NSString *created_at;
@property(nonatomic, assign)NSInteger extra_type;
@property(nonatomic, assign)NSInteger message_type;
@property(nonatomic, copy)NSString *title;
@property(nonatomic, copy)NSString *time;
@end

NS_ASSUME_NONNULL_END
