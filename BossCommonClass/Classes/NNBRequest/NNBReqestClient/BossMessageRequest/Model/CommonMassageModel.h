//
//  CommonMassageModel.h
//  AFNetworking
//
//  Created by 贾远潮 on 2018/9/2.
//

#import <Foundation/Foundation.h>
#import "BossBasicDefine.h"
#import "AccountModel.h"
@interface CommonMassageModel : NSObject

/**
 消息ID
 */
@property (nonatomic, strong) NSString *_id;

/**
 消息总线ID
 */
@property (nonatomic, strong) NSString *channel_id;

/**
 业务模块ID
 */
@property (nonatomic, strong) NSString *biz_channel_id;

/**
 消息类型 1（新）90（已送达）100（已读）-100（已删除）
 */
@property (nonatomic, assign) MESSAGE_TYPE state;

/**
 1(全局) 10(定向)
 */
@property (nonatomic, assign) BROAD_TYPE broad_type;


/**
 定向接收人账号
 */
@property (nonatomic, assign) NSArray <AccountModel *>*accounts;

/**
 更新时间
 */
@property (nonatomic, strong) NSString *updated_at;

/**
 创建时间
 */
@property (nonatomic, strong) NSString *created_at;

/**
 微信格式的创建时间
 */
@property (nonatomic, strong) NSString *wchat_created_at;

/**
 微信格式的标题创建时间
 */
@property (nonatomic, strong) NSString *wchat_title_created_at;

@end
