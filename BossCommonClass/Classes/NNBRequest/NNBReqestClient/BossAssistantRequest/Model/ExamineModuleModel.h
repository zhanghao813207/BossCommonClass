//
//  ExamineModuleModel.h
//  AFNetworking
//
//  Created by 贾远潮 on 2018/8/9.
//

#import <Foundation/Foundation.h>
#import "BossBasicDefine.h"

@interface ExamineModuleModel : NSObject

@property (nonatomic, strong) NSString *apply_account;

@property (nonatomic, strong) NSArray *city_list;

@property (nonatomic, strong) NSArray *costclass_list;

@property (nonatomic, strong) NSString *examine_id;

@property (nonatomic, strong) NSString *flow_name;

@property (nonatomic, assign) NSInteger gid;

@property (nonatomic, assign) BOSS_ASSISTANT_TYPE is_what;

@property (nonatomic, strong) NSArray *platform_list;

@property (nonatomic, strong) NSArray *supplier_list;

@property (nonatomic, assign) CGFloat total_money;

@end
