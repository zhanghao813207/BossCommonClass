//
//  OrderModel.h
//  Pods-BossKnight
//
//  Created by 贾远潮 on 2018/5/23.
//

#import <Foundation/Foundation.h>
#import "BossBasicDefine.h"
#import "KnightMaterialModel.h"

@interface OrderModel : NSObject

/**
 分发单id
 */
@property (nonatomic, strong) NSString *order_id;

/**
 分发单日期
 */
@property (nonatomic, strong) NSString *date;

/**
 骑士物资列表
 */
@property (nonatomic, strong) NSArray <KnightMaterialModel *>*material_list;

/**
物资流状态
 */
@property (nonatomic, assign) FlowStates flow_state;

/**
 操作人职位
 */
@property (nonatomic, strong) NSString *applicant_position;

/**
 操作人电话
 */
@property (nonatomic, strong) NSString *applicant_phone;

/**
 操作人姓名
 */
@property (nonatomic, strong) NSString *applicant_name;


@end
