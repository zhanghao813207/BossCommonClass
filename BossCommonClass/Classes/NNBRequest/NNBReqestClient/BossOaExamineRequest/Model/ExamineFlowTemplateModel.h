//
//  ExamineFlowTemplateModel.h
//  AFNetworking
//
//  Created by 贾远潮 on 2018/8/24.
//

#import <Foundation/Foundation.h>
#import "BossBasicDefine.h"
@interface ExamineFlowTemplateModel : NSObject

/**
 _id
 */
@property (nonatomic, strong) NSString *_id;

/**
 名称
 */
@property (nonatomic, strong) NSString *name;

/**
 业务类型 1成本 90非成本
 */
@property (nonatomic, assign) ExamineFlowBizType biz_type;


@end
