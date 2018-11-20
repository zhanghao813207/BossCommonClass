//
//  TemplateRuleModel.h
//  AFNetworking
//
//  Created by 贾远潮 on 2018/11/9.
//

#import <Foundation/Foundation.h>
#import "BossBasicDefine.h"
NS_ASSUME_NONNULL_BEGIN

@interface TemplateRuleModel : NSObject

@property (nonatomic, strong) NSString *_id;

@property (nonatomic, strong) NSString *created_at;

@property (nonatomic, strong) NSString *plan_id;

@property (nonatomic, strong) NSString *plan_version_id;

@property (nonatomic, assign) BOOL operation_rule_flag;

@property (nonatomic, assign) BOOL operation_rule_relation;

@property (nonatomic, strong) NSArray *operation_rules;

@property (nonatomic, assign) BOOL order_rule_flag;

@property (nonatomic, assign) BOOL order_rule_relation;

@property (nonatomic, strong) NSArray *order_rules;

@property (nonatomic, assign) BOOL qa_rule_flag;

@property (nonatomic, assign) BOOL qa_rule_relation;

@property (nonatomic, strong) NSArray *qa_rules;

@property (nonatomic, assign) BOOL work_rule_flag;

@property (nonatomic, assign) BOOL work_rule_relation;

@property (nonatomic, strong) NSArray *work_rules;

@property (nonatomic, assign) STAFFWORKTYPE work_type;


@property (nonatomic, strong) NSString *updated_at;

@end

NS_ASSUME_NONNULL_END
