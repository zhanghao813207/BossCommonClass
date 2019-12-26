//
//  ConfigSalaryLoan.h
//  AFNetworking
//
//  Created by yjs on 2019/11/10.
//

#import <Foundation/Foundation.h>

@interface ConfigSalaryLoan : NSObject

@property (nonatomic, strong) NSString * url;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;

@end
