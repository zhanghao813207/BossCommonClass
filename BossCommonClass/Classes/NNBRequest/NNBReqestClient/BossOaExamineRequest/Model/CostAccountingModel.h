//
//  CostAccountingModel.h
//  AFNetworking
//
//  Created by 贾远潮 on 2018/8/24.
//

#import <Foundation/Foundation.h>
#import "BossBasicDefine.h"
@interface CostAccountingModel : NSObject

/**
 费用科目id
 */
@property (nonatomic, strong) NSString *_id;

/**
 快捷别名
 */
@property (nonatomic, strong) NSString *code;

/**
 名称
 */
@property (nonatomic, strong) NSString *name;
/**
 编号
 */
@property (nonatomic, strong) NSString *accounting_code;

/**
 成本中心归属类型
 */
@property (nonatomic, assign) CostCenterType cost_center_type;

/**
 成本中心归属类型名称
 */
@property (nonatomic, strong) NSString *cost_center_type_title;


@end
