//
//  PermissionModel.h
//  BossCommonClass
//
//  Created by 贾远潮 on 2018/7/16.
//

#import <Foundation/Foundation.h>

@interface PermissionModel : NSObject

@property (nonatomic, strong) NSString *permission_code;

@property (nonatomic, strong) NSString *permission_name;

- (NSDictionary *)decodeToDic;

@end
