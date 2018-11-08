//
//  TemplateDataBasicModel.h
//  AFNetworking
//
//  Created by 贾远潮 on 2018/11/6.
//

#import <Foundation/Foundation.h>
#import "BossBasicDefine.h"

NS_ASSUME_NONNULL_BEGIN

@interface TemplateDataBasicModel : NSObject

@property (nonatomic, strong) NSString *rule_collection_id;

@property (nonatomic, assign) SalaryRuleCollectionType collection_cate;

@end

NS_ASSUME_NONNULL_END
