//
//  AssistantMessageModuleModel.h
//  BossCommonClass
//
//  Created by 贾远潮 on 2018/8/9.
//

#import <Foundation/Foundation.h>
#import "BossBasicDefine.h"
#import "ExamineModuleModel.h"

@interface AssistantMessageModuleModel : NSObject

@property (nonatomic, strong) NSString *created_at;

@property (nonatomic, assign) BOSS_MODULE_TYPE module_type;

@property (nonatomic, strong) NSDictionary *data;

@property (nonatomic, strong, readonly) ExamineModuleModel *examineModuleModel;


@end
