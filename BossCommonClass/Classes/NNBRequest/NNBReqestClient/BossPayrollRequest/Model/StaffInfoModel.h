//
//  StaffInfoModel.h
//  AFNetworking
//
//  Created by 贾远潮 on 2018/11/5.
//

#import <Foundation/Foundation.h>
#import "BossBasicDefine.h"
NS_ASSUME_NONNULL_BEGIN

@interface StaffInfoModel : NSObject

@property (nonatomic, strong) NSString *_id;

@property (nonatomic, strong) NSString *bank_branch;

@property (nonatomic, strong) NSString *bank_card_id;

@property (nonatomic, strong) NSArray *bank_location;

@property (nonatomic, strong) NSArray *biz_district_names;

@property (nonatomic, strong) NSArray *city_spelling_list;

@property (nonatomic, strong) NSString *contract_belong_id;

@property (nonatomic, strong) NSArray *city_names;

/**
 离职日期
 */
@property (nonatomic, strong) NSString *departure_date;

@property (nonatomic, strong) NSArray *departure_log;

@property (nonatomic, strong) NSString *entry_date;

@property (nonatomic, strong) NSString *identity_card_id;

@property (nonatomic, strong) NSString *knight_type_id;

@property (nonatomic, strong) NSString *name;

@property (nonatomic, strong) NSString *phone;

@property (nonatomic, assign) PositionID  position_id;

@property (nonatomic, assign) NSInteger recruitment_channel_id;

@property (nonatomic, assign) NSInteger state;

@property (nonatomic, strong) NSString *postionString;

@property (nonatomic, strong) NSString *stateString;

@property (nonatomic, strong) NSString *contract_belong_name;

@property (nonatomic, assign) STAFFWORKTYPE work_type;

@end

NS_ASSUME_NONNULL_END
