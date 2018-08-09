//
//  AssistantMessageModuleModel.m
//  BossCommonClass
//
//  Created by 贾远潮 on 2018/8/9.
//

#import "AssistantMessageModuleModel.h"

@implementation AssistantMessageModuleModel

@synthesize examineModuleModel = _examineModuleModel;

- (void)setValue:(id)value forKey:(NSString *)key
{
    if (!value || value == [NSNull null]) {
        return;
    }
    
    [super setValue:value forKey:key];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

- (ExamineModuleModel *)examineModuleModel
{
    if (!_examineModuleModel) {
        _examineModuleModel = self.module_type == BOSS_MODULE_TYPE_OA ? ({
            ExamineModuleModel *model = [[ExamineModuleModel alloc] init];
            [model setValuesForKeysWithDictionary:self.data];
            model;
        }) : nil;
    }
    return _examineModuleModel;
}


@end
