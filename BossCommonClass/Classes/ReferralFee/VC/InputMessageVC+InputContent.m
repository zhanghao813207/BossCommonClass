
//
//  InputMessageVC+InputContent.m
//  AFNetworking
//
//  Created by admin on 2019/3/27.
//

#import "InputMessageVC+InputContent.h"
#import "RecommendedVC.h"
#import "ReferralFeeRequest.h"
#import "UIView+ShowView.h"

@interface InputMessageVC()

@end

@implementation InputMessageVC (InputContent)
- (void)inputContent:(NSString *)content type:(InputMessageModel *)type {
    if (type.type == InputTypeRole) {
        InputCell *cell = [self.tableview cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        cell.model.text = @"骑士";
        self.model.position_id = [content integerValue];
    }else if (type.type == InputTypeName) {
        InputCell *cell = [self.tableview cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
        cell.model.text = content;
        self.model.name = content;
    }else if (type.type == InputTypeAge) {
        self.model.age = [content integerValue];
        InputCell *cell = [self.tableview cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:1]];
        cell.model.text = content;
    }else if (type.type == InputTypeAddress) {
//        self.model.ad = content;
    }else if (type.type == InputTypeDetailAddress) {
        self.model.detailed_address = content;
        InputCell *cell = [self.tableview cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:1]];
        cell.model.text = content;
    }else if (type.type == InputTypeWorkState) {
        self.model.working_state = [content integerValue];
    }else if (type.type == InputTypeWorkingExperience) {
        self.model.work_experience = [content integerValue];
    }else if (type.type == InputTypeIdNumber) {
        self.model.identity_card_id = content;
        InputCell *cell = [self.tableview cellForRowAtIndexPath:[NSIndexPath indexPathForRow:7 inSection:1]];
        cell.model.text = content;
    }else if (type.type == InputTypeApp_type) {
//        if (kBossKnight) {
//
//        }else {
//            self.model.app_type = 20;
//        }
        
#ifdef kBossKnight
        
        self.model.app_type = 10;
        
#elif defined kBossManager
        
        self.model.app_type = 20;
        
#else
        
        self.model.app_type = 10;
#endif
        
    }else if (type.type == InputTypePhone) {
        self.model.phone = content;
        InputCell *cell = [self.tableview cellForRowAtIndexPath:[NSIndexPath indexPathForRow:4 inSection:1]];
        cell.model.text = content;
    }
   
}
////GetCityViewDelegate
- (void)provice:(ProvinceModel *)provinceModel city:(QH_CityModel *)cityModel area:(QH_ArearModel *)arearModel {
    self.model.province = [provinceModel.code integerValue];
    self.model.city = [cityModel.code integerValue];
    self.model.area = [arearModel.code integerValue];
    InputCell *cell = [self.tableview cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:1]];
    InputMessageModel *model = cell.model;
    if (!cityModel.value && !cityModel.value) {
        model.text = [NSString stringWithFormat:@"%@",provinceModel.value];
    }else {
        model.text = [NSString stringWithFormat:@"%@%@%@",provinceModel.value,cityModel.value,cityModel.value];
    }
    
    model.isInput = true;
    cell.model = model;
}

/**
 点击箭头

 @param model 数据
 */
