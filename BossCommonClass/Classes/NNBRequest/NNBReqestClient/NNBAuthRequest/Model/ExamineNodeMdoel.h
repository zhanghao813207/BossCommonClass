//
//  ExamineNodeMdoel.h
//  AFNetworking
//
//  Created by 贾远潮 on 2018/8/8.
//

#import <Foundation/Foundation.h>
#import "BossBasicDefine.h"

@interface ExamineNodeMdoel : NSObject

@property (nonatomic, assign) NSInteger gid;

@property (nonatomic, assign) BOOL is_apply;

@property (nonatomic, strong) NSString *account_id;

@property (nonatomic, strong) NSString *created_at;

@property (nonatomic, strong) NSString *desc;

@property (nonatomic, strong) NSString *name;

@property (nonatomic, assign) OA_EXAMINE_NODE_STATE state;


@end
