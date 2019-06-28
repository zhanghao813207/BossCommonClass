//
//  BizDistrictTeamPlatformModel.h
//  BossCommonClass
//
//  Created by 高炀辉 on 2019/6/18.
//
#import <UIKit/UIKit.h>
#import "BusinessExtraField.h"
// 联系人Model
@interface BizDistrictTeamPlatformModel: NSObject

@property (nonatomic, strong) NSString * idField;
@property (nonatomic, strong) BusinessExtraField * businessExtraField;
@property (nonatomic, strong) NSString * name;
@property (nonatomic, strong) NSObject * parentId;
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, strong) NSString * vendorId;
@property (nonatomic, strong) NSString * vendorTargetId;
@property (nonatomic, strong) NSMutableArray * PlatformArr;
@property (nonatomic, strong) NSMutableArray * supplierArr;
@property (nonatomic, strong) NSMutableArray * cityArr;
@property (nonatomic, assign) BOOL isSelect;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end
