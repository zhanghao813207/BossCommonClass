//
//  BossAssistantRequest.m
//  BossCommonClass
//
//  Created by 贾远潮 on 2018/8/9.
//

#import "BossAssistantRequest.h"
#import "BossBasicDefine.h"
#import "NNBBasicRequest.h"


@implementation BossAssistantRequest

/**
 BOSS助理
 
 @param page 页码
 @param limit 限制条数
 @param successBlock 成功的列表
 @param failBlock 失败的列表
 */
+ (void)BossAssistantRequestFindAssistantWithPage:(NSInteger)page Limit:(NSInteger)limit Success:(void(^)(NSArray *messageList, NSInteger totalCount))successBlock fail:(void(^)(id error))failBlock;
{
    NSString *url = [NSString stringWithFormat:@"%@boss_assistant",BossBasicURL];
    NSDictionary *paramDic = @{
                               @"page":@(page),
                               @"limit":@(limit),
                               };
    [NNBBasicRequest getJsonWithUrl:url parameters:paramDic CMD:nil success:^(id responseObject) {
        DLog(@"responseObject = %@",responseObject);
        if (!successBlock) {
            return;
        }
        NSMutableArray *array = [NSMutableArray array];
        for (NSDictionary* dataDic in responseObject[@"data"]) {
            AssistantMessageModuleModel *model = [[AssistantMessageModuleModel alloc] init];
            [model setValuesForKeysWithDictionary:dataDic];
            [array addObject:model];
        }
        successBlock([array copy],[responseObject[@"_meta"][@"result_count"] integerValue]);
    } fail:^(id error) {
        if(failBlock){
            failBlock(error);
        }
    }];
}
@end
