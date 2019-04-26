//
//  Sender_info.h
//  AFNetworking
//
//  Created by admin on 2019/4/24.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Sender_info : NSObject
@property(nonatomic, copy)NSString *_id;
@property(nonatomic, copy)NSString *head_img_url;
@property(nonatomic, copy)NSString *nick_name;

/**
 自己加的属性  判断是不是自己发的
 */
@property(nonatomic, assign)BOOL isMe;
@end

NS_ASSUME_NONNULL_END
