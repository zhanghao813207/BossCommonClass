//
//  PostModel.h
//  AFNetworking
//
//  Created by 张浩 on 2019/6/10.
//

#import <Foundation/Foundation.h>
#import "AccountModel.h"

NS_ASSUME_NONNULL_BEGIN

/**
 岗位信息
 */
@interface PostModel : NSObject

/**
 岗位id
 */
@property (nonatomic, strong) NSString *_id;

/**
 岗位名称
 */
@property (nonatomic, strong) NSString *post_name;

/**
 岗位审批人摘要列表
 */
@property (nonatomic, strong) NSArray <AccountModel *> *account_info_list;

@end

NS_ASSUME_NONNULL_END
