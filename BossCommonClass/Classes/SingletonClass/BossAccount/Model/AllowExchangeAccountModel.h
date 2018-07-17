//
//  AllowExchangeAccountModel.h
//  AFNetworking
//
//  Created by 贾远潮 on 2018/7/17.
//

#import <Foundation/Foundation.h>

@interface AllowExchangeAccountModel : NSObject

@property (nonatomic, strong) NSString *account_id;

@property (nonatomic, strong) NSString *name;

@property (nonatomic, strong) NSString *position_name;

@property (nonatomic, strong) NSArray *supplier_list;

@property (nonatomic, strong) NSArray *supplier_name_list;

/**
 模型转字典
 
 @return 字典
 */
- (NSDictionary *)decodeToDic;


@end
