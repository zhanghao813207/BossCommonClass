//
//  ExamineOrderModel.h
//  BossCommonClass
//
//  Created by 贾远潮 on 2018/8/8.
//

#import <Foundation/Foundation.h>

@interface ExamineOrderModel : NSObject

/**
 科目名称
 */
@property (nonatomic, strong) NSString *catalog_id;

/**
 单笔费用
 */
@property (nonatomic, assign) CGFloat money;

/**
 创建时间
 */
@property (nonatomic, strong) NSString *created_at;

/**
 单笔流水号
 */
@property (nonatomic, strong) NSString *_id;

/**
 费用名称
 */
@property (nonatomic, strong) NSString *costclass_name;


@end
