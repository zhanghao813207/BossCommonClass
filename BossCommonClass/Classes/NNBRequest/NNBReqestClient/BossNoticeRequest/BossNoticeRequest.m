//
//  BossNoticeRequest.m
//  BossCommonClass
//
//  Created by 贾远潮 on 2018/8/9.
//

#import "BossNoticeRequest.h"
#import "BossBasicDefine.h"
#import "NNBBasicRequest.h"

@implementation BossNoticeRequest


/**
 BOSS通知

 @param page 页码
 @param limit 每页个数
 @param successBlock 成功的回调
 @param failBlock 服务器响应失败
 */
+ (void)noticeRequsetFindListWithPage:(NSInteger)page limit:(NSInteger)limit Success:(void(^)(NSArray <NoticeModuleModel *>*noticeList, NSInteger totalCount))successBlock fail:(void(^)(id error))failBlock
{
    NSString *url = [NSString stringWithFormat:@"%@boss_notice/find",BossBasicURL];
    NSDictionary *paramDic = @{
                               @"_meta":@{
                               @"page":@(page),
                               @"limit":@(limit),
                               }
                               };
    [NNBBasicRequest postJsonWithUrl:url parameters:paramDic CMD:nil success:^(id responseObject) {
        DLog(@"responseObject = %@",responseObject);
        if (!successBlock) {
            return;
        }
        NSMutableArray *array = [NSMutableArray array];
        for (NSDictionary* dataDic in responseObject[@"data"]) {
            NoticeModuleModel *model = [[NoticeModuleModel alloc] init];
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