- (void)arrowActionWithModel:(InputMessageModel *)model {
    [self.view endEditing:true];
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
            [self workState];
            break;
        case InputTypeWorkingExperience:
            NSLog(@"经验");
            [self workingExperience];
            break;
        default:
            break;
    }
}
- (void)workState {
    {
        InputCell *cell = [self.tableview cellForRowAtIndexPath:[NSIndexPath indexPathForRow:5 inSection:1]];
        InputMessageModel *model = cell.model;
        model.isInput = true;
        cell.model = model;
//        目前工作状态(100 在职 -100 离职)
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction *yesAction = [UIAlertAction actionWithTitle:@"在职" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            self.model.working_state = 100;
            model.text = @"在职";
//            [self.tableview reloadData];
            InputCell *cell = [self.tableview cellForRowAtIndexPath:[NSIndexPath indexPathForItem:5 inSection:1]];
            cell.model = model;
        }];
        UIAlertAction *noAction = [UIAlertAction actionWithTitle:@"离职" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            self.model.working_state = -100;
            model.text = @"离职";
//            [self.tableview reloadData];
            InputCell *cell = [self.tableview cellForRowAtIndexPath:[NSIndexPath indexPathForItem:5 inSection:1]];
            cell.model = model;
        }];
        [alertVC addAction:yesAction];
        [alertVC addAction:noAction];
        [self presentViewController:alertVC animated:true completion:^{
            
        }];
    }
}
- (void)workingExperience {
    InputCell *cell = [self.tableview cellForRowAtIndexPath:[NSIndexPath indexPathForRow:6 inSection:1]];
    InputMessageModel *model = cell.model;
    model.isInput = true;
    cell.model = model;
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *yesAction = [UIAlertAction actionWithTitle:@"有" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.model.work_experience = 50;
        model.text = @"有";
        InputCell *cell = [self.tableview cellForRowAtIndexPath:[NSIndexPath indexPathForItem:6 inSection:1]];
        cell.model = model;
//        NSIndexPath *path = [NSIndexPath indexPathForRow:6 inSection:1];
//        [self.tableview reloadRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationNone];
    }];
    UIAlertAction *noAction = [UIAlertAction actionWithTitle:@"无" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.model.work_experience = -50;
        model.text = @"无";
        InputCell *cell = [self.tableview cellForRowAtIndexPath:[NSIndexPath indexPathForItem:6 inSection:1]];
        cell.model = model;
//        [self.tableview reloadData];
    }];
    [alertVC addAction:yesAction];
    [alertVC addAction:noAction];
    [self presentViewController:alertVC animated:true completion:^{
        
    }];
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UILabel *label = [[UILabel alloc] init];
    label.backgroundColor = [UIColor colorWithRed:247 / 255.0 green:250 / 255.0 blue:251/255.0 alpha:1];
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
   
    if ([typeStr containsString:@"保存"]) {
        [ReferralFeeRequest recommendSubmit:false WithParam:self.model success:^(InputMessageModel * _Nonnull inputModel) {
            if (self.delegate && [self.delegate respondsToSelector:@selector(InputMessageVCTypeStr:)]) {
                [self.delegate InputMessageVCTypeStr:@"保存"];
               
                
            }
            if (self.delegate && [self.delegate respondsToSelector:@selector(hintMessage:)]) {
                 [self.delegate hintMessage:@"保存成功"];
            }
//            [self.view showSuccessStaus:@"保存成功"];

            [self.navigationController popViewControllerAnimated:true];
        } fail:^(NSString * message) {
            [self.view showStatus:message];
        }];
    }else {
        
        
//        [UIView animateWithDuration:0.5 animations:^{
//            footer.alpha = 0;
//        }];
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"" message:@"提交后不能更改,是否要提交?" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *noAction = [UIAlertAction actionWithTitle:@"否" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//            [UIView animateWithDuration:0.5 animations:^{
//                footer.alpha = 1;
//            }];
        }];
        UIAlertAction *yesAction = [UIAlertAction actionWithTitle:@"是" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            [ReferralFeeRequest recommendSubmit:true WithParam:self.model success:^(InputMessageModel * _Nonnull inputModel) {
                if (self.delegate && [self.delegate respondsToSelector:@selector(InputMessageVCTypeStr:)]) {
                    [self.delegate InputMessageVCTypeStr:@"提交"];
                    
//                    [self.view showSuccessStaus:@"提交成功"];
                }
                if (self.delegate && [self.delegate respondsToSelector:@selector(hintMessage:)]) {
                    [self.delegate hintMessage:@"提交成功"];
                }
                [self.navigationController popViewControllerAnimated:true];
            } fail:^(NSString * message) {
                [self.view showStatus:message];
            }];
            
//            for (UIViewController *vc in self.navigationController.childViewControllers) {
//                if ([vc isKindOfClass: [RecommendedVC class]]) {
//                    [self.navigationController popToViewController:vc animated:true];
//                }
//            }
        }];
        [alertVC addAction:noAction];
        [alertVC addAction:yesAction];
        [self presentViewController:alertVC animated:true completion:^{
            
        }];
        
        
        
    }
    
    
 
    
    
}

@end
