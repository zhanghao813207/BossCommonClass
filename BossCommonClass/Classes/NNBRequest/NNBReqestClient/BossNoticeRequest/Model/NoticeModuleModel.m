//
//  NoticeModuleModel.m
//  BossCommonClass
//
//  Created by 贾远潮 on 2018/8/9.
//

#import "NoticeModuleModel.h"

@implementation NoticeModuleModel
@synthesize examineFlowBriefModel = _examineFlowBriefModel;
- (void)setValue:(id)value forKey:(NSString *)key
{
    if (!value || value == [NSNull null]) {
        return;
    }
    
    if ([key isEqualToString:@"created_at"]) {
        NSString *valueString = [NSString stringWithFormat:@"%@",value];
        
        self.created_at = [JYCSimpleToolClass quickChangeTimeWithTimeString:valueString];
        return;
    }
    
    [super setValue:value forKey:key];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

- (ExamineFlowModel *)examineFlowBriefModel
{
    if (!_examineFlowBriefModel) {
        _examineFlowBriefModel = self.type == BOSS_MODULE_TYPE_OA ? ({
            ExamineFlowModel *model = [[ExamineFlowModel alloc] init];
            [model setValuesForKeysWithDictionary:self.data];
            model;
        }) : nil;
    }
    return _examineFlowBriefModel;
}

@end
