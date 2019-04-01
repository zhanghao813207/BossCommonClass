
//
//  ReferralFeeRequest.m
//  AFNetworking
//
//  Created by admin on 2019/3/29.
//

#import "ReferralFeeRequest.h"
#import "NNBBasicRequest.h"
#import "NNBRequestManager.h"
#import "RecommendedModel.h"
#import "MJExtension.h"
#import "RecommendDetailModel.h"
#import "InputMessageModel.h"

@implementation ReferralFeeRequest
////提交 yes 是提交  no 是保存
+ (void)recommendSubmit:(BOOL)isSubmit  WithParam:(InputMessageModel *)inputModel ll:(void(^)(InputMessageModel *inputModel))successBlock fail:(void(^)(void))failBlock {
    NSMutableDictionary *paramDic = @{@"name":inputModel.name,
                               @"age":@(inputModel.age),
                               @"phone":inputModel.phone,
                               @"province":@(inputModel.province),
                               @"city":@(inputModel.city),
                               @"area":@(inputModel.area),
                               @"detailed_address":inputModel.detailed_address,
                               @"position_id":@(inputModel.position_id),
                               @"working_state":@(inputModel.working_state),
                               @"work_experience":@(inputModel.work_experience),
                               @"identity_card_id":inputModel.identity_card_id,
                               @"app_type":@(inputModel.app_type)
                               }.mutableCopy;
    NSString *subStr = @"";
    if (isSubmit) {
        subStr = @"internal_recommend.internal_recommend_staff.submit";
    }else {
        subStr = @"internal_recommend.internal_recommend_staff.save";
    }
    [NNBBasicRequest postJsonNoneWithUrl:NNBRequestManager.shareNNBRequestManager.url parameters:paramDic CMD:subStr success:^(id responseObject) {
        NSLog(@"%@",responseObject);
    } fail:^(id error) {
        NSLog(@"%@",error);
    }];
}
//internal_recommend.internal_recommend_staff.find
//1:已保存 10:已推荐 100:已入职 state
+ (void)recommendList:(NSInteger)state success:(void(^)(NSArray *listModel))successBlock fail:(void(^)(void))failBlock {
    [NNBBasicRequest postJsonWithUrl:NNBRequestManager.shareNNBRequestManager.url parameters:@{@"state":@(state)} CMD:@"internal_recommend.internal_recommend_staff.find" success:^(id responseObject) {
        NSDictionary *dic = responseObject;
        NSLog(@"%@",dic[@"data"]);
        NSArray *modelArr = [RecommendedModel  mj_objectArrayWithKeyValuesArray:dic[@"data"]];
        successBlock(modelArr);
    } fail:^(id error) {
        
    }];
}
//internal_recommend.internal_recommend_staff.get
+ (void)recommendDetail:(NSString *)idStr success:(void(^)(NSArray *list))successBlock fail:(void(^)(void))failBlock {
    [NNBBasicRequest postJsonWithUrl:NNBRequestManager.shareNNBRequestManager.url parameters:@{@"internal_recommend_staff_id":idStr} CMD:@"internal_recommend.internal_recommend_staff.get" success:^(id responseObject) {
        NSLog(@"%@",responseObject);
        NSDictionary *dic = responseObject;
        RecommendDetailModel *model = (RecommendDetailModel *)[RecommendDetailModel mj_objectWithKeyValues:dic];
        NSLog(@"%@",model.name);
        
        NSArray *titleArr = @[@[@"职位"],@[@"姓名",@"年龄",@"详细地址",@"联系电话",@"目前工作状态",@"工作经验",@"身份证号码"]];
        
        NSMutableArray *tempArrM = [NSMutableArray array];
        NSArray *arr1 = @[@"骑士"];
        if (model.address.length < 1) {
            model.address = @"无";
        }
        if (model.detailed_address.length < 1) {
            model.detailed_address = @"无";
        }
        if (model.phone.length < 1) {
            model.phone = @"无";
        }
        if (model.work_experienceStr.length < 1) {
            model.work_experienceStr = @"无";
        }
        if (model.identity_card_id.length < 1) {
            model.identity_card_id = @"无";
        }
        NSArray *arr2 = @[model.name,@(model.age),model.address,model.detailed_address,model.phone,@"工作状态",model.work_experienceStr,model.identity_card_id];
        [tempArrM addObject:arr1];
        [tempArrM addObject:arr2];
//        InputMessageModel
        NSMutableArray *arrM = [NSMutableArray array];
        for (NSInteger i = 0; i < titleArr.count; i ++) {
            NSMutableArray *arM = [NSMutableArray array];
            for (NSInteger j = 0; j < [titleArr[i] count]; j ++) {
                InputMessageModel *model = [[InputMessageModel alloc] init];
                model.isDetail = true;
                model.isSkip = true;
//                model.text = tempArrM[i][j] ? tempArrM[i][j]:@"";
                model.text = tempArrM[i][j];
                model.title = titleArr[i][j];
                [arM addObject:model];
            }
            [arrM addObject:arM];
        }
        successBlock(arrM);
    } fail:^(id error) {
        
    }];
}
//internal_recommend.internal_recommend_staff.delete   删除员工
+ (void)deleteRecommend:(NSArray *)idcardArr success:(void(^)(void))successBlock fail:(void(^)(void))failBlock {
    NSLog(@"%@",idcardArr);
    [NNBBasicRequest postJsonWithUrl:NNBRequestManager.shareNNBRequestManager.url parameters:@{@"internal_recommend_staff_ids":idcardArr} CMD:@"internal_recommend.internal_recommend_staff.delete" success:^(id responseObject) {
        NSLog(@"%@",responseObject);
        successBlock();
    } fail:^(id error) {
        NSLog(@"%@",error);
    }];
}
@end
