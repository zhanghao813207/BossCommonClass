//
//  Extra_data.h
//  AFNetworking
//
//  Created by qingping yi on 2020/9/8.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Extra_data : NSObject


@property (nonatomic, strong) NSString * bizDistrictId;
@property (nonatomic, strong) NSString * checkTime;
@property (nonatomic, strong) NSString * darkModeHeadImg;
@property (nonatomic, assign) NSInteger gainPermission;
@property (nonatomic, assign) BOOL isOwner;
@property (nonatomic, strong) NSString * merchantName;
@property (nonatomic, assign) BOOL otherChannel;
@property (nonatomic, strong) NSString * pushMessageType;
@property (nonatomic, strong) NSString * qrcode;
@property (nonatomic, strong) NSString * reason;
@property (nonatomic, strong) NSString * staffId;
@property (nonatomic, assign) NSInteger state;
@property (nonatomic, strong) NSString * submitAt;
@property (nonatomic, strong) NSString * teamAccountMapId;
@property (nonatomic, strong) NSString * teamId;
@property (nonatomic, strong) NSString * teamName;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;

@end

NS_ASSUME_NONNULL_END
