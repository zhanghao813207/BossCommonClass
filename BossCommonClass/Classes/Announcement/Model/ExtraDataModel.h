//
//  ExtraDataModel.h
//  AFNetworking
//
//  Created by qingping yi on 2020/9/10.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ExtraDataModel : NSObject

@property (nonatomic, strong) NSString * bizDistrictId;
@property (nonatomic, strong) NSString * checkTime;
@property (nonatomic, strong) NSDictionary *gainPermission;
@property (nonatomic, assign) BOOL isOwner;
@property (nonatomic, strong) NSString * merchantName;
@property (nonatomic, assign) BOOL otherChannel;
@property (nonatomic, strong) NSString * qrcode;
@property (nonatomic, strong) NSString * reason;
@property (nonatomic, strong) NSString * staffId;
@property (nonatomic, assign) NSInteger state;
@property (nonatomic, strong) NSString * submitAt;
@property (nonatomic, strong) NSString * teamAccountMapId;
@property (nonatomic, strong) NSString * teamId;
@property (nonatomic, strong) NSString * teamName;

@property (nonatomic, strong) NSString * showSubmitTime; // 提交时间
@property (nonatomic, strong) NSString * showReviewTime;  //审核日期

@end

NS_ASSUME_NONNULL_END
