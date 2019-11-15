//
//  UserInfoFixVc.m
//  BossCommonClass
//
//  Created by 高炀辉 on 2019/11/13.
//

#import "UserInfoFixVc.h"
#import "BossOwnerAccount.h"
#import "SDWebImage.h"
#import "BossAiManager.h"
#import "UIView+ImagePick.h"
#import "NNBBasicRequest.h"
#import "NNBUploadManager.h"
#import "NNBUtilRequest.h"

//#import <AipOcrSdk/AipOcrSdk.h>
// 按钮状态
// 保存状态 保存
// 修改状态 (修改姓名/修改身份证号码/修改...)
typedef enum : NSUInteger {
    btnfixType,
    btnsaveType
} buttonStateType;
typedef void(^successUpload)(NSMutableArray *arr);
@interface UserInfoFixVc ()<UITextFieldDelegate>
// 底部操作按钮
// 开始编辑 提交编辑
@property (weak, nonatomic) IBOutlet UIButton *bottomButton;
/// 当前修改的任务
@property (weak, nonatomic) IBOutlet UILabel *currentFixTaskLabel;
/// 任务描述
@property (weak, nonatomic) IBOutlet UILabel *taskContentLabel;
/// 姓名输入框
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
/// 性别输入框
@property (weak, nonatomic) IBOutlet UITextField *genderTextField;
/// 出生日期输入框
@property (weak, nonatomic) IBOutlet UITextField *birthdayTextField;
/// 民族输入框
@property (weak, nonatomic) IBOutlet UITextField *racialTextField;
/// 身份证输入框
@property (weak, nonatomic) IBOutlet UITextField *IDCardTextField;
/// 正面
@property (weak, nonatomic) IBOutlet UIImageView *faceImageView;

/// 反面
@property (weak, nonatomic) IBOutlet UIImageView *reverseImageView;

/// 手持面
@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;

/// 按钮状态 默认为fixtype
@property (nonatomic, assign) buttonStateType btnType;
// 显示错误View
@property (weak, nonatomic) IBOutlet UIView *nameErrorView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *nameErrorViewHeight;
@property (weak, nonatomic) IBOutlet UILabel *errorNameLabel;
@property (weak, nonatomic) IBOutlet UIView *genderErrorView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *genderErrorHeight;
@property (weak, nonatomic) IBOutlet UIView *birthdayErrorView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *birthdayErrorHeight;
@property (weak, nonatomic) IBOutlet UIView *racialErrorView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *racialErrorHeight;
@property (weak, nonatomic) IBOutlet UIView *idCardErrorView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *idCardErrorHeight;
@property (weak, nonatomic) IBOutlet UILabel *idCardErrorLabel;

@property (nonatomic, assign) BOOL canSaved;

@property (weak, nonatomic) IBOutlet UITextField *dateTextField;
@property (weak, nonatomic) IBOutlet UIView *dateErrorView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *dateErrorHeight;

// 存放所有信息错误状态
@property (nonatomic, strong) NSMutableArray *errorStateArr;
//
@property (nonatomic, strong) UIImage *faceImage;
@property (nonatomic, strong) UIImage *reverseImage;
@property (nonatomic, strong) UIImage *headerImage;

@property (nonatomic, strong) NSMutableArray *imageMutableArray;

@property (nonatomic, strong) NSMutableArray *imageArray;

@property (nonatomic, copy) successUpload successUploadBlock;
// 开始时间
@property (nonatomic, assign) NSInteger startdate;
// 结束时间
@property (nonatomic, assign) NSInteger enddate;
@end

