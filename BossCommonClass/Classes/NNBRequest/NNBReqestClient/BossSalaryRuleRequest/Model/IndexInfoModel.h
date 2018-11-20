//
//  IndexInfoModel.h
//  AFNetworking
//
//  Created by 贾远潮 on 2018/11/7.
//

#import <Foundation/Foundation.h>
#import "BossBasicDefine.h"

NS_ASSUME_NONNULL_BEGIN

@interface IndexInfoModel : NSObject

@property (nonatomic, strong) NSString *_id;

@property (nonatomic, strong) NSString *code;

@property (nonatomic, strong) NSString *created_at;

@property (nonatomic, strong) NSString *creator_id;

@property (nonatomic, strong) NSString *definition;

@property (nonatomic, strong) NSString *factor;

@property (nonatomic, strong) NSString *fork_version;

@property (nonatomic, strong) NSString *formula;

@property (nonatomic, assign) NSInteger level;

@property (nonatomic, strong) NSString *name;

@property (nonatomic, assign) NSInteger plan;

@property (nonatomic, strong) NSString *plan_id;

@property (nonatomic, strong) NSString *platform_code;

@property (nonatomic, strong) NSString *source_domain;

@property (nonatomic, assign) NSInteger state;

@property (nonatomic, strong) NSArray *tags;

@property (nonatomic, assign) NSInteger unit;

@property (nonatomic, strong) NSString *updated_at;

@property (nonatomic, strong) NSString *version;

@property (nonatomic, strong) NSString *unitString;

@end

NS_ASSUME_NONNULL_END
