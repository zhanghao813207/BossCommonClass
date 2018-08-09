//
//  NoticeModuleModel.h
//  BossCommonClass
//
//  Created by 贾远潮 on 2018/8/9.
//

#import <Foundation/Foundation.h>
#import "BossBasicDefine.h"
#import "ExamineFlowModel.h"
@interface NoticeModuleModel : NSObject

@property (nonatomic, strong) NSString *_id;

@property (nonatomic, strong) NSString *created_at;

@property (nonatomic, assign) BOSS_MODULE_TYPE type;

@property (nonatomic, strong) NSDictionary *data;

@property (nonatomic, strong) ExamineFlowModel *examineFlowBriefModel;


@end
