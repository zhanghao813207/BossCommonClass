//
//  SupplementOpinionModel.h
//  BossManager
//
//  Created by 贾远潮 on 2018/12/12.
//  Copyright © 2018 贾远潮. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AccountModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SupplementOpinionModel : NSObject

@property (nonatomic, strong) NSString *creator_id;

@property (nonatomic, strong) NSString *content;

@property (nonatomic, strong) NSArray *file_list;

@property (nonatomic, strong) NSString *_id;

@property (nonatomic, strong) NSString *record_id;

@property (nonatomic, strong) AccountModel *creator_info;

@property (nonatomic, strong) NSString *created_at;

@property (nonatomic, assign) SupplementOpinionState state;

@property (nonatomic, strong) NSString *updated_at;


@end

NS_ASSUME_NONNULL_END
