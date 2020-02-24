//
//  WebExtraDataModel.h
//  BossOwner
//
//  Created by yjs on 2019/7/5.
//  Copyright © 2019 欧客云. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WebExtraDataModel : NSObject

@property (nonatomic, strong) NSString * team_id;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;

@end

NS_ASSUME_NONNULL_END
