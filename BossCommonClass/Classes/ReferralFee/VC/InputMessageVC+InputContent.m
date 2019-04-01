
//
//  InputMessageVC+InputContent.m
//  AFNetworking
//
//  Created by admin on 2019/3/27.
//

#import "InputMessageVC+InputContent.h"
#import "RecommendedVC.h"
#import "ReferralFeeRequest.h"

@interface InputMessageVC()

@end

@implementation InputMessageVC (InputContent)
- (void)inputContent:(NSString *)content type:(InputMessageModel *)type {
    if (type.type == InputTypeRole) {
        self.model.position_id = [content integerValue];
    }else if (type.type == InputTypeName) {
        self.model.name = content;
    }else if (type.type == InputTypeAge) {
        self.model.age = [content integerValue];
    }else if (type.type == InputTypeAddress) {
//        self.model.ad = content;
    }else if (type.type == InputTypeDetailAddress) {
        self.model.detailed_address = content;
    }else if (type.type == InputTypeWorkState) {
        self.model.working_state = [content integerValue];
    }else if (type.type == InputTypeWorkingExperience) {
        self.model.work_experience = [content integerValue];
    }else if (type.type == InputTypeIdNumber) {
        self.model.identity_card_id = content;
    }else if (type.type == InputTypeApp_type) {
        self.model.app_type = 10;
    }else if (type.type == InputTypePhone) {
        self.model.phone = content;
    }
   
}
////GetCityViewDelegate
- (void)provice:(ProvinceModel *)provinceModel city:(QH_CityModel *)cityModel area:(QH_ArearModel *)arearModel {
    NSLog(@"%@-%@",provinceModel.value,provinceModel.code);
    NSLog(@"%@-%@",cityModel.value,cityModel.code);
    NSLog(@"%@-%@",arearModel.value,arearModel.code);
    
    self.model.province = [provinceModel.code integerValue];
    self.model.city = [cityModel.code integerValue];
    self.model.area = [arearModel.code integerValue];
}
/**
 点击箭头

 @param model 数据
 */
- (void)arrowActionWithModel:(InputMessageModel *)model {
    switch (model.type) {
        case InputTypeRole:
            NSLog(@"角色");
            break;
        case InputTypeAddress:
            NSLog(@"地址");
            [self cityView];
            break;
        case InputTypeWorkState:
            NSLog(@"工作状态");
            break;
        case InputTypeWorkingExperience:
            NSLog(@"经验");
            [self workingExperience];
            break;
        default:
            break;
    }
}
- (void)workingExperience {
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"有无工作经验" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *yesAction = [UIAlertAction actionWithTitle:@"有" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.model.work_experience = 50;
    }];
    UIAlertAction *noAction = [UIAlertAction actionWithTitle:@"无" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.model.work_experience = -50;
    }];
    [alertVC addAction:yesAction];
    [alertVC addAction:noAction];
    [self presentViewController:alertVC animated:true completion:^{
        
    }];
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UILabel *label = [[UILabel alloc] init];
    label.backgroundColor = [UIColor lightGrayColor];
    label.font = [UIFont systemFontOfSize:14];
    if (section == 0) {
        label.text = @"  被推荐人信息";
    }
    return label;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 1/UIScreen.mainScreen.scale;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 40;
    }
    return 10;
}
- (void)didButton:(NSString *)typeStr view:(FooterView *)footer {
    [self.view endEditing:YES];
    self.model.position_id = 1010;
    self.model.working_state = -100;
    self.model.app_type = 10;
    NSLog(@"%@",self.model.name);
    NSLog(@"%ld",self.model.age);
    NSLog(@"%@",self.model.phone);
    NSLog(@"%ld",self.model.province);
    NSLog(@"%ld",self.model.city);
    NSLog(@"%ld",self.model.area);
    NSLog(@"%@",self.model.detailed_address);
    NSLog(@"%ld",self.model.working_state);
    
    if ([typeStr containsString:@"保存"]) {
        [ReferralFeeRequest recommendSubmit:false WithParam:self.model ll:^(InputMessageModel * _Nonnull inputModel) {
            
        } fail:^{
            
        }];
    }else {
        [ReferralFeeRequest recommendSubmit:true WithParam:self.model ll:^(InputMessageModel * _Nonnull inputModel) {
            
        } fail:^{
            
        }];
    }
    return;
    
    
    [UIView animateWithDuration:0.5 animations:^{
        footer.alpha = 0;
    }];
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"" message:@"提交后不能更改,是否要提交?" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *noAction = [UIAlertAction actionWithTitle:@"否" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [UIView animateWithDuration:0.5 animations:^{
            footer.alpha = 1;
        }];
    }];
    UIAlertAction *yesAction = [UIAlertAction actionWithTitle:@"是" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        for (UIViewController *vc in self.navigationController.childViewControllers) {
            if ([vc isKindOfClass: [RecommendedVC class]]) {
                [self.navigationController popToViewController:vc animated:true];
            }
        }
    }];
    [alertVC addAction:noAction];
    [alertVC addAction:yesAction];
    [self presentViewController:alertVC animated:true completion:^{
        
    }];
    
    
}

@end
