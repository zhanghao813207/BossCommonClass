//
//  ContractBelongModel.h
//  AFNetworking
//
//  Created by 张浩 on 2019/1/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 合同归属
 */
@interface ContractBelongModel : NSObject

@property (nonatomic, strong) NSString *_id;

/**
 公司名称
 */
@property (nonatomic, strong) NSString *name;

/**
 法人
 */
@property (nonatomic, strong) NSString *legal_person;

/**
 地址
 */
@property (nonatomic, strong) NSString *address;

/**
 电话
 */
@property (nonatomic, strong) NSString *phone;

/**
 状态(启用:100,禁用:-100,删除:-101)
 */
@property (nonatomic, assign) NSNumber *state;

/**
 是否电子签约
 */
@property (nonatomic, assign) BOOL *is_electronic_sign;

/**
 模型转字典
 
 @return 字典
 */
- (NSDictionary *)decodeToDic;

@end

NS_ASSUME_NONNULL_END
