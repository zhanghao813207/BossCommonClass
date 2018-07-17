//
//  JurisdictionalRoleModel.h
//  BossCommonClass
//
//  Created by 贾远潮 on 2018/7/16.
//

#import <Foundation/Foundation.h>

@interface JurisdictionalRoleModel : NSObject

@property (nonatomic, assign) NSInteger gid;

@property (nonatomic, strong) NSString *name;

@property (nonatomic, assign) BOOL operable;

@property (nonatomic, strong) NSArray *permission_id_list;

@property (nonatomic, assign) NSInteger pid;

- (NSDictionary *)decodeToDic;


@end
