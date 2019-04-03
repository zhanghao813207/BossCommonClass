
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
#import "MJExtension.h"

@implementation ReferralFeeRequest
////提交 yes 是提交  no 是保存
+ (void)recommendSubmit:(BOOL)isSubmit  WithParam:(InputMessageModel *)inputModel success:(void(^)(InputMessageModel *inputModel))successBlock fail:(void(^)(NSString *))failBlock {
    if (kBossKnight) {
        
        inputModel.app_type = 10;
    }else {
        
        inputModel.app_type = 20;
    }
    
    NSLog(@"%@",inputModel._id);
  
    NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
    if (![inputModel._id isKindOfClass:[NSNull class]] && inputModel._id.length > 0) {
        paramDic[@"internal_recommend_staff_id"] = inputModel._id;
    }
    if (inputModel.name != nil) {
        paramDic[@"name"] = inputModel.name;
    }
    if (@(inputModel.age) != nil) {
        paramDic[@"age"] = @(inputModel.age);
    }
    if (inputModel.phone != nil) {
        paramDic[@"phone"] = inputModel.phone;
    }
    if (@(inputModel.province) != nil) {
        paramDic[@"province"] = @(inputModel.province);
    }
    if (@(inputModel.city) != nil) {
        paramDic[@"city"] = @(inputModel.city);
    }
    if (@(inputModel.area) != nil) {
        paramDic[@"area"] = @(inputModel.area);
    }
    if (inputModel.detailed_address != nil) {
        paramDic[@"detailed_address"] = inputModel.detailed_address;
    }
    if (inputModel.position_id) {
        paramDic[@"position_id"] = @(inputModel.position_id);
    }
    if (inputModel.working_state) {
        paramDic[@"working_state"] = @(inputModel.working_state);
    }
    if (inputModel.work_experience) {
        paramDic[@"work_experience"] = @(inputModel.work_experience);
    }
    if (inputModel.identity_card_id) {
        paramDic[@"identity_card_id"] = inputModel.identity_card_id;
    }
    paramDic[@"app_type"] = @(inputModel.app_type);
    NSString *subStr = @"";
    if (isSubmit) {
        subStr = @"internal_recommend.internal_recommend_staff.submit";
    }else {
        subStr = @"internal_recommend.internal_recommend_staff.save";
    }
    [NNBBasicRequest postJsonNoneWithUrl:NNBRequestManager.shareNNBRequestManager.url parameters:paramDic CMD:subStr success:^(id responseObject) {
        successBlock([InputMessageModel mj_objectWithKeyValues:responseObject]);
    } fail:^(id error) {
        NSDictionary *dic = error;
        failBlock(dic[@"zh_message"]);
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
+ (void)recommendDetail:(NSString *)idStr isEntry:(BOOL)entry success:(void(^)(NSArray *list))successBlock detailModel:(void(^)(RecommendDetailModel *model))detailmodel fail:(void(^)(void))failBlock {
    [NNBBasicRequest postJsonWithUrl:NNBRequestManager.shareNNBRequestManager.url parameters:@{@"internal_recommend_staff_id":idStr} CMD:@"internal_recommend.internal_recommend_staff.get" success:^(id responseObject) {
        NSLog(@"%@",responseObject);
        NSDictionary *dic = responseObject;
        RecommendDetailModel *model = (RecommendDetailModel *)[RecommendDetailModel mj_objectWithKeyValues:dic];
        
        NSLog(@"%@",model.name);
        
        NSArray *titleArr = [NSArray array];
        if (entry) {
            titleArr = @[@[@"职位"],@[@"姓名",@"年龄",@"详细地址",@"所属商圈",@"联系电话",@"目前工作状态",@"工作经验",@"身份证号码"]];
        }else {
            titleArr = @[@[@"职位"],@[@"姓名",@"年龄",@"详细地址",@"联系电话",@"目前工作状态",@"工作经验",@"身份证号码"]];
        }
        NSMutableArray *tempArrM = [NSMutableArray array];
        NSArray *arr1 = @[@"骑士"];
        if (model.address.length < 1) {
            model.address = @"未填写";
        }
        if (model.detailed_address.length < 1) {
            model.detailed_address = @"未填写";
        }
        if (model.phone.length < 1) {
            model.phone = @"未填写";
        }
        if (model.work_experienceStr.length < 1) {
            model.work_experienceStr = @"未填写";
        }
        if (model.identity_card_id.length < 1) {
            model.identity_card_id = @"未填写";
        }
        NSArray *arr2 = [NSArray array];
       
        if (entry) {
            arr2 =@[model.name,model.ageStr,model.detailed_address,model.biz_district_name,model.phone,model.working_stateStr,model.work_experienceStr,model.identity_card_id];
        }else {
           arr2 = @[model.name,model.ageStr,model.detailed_address,model.phone,model.working_stateStr,model.work_experienceStr,model.identity_card_id];
        }
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
        detailmodel(model);
    } fail:^(id error) {
        
    }];
}
//internal_recommend.internal_recommend_staff.delete   删除员工
+ (void)deleteRecommend:(NSArray *)idcardArr success:(void(^)(void))successBlock fail:(void(^)(void))failBlock {
    NSLog(@"%@",idcardArr);
    [NNBBasicRequest postJsonWithUrl:NNBRequestManager.shareNNBRequestManager.url parameters:@{@"internal_recommend_staff_ids":idcardArr} CMD:@"internal_recommend.internal_recommend_staff.delete" success:^(id responseObject) {
        NSLog(@"%@",responseObject[@"zh_message"]);
        successBlock();
    } fail:^(id error) {
        NSLog(@"%@",error[@"zh_message"]);
    }];
}
////批量提交 internal_recommend.internal_recommend_staff.batch_submit
+ (void)submitArrs:(NSArray *)idcardArr success:(void(^)(NSArray *sucessarr))successBlock fail:(void(^)(NSArray *failArr))failBlock {
    NSLog(@"adf");
    [NNBBasicRequest postJsonWithUrl:NNBRequestManager.shareNNBRequestManager.url parameters:@{@"internal_recommend_staff_ids":idcardArr} CMD:@"internal_recommend.internal_recommend_staff.batch_submit" success:^(id responseObject) {
        successBlock(responseObject[@"error_ids"]);
    } fail:^(id error) {
        NSLog(@"%@",error);
    }];
}
@end
