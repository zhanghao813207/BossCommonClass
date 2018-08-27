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
 员工ID
 */
@property (nonatomic, assign) NSInteger staff_id;

/**
 职位名称
 */
@property (nonatomic, strong, readonly) NSString *gidString;


@end
