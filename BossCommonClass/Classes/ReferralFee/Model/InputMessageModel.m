
//
//  InputMessageModel.m
//  AFNetworking
//
//  Created by admin on 2019/3/27.
//

#import "InputMessageModel.h"

@implementation InputMessageModel
+(NSArray *)getModelArr {
    InputMessageModel *tempModel = [[InputMessageModel alloc] init];
    NSMutableArray *arrM = [NSMutableArray array];
    NSArray *tempArr = @[@[@(InputTypeRole)],@[@(InputTypeName),@(InputTypeAge),@(InputTypeAddress),@(InputTypeDetailAddress),@(InputTypePhone),@(InputTypeWorkState),@(InputTypeWorkingExperience),@(InputTypeIdNumber)]];
    
    for (NSArray *arr in tempArr) {
        NSMutableArray *arM = [NSMutableArray array];
        for (NSNumber *type in arr) {
            InputMessageModel *model = [[InputMessageModel alloc] init];
            NSString *place = [tempModel placeholderWithType:type.integerValue];
            model.placeholder = place;
            model.type = type.integerValue;
            model.isSkip = [tempModel getSkip:type.integerValue];
            if ([place isEqualToString:@"骑士"]) {
                model.text = @"骑士";
            }else {
                model.text = @"";
            }
            [arM addObject:model];
        }
        [arrM addObject:arM];
    }
    return arrM.copy;
}
- (NSString *)placeholderWithType:(InputType)type {
    switch (type) {
        case InputTypeRole:
            return @"骑士";
            break;
        case InputTypeName:
            return @"姓名";
            break;
        case InputTypeAge:
            return @"年龄(建议填写年龄为18-60)";
            break;
        case InputTypeAddress:
            return @"所在区域";
            break;
        case InputTypeDetailAddress:
            return @"详细地址:乡镇,街道,门牌号,小区,楼号等";
            break;
        case InputTypePhone:
            return @"联系电话";
            break;
        case InputTypeWorkState:
            return @"目前工作状态";
            break;
        case InputTypeWorkingExperience:
            return @"有无工作经验";
            break;
        case InputTypeIdNumber:
            return @"身份证号码";
            break;
        default:
            return @"";
            break;
    }
}
- (BOOL)getSkip:(InputType)type {
    switch (type) {
        case InputTypeRole:
            return false;
            break;
        case InputTypeName:
            return true;
            break;
        case InputTypeAge:
            return true;
            break;
        case InputTypeAddress:
            return false;
            break;
        case InputTypeDetailAddress:
            return true;
            break;
        case InputTypePhone:
            return true;
            break;
        case InputTypeWorkState:
            return false;
            break;
        case InputTypeWorkingExperience:
            return false;
            break;
        case InputTypeIdNumber:
            return true;
            break;
        default:
            return false;
            break;
    }
}
@end
