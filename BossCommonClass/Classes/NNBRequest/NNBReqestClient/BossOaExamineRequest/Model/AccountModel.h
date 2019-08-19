//
//  AccountModel.h
//  AFNetworking
//
//  Created by 贾远潮 on 2018/8/24.
//

#import <Foundation/Foundation.h>
#import "BossBasicDefine.h"

@interface AccountModel : NSObject

/**
 id
 */
@property (nonatomic, strong) NSString *_id;

/**
 姓名
 */
@property (nonatomic, strong) NSString *name;

/**
 职位id
 */
@property (nonatomic, assign) PositionID gid;

/**
 人员ID
 */
@property (nonatomic, assign) NSInteger staff_id;

#pragma mark - additional attribute

/**
 职位名称
 */
@property (nonatomic, strong, readonly) NSString *gidString;

/**
 岗位ID
 */
@property (nonatomic, strong) NSString *postId;

/**
 岗位名称
 */
@property (nonatomic, strong) NSString *postName;

@end
