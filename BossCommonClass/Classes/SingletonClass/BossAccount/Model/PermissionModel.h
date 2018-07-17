//
//  PermissionModel.h
//  BossCommonClass
//
//  Created by 贾远潮 on 2018/7/16.
//

#import <Foundation/Foundation.h>
#import "PermissionClassModel.h"

@interface PermissionModel : NSObject

@property (nonatomic, assign) BOOL available;

@property (nonatomic, strong) NSString *create_at;

@property (nonatomic, strong) NSString *current_pid;

@property (nonatomic, strong) NSString *desc;

@property (nonatomic, assign) NSInteger gid;

@property (nonatomic, strong) NSString *name;

@property (nonatomic, strong) NSArray <PermissionClassModel *>*permission_class;

@property (nonatomic, assign) NSInteger pid;

@property (nonatomic, strong) NSString *update_at;


- (NSDictionary *)decodeToDic;

@end
