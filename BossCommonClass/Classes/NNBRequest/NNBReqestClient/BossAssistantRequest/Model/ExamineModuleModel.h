//
//  ExamineModuleModel.h
//  AFNetworking
//
//  Created by 贾远潮 on 2018/8/9.
//

#import <Foundation/Foundation.h>
#import "BossBasicDefine.h"
#import "ExamineNodeMdoel.h"

@interface ExamineModuleModel : NSObject

@property (nonatomic, strong) NSString *apply_account;

@property (nonatomic, strong) NSArray *city_list;

@property (nonatomic, strong) NSArray *costclass_list;

@property (nonatomic, strong) NSString *examine_id;

@property (nonatomic, strong) NSString *examineflow_name;

@property (nonatomic, assign) NSInteger apply_gid;

@property (nonatomic, strong) NSString *examine_account;

@property (nonatomic, assign) BOSS_ASSISTANT_TYPE is_what;

@property (nonatomic, strong) NSArray *platform_list;

@property (nonatomic, strong) NSArray *supplier_list;

@property (nonatomic, assign) CGFloat total_money;

@property (nonatomic, strong) NSString *alert_time;

@property (nonatomic, strong, readonly) ExamineNodeMdoel *examine;

@property (nonatomic, strong) NSString *gidString;


@end