@implementation UserInfoFixVc

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
    [self setTask];
}
//
- (void)setUI{
    // 转换格式后的日期字符串
    NSString *birthStr = [self convertDateFormat:kCurrentBossOwnerAccount.accountModel.birthDate];

    self.nameTextField.text = kCurrentBossOwnerAccount.accountModel.name;
    
    self.genderTextField.text = kCurrentBossOwnerAccount.accountModel.gender;
    
    self.birthdayTextField.text = birthStr;
     
    self.racialTextField.text = kCurrentBossOwnerAccount.accountModel.national;
    
    self.IDCardTextField.text = kCurrentBossOwnerAccount.accountModel.identityCardId;
    NSString *startDate = [NSString stringWithFormat:@"%ld",(long)kCurrentBossOwnerAccount.accountModel.idcardStartDate];
    NSString *endDate = [NSString stringWithFormat:@"%ld",(long)kCurrentBossOwnerAccount.accountModel.idcardEndDate];
    self.dateTextField.text = [NSString stringWithFormat:@"%@ ~ %@", startDate, endDate];
    
    [self.faceImageView sd_setImageWithURL:[NSURL URLWithString: kCurrentBossOwnerAccount.accountModel.identityCardFrontUrl] placeholderImage:[UIImage imageNamed: @"none-icon"]];
    [self.reverseImageView sd_setImageWithURL:[NSURL URLWithString:kCurrentBossOwnerAccount.accountModel.identityCardBackUrl] placeholderImage:[UIImage imageNamed: @"none-icon"]];
    [self.headerImageView sd_setImageWithURL:[NSURL URLWithString: kCurrentBossOwnerAccount.accountModel.handBustUrl] placeholderImage:[UIImage imageNamed: @"none-icon"]];
    
    self.bottomButton.layer.cornerRadius = 4;
    
    self.title = @"身份信息";
    
    self.view.backgroundColor = UIColor.whiteColor;
    
    self.btnType = btnfixType;
    
    [BossAiManager autoRegist];

    self.imageMutableArray = [[NSMutableArray alloc] init];
    
    self.errorStateArr = [[NSMutableArray alloc] init];
}
- (void)setTask{
    if (self.fixType == fixName){
        // 修改姓名
        // 图片点击事件无效 按钮修改为
        self.currentFixTaskLabel.text = @"姓名有误，请立即修改";
        self.taskContentLabel.text = @"您的姓名与身份证上的不一致";
        [self.bottomButton setTitle:@"修改姓名" forState:UIControlStateNormal];
    } else if (self.fixType == fixIDNumber){
        self.currentFixTaskLabel.text = @"身份证号有误，请立即修改";
        self.taskContentLabel.text = @"您的身份证号码与身份证上的不一致";
        [self.bottomButton setTitle:@"修改身份证号码" forState:UIControlStateNormal];
    } else if (self.fixType == fixIDCardDate){
        self.currentFixTaskLabel.text = @"立即更换正式身份证照片";
        self.taskContentLabel.text = @"身份证快过期了，请更换成未过期的正式身份证照片";
        [self.bottomButton setTitle:@"更换正式新身份证" forState:UIControlStateNormal];
    } else if (self.fixType == fixIDcard){
        self.currentFixTaskLabel.text = @"立即更换正式身份证";
        self.taskContentLabel.text = @"您的身份证是临时身份证，请立即更换正式身份证";
        [self.bottomButton setTitle:@"更换正式身份证" forState:UIControlStateNormal];
    }
        
}
- (NSString *)convertDateFormat:(NSInteger)dateInt
{
    NSString * birthStr = [NSString stringWithFormat:@"%ld", dateInt];
    //                    19930404
    //                    NSString *string = @"7月-16/2016 09:33:22秒";// 日期格式化类
    NSDateFormatter *format = [[NSDateFormatter alloc] init];// 设置日期格式 为了转换成功
    format.dateFormat = @"yyyyMMdd";
    NSDate * date =[format dateFromString:birthStr];
    format.dateFormat = @"yyyy/MM/dd";
    if ([format stringFromDate:date]) {
        return [format stringFromDate:date];
    }
    return @"";
}
-(void)setBtnType:(buttonStateType)btnType{
    if (btnType == btnsaveType){
        // 如果是姓名修改 直接将name获取焦点
        if (self.fixType == fixName){
            // 可以编辑
            [self.nameTextField setEnabled:true];
            // 获取焦点
            [self.nameTextField becomeFirstResponder];
        } else {
            // 清空所有信息
            
            self.nameTextField.text = @"";
            
            self.genderTextField.text = @"";
            
            self.birthdayTextField.text = @"";
             
            self.racialTextField.text = @"";
            
            self.IDCardTextField.text = @"";
            
            self.dateTextField.text = @"";
            
            self.faceImageView.image = [UIImage imageNamed:@"chooseImageIcon"];
            
            self.reverseImageView.image = [UIImage imageNamed:@"chooseImageIcon"];
            
            self.headerImageView.image = [UIImage imageNamed:@"chooseImageIcon"];
            
            [self.faceImageView setUserInteractionEnabled:true];
            
            [self.reverseImageView setUserInteractionEnabled:true];
            
            [self.headerImageView setUserInteractionEnabled:true];
        }
    }
    _btnType = btnType;
}
- (void)setCanSaved:(BOOL)canSaved{
    if (canSaved){
        self.bottomButton.alpha = 1;
        [self.bottomButton setEnabled:true];
    } else {
        self.bottomButton.alpha = 0.4;
        [self.bottomButton setEnabled:false];
    }
}
- (void)showAlertView{
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"当前身份证是临时身份证, 请使用正式身份证!" preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *alertA = [UIAlertAction actionWithTitle:@"我知道了" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alertC addAction:alertA];
    [self.navigationController presentViewController:alertC animated:YES completion:nil];
}
- (IBAction)upLoadFaceImageViewClicked:(UITapGestureRecognizer *)sender {
    NSLog(@"%ld", sender.view.tag);
    if (sender.view.tag == BaiDuOCRTypeIdcardFront || sender.view.tag == BaiDuOCRTypeIdcardBack){
        [BossAiManager identifyTextWithType:sender.view.tag  viewController:self success:^(UIImage *identifyImage, NSString *text) {
                NSLog(@"身份证信息: %@", text);
                NSArray *textArray = [text componentsSeparatedByString:@","];
                if (sender.view.tag == 1) {
                    self.faceImage = identifyImage;
                    self.faceImageView.image = identifyImage;
                    // 正面
                    if (textArray.count == 7){
                        // 临时身份证
                        // 弹窗提示
                        [self showAlertView];
                        return;
                    }
                    if (textArray.count < 5) {
                        return;
                    }
                    
                    
                    self.nameTextField.text = textArray[0];
                    
                    self.genderTextField.text = textArray[1];
                    
                    NSInteger birthday = [textArray[2] integerValue];
                    self.birthdayTextField.text = [self convertDateFormat: birthday];
                     
                    self.racialTextField.text = textArray[3];
                    
                    self.IDCardTextField.text = @"131182199306291026";
//                    textArray[4];
                    // 判断姓名
                    if (![textArray[0] isEqualToString:kCurrentBossOwnerAccount.accountModel.name]){
                        // 错误 更改后 与原姓名不可一致
                        // 显示错误View
                        self.nameErrorViewHeight.constant = 42;
                        self.errorNameLabel.text = @"当前姓名与录入姓名不一致";
                        [self.nameTextField setEnabled:true];
                        [self.nameErrorView setHidden:false];
                        
                        
                    } else {
                        self.nameErrorViewHeight.constant = 0;
                        [self.nameErrorView setHidden:true];
                    }
                    
                    if (![textArray[1] isEqualToString:kCurrentBossOwnerAccount.accountModel.gender]){
                        self.genderErrorHeight.constant = 42;
                        [self.genderErrorView setHidden:false];
                        
                    } else {
                        self.genderErrorHeight.constant = 0;
                        [self.genderErrorView setHidden:true];
                        
                    }
                    
                    if (![[self convertDateFormat: birthday] isEqualToString:[self convertDateFormat:kCurrentBossOwnerAccount.accountModel.birthDate]]){
                        self.birthdayErrorHeight.constant = 42;
                        [self.birthdayErrorView setHidden:false];
                    } else {
                        self.birthdayErrorHeight.constant = 0;
                        [self.birthdayErrorView setHidden:true];
                        
                    }
                    
                    if (![textArray[3] isEqualToString:kCurrentBossOwnerAccount.accountModel.national]){
                        self.racialErrorHeight.constant = 42;
                        [self.racialErrorView setHidden:false];
                       
                        
                    } else {
                        self.racialErrorHeight.constant = 0;
                        [self.racialErrorView setHidden:true];
                        
                    }
                    // 如果是修改身份证号 则必须与原先不一致 一致则为出错
                    if (self.fixType == fixIDNumber){
//                        
                        
                        if ([self.IDCardTextField.text isEqualToString:kCurrentBossOwnerAccount.accountModel.identityCardId]){
                            self.idCardErrorHeight.constant = 42;
                            self.idCardErrorLabel.text = @"当前身份证号码与录入身份证号码不可一致";
                            [self.idCardErrorView setHidden:false];
                            
                        } else {
                            self.idCardErrorHeight.constant = 0;
                            [self.idCardErrorView setHidden:true];
                            
                        }
                    } else if (self.fixType == fixIDCardDate || self.fixType == fixIDcard){
                        // textArray[4]
                        if (![self.IDCardTextField.text isEqualToString:kCurrentBossOwnerAccount.accountModel.identityCardId]){
                            self.idCardErrorHeight.constant = 42;
                            [self.idCardErrorView setHidden:false];
                            
                        } else {
                            self.idCardErrorHeight.constant = 0;
                            [self.idCardErrorView setHidden:true];
                        }
                    }
                } else {
                    self.reverseImage = identifyImage;
                    self.reverseImageView.image = identifyImage;
                    if([text containsString:@"temporary"]){
                        [self showAlertView];
                        return;
                    }else{
                        NSArray *timeArray = [text componentsSeparatedByString:@"-"];
                        if (timeArray.count != 2){
                            return;
                        }
                        NSString * timeStr = [NSString stringWithFormat:@"%@ ~ %@", timeArray.firstObject, timeArray.lastObject];
                        self.startdate = [timeArray.firstObject integerValue];
                        self.enddate = [timeArray.lastObject integerValue];
                        self.dateTextField.text = timeStr;
                        // 判断过期时间是否大于3个月 如果小于 报错
                    }
                }
                // 执行 按钮是否可以点击操作
                [self fixButtonIsClicked];
            } fail:^(id error) {
            }];
    } else {
        // 手持
        [self.headerImageView pickImageFromPhotoOrCameraWithImageBlock:^(UIImage *imageResult) {
            self.headerImageView.image = [imageResult imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            // 执行 按钮是否可以点击操作
            self.headerImage = imageResult;
            [self fixButtonIsClicked];
        }];
    }
}
- (void)fixButtonIsClicked{
    // 是否选择了正面照
    if (!self.faceImage){
        return;
    }
    // 是否选择了反面照
    if (!self.reverseImage){
        return;
    }
    // 是否选择手持身份证
    if (!self.headerImage){
        return;
    }
    // 判断所有错误规则是否符合
    [self.errorStateArr removeAllObjects];
    [self.errorStateArr addObject:@(self.nameErrorView.isHidden)];
    [self.errorStateArr addObject:@(self.genderErrorView.isHidden)];
    [self.errorStateArr addObject:@(self.birthdayErrorView.isHidden)];
    [self.errorStateArr addObject:@(self.racialErrorView.isHidden)];
    [self.errorStateArr addObject:@(self.idCardErrorView.isHidden)];
    [self.errorStateArr addObject:@(self.dateErrorView.isHidden)];
    // 是否所有内容都符合规则
    // 如果其中有不符合规范则return
    if([self.errorStateArr containsObject:@(false)]){
        return;
    }
    self.imageArray = [[NSMutableArray alloc] initWithArray:@[self.faceImage, self.reverseImage, self.headerImage]];
    // 所有规则都符合
    self.canSaved = true;
}
// 获取token
- (void)getQiniuTockenforImage:(UIImage *)Image{
    WS(weakSelf);
    if (self.imageMutableArray.count < 3) {
        [NNBUtilRequest UtilRequestGetQNTokenWithOperateType:nil Success:^(NSString *path, NSString *qiniu_token) {
            NSLog(@"%@, %@", path, qiniu_token);
            if (weakSelf.imageMutableArray.count == 0) {
                [self.view showLoadingView:@"上传中"];
            }
            if (qiniu_token) {
                UIImage *imageNew = [NNBUploadManager compressionImage:Image proportion:1];
                NSData *data = [JYCSimpleToolClass dataByImage:imageNew];
                [[NNBUploadManager defaultManager] putData:data key:path token:qiniu_token progressHandler:^(NSString *key, float percent) {
                    DLog(@"key = %@,percent = %f", key, percent);
                } complete:^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
                    DLog(@"%@", info);
                    DLog(@"%@", key);
                    DLog(@"%@",resp);
                    // 0 正 1 反 2 手持
                    [weakSelf.imageArray removeObjectAtIndex:0];
                    [weakSelf.imageMutableArray addObject:key];
                    if (weakSelf.imageMutableArray.count != 3) {
                        [weakSelf getQiniuTockenforImage:weakSelf.imageArray[0]];
                    } else {
                        [weakSelf.view dismissLoadingStatusViewWithCompletion:^(BOOL Completion) {
                            if (Completion) {
                                if (self.successUploadBlock){
                                    self.successUploadBlock(weakSelf.imageMutableArray);
                                }
                            }
                        }];
                    }
                } fail:^(id error) {
                    [weakSelf.view dismissLoadingViewWithCompletion:nil];
                }];
            } else {
                // 提示网络故障
                [self.view dismissLoadingViewWithCompletion:^(BOOL finish) {
                    [self.view showAnimationErrorStaus:@"当前网络状态不佳，请重试" completion:nil];
                    
                }];
            }
        } fail:nil];
    }
}
- (IBAction)fixAction:(UIButton *)sender {
    // 如果按钮是fix 点击后 改为 保存状态
    if (self.btnType == btnfixType){
        
        [self.bottomButton setTitle:@"保存" forState:UIControlStateNormal];
        self.btnType = btnsaveType;
        self.canSaved = false;
        
    } else if (self.btnType == btnsaveType){
        // 发起保存操作
        // 验证在点击之前做 如果不符合规则 按钮不可点击
        NSString *cmd;
        NSMutableDictionary *para;
        if (self.fixType == fixName && self.taskID && self.nameTextField.text){
            cmd = @"account.idcard_change.update_name";
            para = [[NSMutableDictionary alloc] initWithDictionary: @{@"_id": self.taskID, @"name": self.nameTextField.text}];
            
            [self saveAction:cmd AndPara:para];

        } else {
            if (self.taskID && self.startdate && self.enddate){
                
                para = [[NSMutableDictionary alloc] initWithDictionary: @{
                    @"_id": self.taskID,
                    @"identity_card_id": self.IDCardTextField.text,
                    @"idcard_type": @(10),
                    @"idcard_start_date": @(self.startdate),
                    @"idcard_end_date": @(self.enddate)
                }];
                if (self.fixType == fixIDNumber){
                    cmd = @"account.idcard_change.update_idcard_no";
                } else if (self.fixType == fixIDCardDate){
                    cmd = @"account.idcard_change.upload_available_idcard";
                    [para setObject:self.nameTextField.text forKey:@"name"];
                    int gender = 0;
                    if ([self.genderTextField.text isEqualToString:@"男"]){
                        gender = 10;
                    } else {
                        gender = 20;
                    }
                    [para setObject:@(gender) forKey:@"gender_id"];
                } else if (self.fixType == fixIDcard){
                    cmd = @"account.idcard_change.invalid_temporary_idcard";
                    [para setObject:self.nameTextField.text forKey:@"name"];
                    int gender = 0;
                    if ([self.genderTextField.text isEqualToString:@"男"]){
                        gender = 10;
                    } else {
                        gender = 20;
                    }
                    [para setObject:@(gender) forKey:@"gender_id"];
                }
                // 首先 上传图片
                if (self.imageArray.count > 0){
                    [self getQiniuTockenforImage:self.imageArray[0]];
                }
                // 发起保存操作
                WS(weakSelf)
                self.successUploadBlock = ^(NSMutableArray *arr) {
                    // 上传完成
                    if (arr.count >= 3){
                        [para setObject:arr[0] forKey:@"identity_card_front"];
                        [para setObject:arr[1] forKey:@"identity_card_back"];
                        [para setObject:arr[2] forKey:@"hand_bust"];
                    }
                    
                    [weakSelf saveAction:cmd AndPara:para];
                };
            }
        }
    }
}
- (void)saveAction:(NSString *)cmd AndPara:(NSMutableDictionary *)para{
    [NNBBasicRequest postJsonWithUrl:kUrl parameters: para CMD:cmd success:^(id responseObject) {
        // TODO: 处理返回结果
        BOOL isok = [responseObject objectForKey:@"ok"];
        if (isok){
            [self.navigationController popViewControllerAnimated:true];
        } else {
            // 错误处理
        }
    } fail:^(id error) {
        NSLog(@"%@", error);
    }];
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField == self.nameTextField){
        NSString *content = [self removeSpaceAndNewline:textField.text];
        // 过滤空格 过滤后如果长度小于0则不可提交
        if (content.length <= 0){
            self.canSaved = false;
            return;
        }
        // 只有修改类型为 修改姓名时 可以只验证当前name输入是否符合规则
        if (self.fixType == fixName){
            if ([content isEqualToString:kCurrentBossOwnerAccount.accountModel.name]){
                // 错误 更改后 与原姓名不可一致
                // 显示错误View
                self.nameErrorViewHeight.constant = 42;
                self.errorNameLabel.text = @"当前姓名与录入姓名不可一致";
                self.canSaved = false;
                [self.nameErrorView setHidden:false];
                return;
            } else {
                self.nameErrorViewHeight.constant = 0;
                [self.nameErrorView setHidden:true];
            }
            self.canSaved = true;
        } else {
            if ([content isEqualToString:kCurrentBossOwnerAccount.accountModel.name]){
                self.nameErrorViewHeight.constant = 0;
                [self.nameErrorView setHidden:true];
                [self fixButtonIsClicked];
            } else {
                // 不可编辑
                self.canSaved = false;
                self.nameErrorViewHeight.constant = 42;
                self.errorNameLabel.text = @"当前姓名与录入姓名不一致";
                [self.nameErrorView setHidden:false];
            }
        }
    }
}

- (NSString *)removeSpaceAndNewline:(NSString *)str
{
    NSString *temp = [str stringByReplacingOccurrencesOfString:@" " withString:@""];
    temp = [temp stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    temp = [temp stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    return temp;
}
@end
