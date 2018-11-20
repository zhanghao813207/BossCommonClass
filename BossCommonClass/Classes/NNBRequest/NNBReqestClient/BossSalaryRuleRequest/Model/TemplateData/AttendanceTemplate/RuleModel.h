//
//  RuleModel.h
//  AFNetworking
//
//  Created by 贾远潮 on 2018/11/6.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RuleModel : NSObject

/**
 指标
 */
@property (nonatomic, strong) NSString *index;

/**
 运算符
 */
@property (nonatomic, strong) NSString *symbol;

/**
 取值
 */
@property (nonatomic, strong) NSString *num;

@property (nonatomic, strong) NSString *indexString;

@property (nonatomic, strong) NSString *numberString;



@end

NS_ASSUME_NONNULL_END
