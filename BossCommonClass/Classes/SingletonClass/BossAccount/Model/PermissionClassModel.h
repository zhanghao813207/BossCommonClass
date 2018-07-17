//
//  PermissionClassModel.h
//  BossCommonClass
//
//  Created by 贾远潮 on 2018/7/16.
//

#import <Foundation/Foundation.h>

@interface PermissionClassModel : NSObject

@property (nonatomic, assign) BOOL available;

@property (nonatomic, strong) NSString *desc;

@property (nonatomic, strong) NSString *_id;

@property (nonatomic, strong) NSString *p_type;

@property (nonatomic, strong) NSString *path;

@property (nonatomic, assign) NSInteger sort;

@property (nonatomic, assign) NSUInteger state;

- (NSDictionary *)decodeToDic;

@end
