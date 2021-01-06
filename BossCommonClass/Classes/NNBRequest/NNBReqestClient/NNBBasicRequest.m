//
//  NNBBasicRequest.m
//  NNBar_knight
//
//  Created by 贾远潮 on 2017/9/19.
//

#import "NNBBasicRequest.h"
#import "NNBRequestManager.h"
#import "QHErrorView.h"
#import "NNBResponseModel.h"
#import "BossBasicDefine.h"
#import "BossKnightAccount.h"
#import "BossManagerAccount.h"
#import "MQTTClientModel.h"
#import "NSString+Router.h"
#import "TraceManager.h"
#import "JYCSimpleToolClass.h"

@class ViewController;

@implementation NNBBasicRequest

/**
 post请求 错误参数不做统一校验
 
 @param url URL
 @param parameters 请求参数
 @param success 成功返回参数
 @param fail 失败返回参数
 */
/** post请求 ,所有错误不做统一校验 再返回 */
+ (void)postJsonNoneWithUrl:(NSString *)url parameters:(id)parameters CMD:(NSString *)cmd success:(void (^)(id responseObject))success fail:(void (^)(id error))fail;
{
    [self postJsonNativeWithUrl:url parameters:parameters cmd:cmd success:^(id responseObject) {
        [self handleSuccessWithResponseObject:responseObject dealType:ResultDealTypesNone success:success fail:fail];
    } fail:^(id error) {
        [self handleFailWithError:error dealType:ResultDealTypesNone success:success fail:fail];
    }];
}

/**
 post请求 错误参数统一处理
 
 @param url URL
 @param parameters 请求参数
 @param success 成功返回参数
 @param fail 失败返回参数
 */
+ (void)postJsonWithUrl:(NSString *)url parameters:(id)parameters CMD:(NSString *)cmd success:(void (^)(id responseObject))success fail:(void (^)(id error))fail
{
    NSLog(@"-------------------------------------------\n请求URL:%@\n------------------------------------\n请求CMD:%@",url,cmd);
    [self postJsonNativeWithUrl:url parameters:parameters cmd:cmd success:^(id responseObject) {
        [self handleSuccessWithResponseObject:responseObject dealType:ResultDealTypesQHErrorView success:success fail:fail];
    } fail:^(id error) {
        // 校验是否获取消息推送请求token的接口
        NSLog(@"fail=========%@",cmd);
        
        if(cmd && [cmd isEqualToString:@"auth.token.get_ums_access_token"]){
            kCache.checkStartUMS = NO;
            if(fail){
                fail(error);
            }
            return;
        }
        [self handleFailWithError:error dealType:ResultDealTypesQHErrorView success:success fail:fail];
    }];
}

/**
 post请求 错误参数统一处理(使用NNBStatusView处理)
 
 @param url URL
 @param parameters 请求参数
 @param success 成功返回参数
 @param fail 失败返回参数
 */
+ (void)postLoginJsonWithUrl:(NSString *)url parameters:(id)parameters CMD:(NSString *)cmd success:(void (^)(id responseObject))success fail:(void (^)(id error))fail
{
    [self postJsonNativeWithUrl:url parameters:parameters cmd:cmd success:^(id responseObject) {
        [self handleSuccessWithResponseObject:responseObject dealType:ResultDealTypesNNBStatusView success:success fail:fail];
    } fail:^(id error) {
        [self handleFailWithError:error dealType:ResultDealTypesNNBStatusView success:success fail:fail];
    }];
}

/**
 post请求 结果不做任何处理
 
 @param url URL
 @param parameters 请求参数
 @param success 成功返回参数
 @param fail 失败返回参数
 */ 
+ (void)postJsonNativeWithUrl:(NSString *)url parameters:(id)parameters cmd:(NSString *)cmd success:(void (^)(id responseObject))success fail:(void (^)(id error))fail
{
    
    NNBRequestManager *manager = [self configureManagerWithCMD:cmd];
    DLog(@"POST: parameters = %@ cmd = %@ url = %@",parameters,cmd,url);
    
    [manager POST:url parameters:parameters headers:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
         DLog(@"requestSuccessUrl: %@ \n date:%@",task.currentRequest.URL,[NSDate date]);
        if (success) {
          success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
           DLog(@"requestErrorUrl: %@ \n date:%@",task.currentRequest.URL,[NSDate date]);
           DLog(@"ERROR:%@",[error localizedDescription]);
           
           TraceError *model = [[TraceError alloc] initWithDictionary:@{
               @"url":url,
               @"headers":[JYCSimpleToolClass dictionaryToJson:[NNBRequestManager requestHeader]] ,
               @"data": [error localizedDescription]
           }];
           
           NSString *cmdName = @"";
           // 判断cmd是否为空
           if ([cmd isEmptyString]){
               // 如果为空，再判断 url 是否为空，如果不为空使用 url，否则使用默认值 @"" 空字符串。
               if (![url isEmptyString]){
                   cmdName = url;
               }
           }else {
           // 如果不为空直接用cmd
               cmdName = cmd;
           }
           
           [[TraceManager shareTraceManager] requestTrace:cmdName Error:model];
           
           [self handleErrorCodeWithError:error success:success fail:fail];
    }];
    
    
//    [manager POST:url parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
//
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        DLog(@"requestSuccessUrl: %@ \n date:%@",task.currentRequest.URL,[NSDate date]);
//        if (success) {
//            success(responseObject);
//        }
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        DLog(@"requestErrorUrl: %@ \n date:%@",task.currentRequest.URL,[NSDate date]);
//        DLog(@"ERROR:%@",[error localizedDescription]);
//
//        TraceError *model = [[TraceError alloc] initWithDictionary:@{
//            @"url":url,
//            @"headers":[JYCSimpleToolClass dictionaryToJson:[NNBRequestManager requestHeader]] ,
//            @"data": [error localizedDescription]
//        }];
//
//        NSString *cmdName = @"";
//        // 判断cmd是否为空
//        if ([cmd isEmptyString]){
//            // 如果为空，再判断 url 是否为空，如果不为空使用 url，否则使用默认值 @"" 空字符串。
//            if (![url isEmptyString]){
//                cmdName = url;
//            }
//        }else {
//        // 如果不为空直接用cmd
//            cmdName = cmd;
//        }
//
//        [[TraceManager shareTraceManager] requestTrace:cmdName Error:model];
//
//        [self handleErrorCodeWithError:error success:success fail:fail];
//    }];
}

+ (void)getJsonNativeWithURL:(NSString *)url parameters:(id)parameters cmd:(NSString *)cmd success:(void (^)(id responseObject))success fail:(void (^)(id error))fail
{
    NNBRequestManager *manager = [self configureManagerWithCMD:cmd];
    DLog(@"GET: parameters = %@",parameters);
    [manager GET:url parameters:parameters headers:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
      DLog(@"requestSuccessUrl: %@ \n date:%@",task.currentRequest.URL,[NSDate date]);
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         DLog(@"requestErrorUrl: %@ \n date:%@",task.currentRequest.URL,[NSDate date]);
         DLog(@"ERROR:%@",[error localizedDescription]);
        [self handleErrorCodeWithError:error success:success fail:fail];
    }];
    
//    [manager GET:url parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
//
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        DLog(@"requestSuccessUrl: %@ \n date:%@",task.currentRequest.URL,[NSDate date]);
//        if (success) {
//            success(responseObject);
//        }
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        DLog(@"requestErrorUrl: %@ \n date:%@",task.currentRequest.URL,[NSDate date]);
//        DLog(@"ERROR:%@",[error localizedDescription]);
//        [self handleErrorCodeWithError:error success:success fail:fail];
//    }];
}

/** get请求 ,所有错误统一校验 再返回 */
+ (void)getJsonWithUrl:(NSString *)urlStr parameters:(id)parameters CMD:(NSString *)cmd success:(void (^)(id responseObject))success fail:(void (^)(id error))fail
{
    [self getJsonNativeWithURL:urlStr parameters:parameters cmd:cmd success:^(id responseObject) {
        [self handleSuccessWithResponseObject:responseObject dealType:ResultDealTypesQHErrorView success:success fail:fail];
    } fail:^(id error) {
        [self handleFailWithError:error dealType:ResultDealTypesQHErrorView success:success fail:fail];
    }];
}

/** get请求 (使用NNBStatusView处理),所有错误统一校验 再返回 */
+ (void)getLoginJsonWithUrl:(NSString *)url parameters:(id)parameters CMD:(NSString *)cmd success:(void (^)(id responseObject))success fail:(void (^)(id error))fail
{
    [self getJsonNativeWithURL:url parameters:parameters cmd:cmd success:^(id responseObject) {
        [self handleSuccessWithResponseObject:responseObject dealType:ResultDealTypesNNBStatusView success:success fail:fail];
    } fail:^(id error) {
        [self handleFailWithError:error dealType:ResultDealTypesNNBStatusView success:success fail:fail];
    }];
}

#pragma mark -- praviteMethod

+ (NNBRequestManager *)configureManagerWithCMD:(NSString *)cmd
{
    NNBRequestManager *manager = [NNBRequestManager shareNNBRequestManager];
    
    [manager addTokenWithCMD:cmd];
        
    return manager;
}

+ (void)handleSuccessWithResponseObject:(id)responseObject dealType:(ResultDealTypes)dealType success:(void (^)(id responseObject))success fail:(void (^)(id error))fail
{
    NSDictionary *dic = (NSDictionary *)responseObject;
    if (dic[@"err_code"])
    {
        NSInteger errCode = [dic[@"err_code"] integerValue];
        // 400403:商户不使用消息系统
        if(errCode == 400403){
            kCache.checkStartUMS = NO;
            if (fail) {
                fail(dic);
            }
            return;
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            UIView *showView;
            UIViewController *vc = [JYCSimpleToolClass getCurrentVC];
            UIViewController *currentVc = vc;
            if (vc.parentViewController) {
                currentVc = vc.parentViewController;
            }
            if ([JYCSimpleToolClass getCurrentVC].parentViewController) {
                showView = [JYCSimpleToolClass getCurrentVC].parentViewController.view;
            } else {
                showView = [JYCSimpleToolClass getCurrentVC].view;
            }
            [showView dismissLoadingViewWithCompletion:nil];
            NSString *errorMsg;
            if (dic[@"zh_message"]) {
                errorMsg = dic[@"zh_message"];
            } else {
               errorMsg = [self zh_msgWithErrorCode:errCode];
            }
            if (dealType == ResultDealTypesQHErrorView) {
                [[[QHErrorView alloc] initWithTitle:errorMsg] showInView:showView];
            } else if (dealType == ResultDealTypesNNBStatusView){
                [showView showStatus:errorMsg];
            }
            if (errCode == 415001 || errCode == 415002) {
#ifdef kBossManager
                if(!kCurrentBossManagerAccount){
                    return;
                }
                NSString *phone = kCurrentBossManagerAccount.accountModel.phone;
                kCache.lastLoginPhone = phone;
                [kCache addPhone:phone];
                kCurrentBossManagerAccount = nil;
#else
//                if(!kCurrentBossOwnerAccount){
//                    return;
//                }
                kCurrentBossOwnerAccount = nil;
#endif
                NSLog(@"-- lastLoginPhone : %@",kCache.lastLoginPhone);
                kCache.umsAccessTokenModel = nil;
                [self performSelector:@selector(showLoginVcWithViewController:) withObject:currentVc afterDelay:2.f];
                // 断开MQTT链接
                [[MQTTClientModel sharedInstance] disconnect];
            }
        });
        if (fail) {
            fail(dic);
        }
        return;
    }
    if (success) {
        success(dic);
    }
}

+ (void)showLoginVcWithViewController:(UIViewController *)currentVc
{
    NSString *executableFile = [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleExecutableKey];
    NSLog(@"%@", executableFile);
    if ([executableFile isEqualToString:@"BossOwner"] || [executableFile isEqualToString:@"BossKnight"]) {
        [@"login" openURL];
    } else {
        UIViewController *rootVc = currentVc.navigationController.viewControllers.firstObject;
        if ([currentVc isKindOfClass:[UINavigationController class]]) {
            [(UINavigationController *)currentVc popToRootViewControllerAnimated:YES];
            rootVc = ((UINavigationController *)currentVc).viewControllers.firstObject;
        } else {
            [currentVc.navigationController popToRootViewControllerAnimated:YES];
        }
        if ([rootVc isKindOfClass:NSClassFromString(@"AccountManagerController")] || [rootVc isKindOfClass:NSClassFromString(@"LoginVC")]) {
            return;
        }
        if([rootVc isKindOfClass:NSClassFromString(@"AddressBookVC")] || [rootVc isKindOfClass:NSClassFromString(@"MessageViewController")] || [rootVc isKindOfClass:NSClassFromString(@"ExamineFlowViewController")] || [rootVc isKindOfClass:NSClassFromString(@"MineVc")]){
            [rootVc viewWillAppear:YES];
        }
    }
}

+ (void)handleErrorCodeWithError:(NSError *)error success:(void (^)(id responseObject))success fail:(void (^)(id error))fail
{
    NSData *errorData = error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey];
    // 校验请求信息是否为空
    if(errorData){
        // 输出错误信息
        DLog(@"ErrorResponse = %@",[[NSString alloc] initWithData:errorData encoding:NSUTF8StringEncoding]);
        // NSData转字典
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:errorData options:NSJSONReadingMutableContainers error:&error];
        // 判断是否业务错误，业务错误回调请求成功block
        if (dic[@"err_code"]){
            if (success) {
                success(dic);
            }
            return;
        }
    }
    
    if (fail) {
        fail(error);
    }
}

+ (void)handleFailWithError:(id)error dealType:(ResultDealTypes)dealType success:(void (^)(id responseObject))success fail:(void (^)(id error))fail
{
    dispatch_async(dispatch_get_main_queue(), ^{
        UIView *showView;
        if ([JYCSimpleToolClass getCurrentVC].parentViewController) {
            showView = [JYCSimpleToolClass getCurrentVC].parentViewController.view;
        } else {
            showView = [JYCSimpleToolClass getCurrentVC].view;
        }
        [showView dismissLoadingViewWithCompletion:nil];
        if (dealType == ResultDealTypesQHErrorView) {
            [[[QHErrorView alloc] initWithTitle:@"您的网络好像不给力，请稍后再试"] showInView:showView];
        } else if (dealType == ResultDealTypesNNBStatusView){
            [showView showStatus:@"您的网络好像不给力，请稍后再试"];
        }
        if (fail) {
            fail(error);
        }
    });
}

+ (NSString *)zh_msgWithErrorCode:(NSInteger)errorCode
{
    NSString *zh_msg = @"未知错误";
    switch (errorCode) {
        case 1005:
            zh_msg = @"请求外部数据失败";
            break;
        case 1006:
            zh_msg = @"未找到文件";
            break;
        case 1007:
            zh_msg = @"获取数据失败";
            break;
        case 1008:
            zh_msg = @"选择的关联人员已被关联";
            break;
        case 1009:
            zh_msg = @"缺失平台或者城市参数";
            break;
        case 1010:
            zh_msg = @"找不到城市";
            break;
        case 1011:
            zh_msg = @"找不到平台";
            break;
        case 1012:
            zh_msg = @"找不到商圈";
            break;
        case 1013:
            zh_msg = @"缺失工作性质";
            break;
        case 1014:
            zh_msg = @"未选择关联人员或关联人员不存在";
            break;
        case 1015:
            zh_msg = @"角色与职位不匹配";
            break;
        case 1016:
            zh_msg = @"参数类型错误";
            break;
        case 1017:
            zh_msg = @"该商圈已绑定站长";
            break;
        case 1018:
            zh_msg = @"匹配不到其他平台人员";
            break;
        case 1019:
            zh_msg = @"关联平台身份证已被绑定";
            break;
        case 1020:
            zh_msg = @"缺少供应商ID";
            break;
        case 1021:
            zh_msg = @"找不到供应商";
            break;
        case 1022:
            zh_msg = @"商圈已存在供应商";
            break;
        case 1023:
            zh_msg = @"供应商已存在";
            break;
        case 1024:
            zh_msg = @"存在未离职人员";
            break;
        case 1025:
            zh_msg = @"供应商已存在";
            break;
        case 1026:
            zh_msg = @"供应商已停用";
            break;
        case 1027:
            zh_msg = @"物资已经存在";
            break;
        case 1028:
            zh_msg = @"该账号未找到供应商";
            break;
        case 1029:
            zh_msg = @"material_list字段内容错误";
            break;
        case 1030:
            zh_msg = @"订单没找到";
            break;
        case 1031:
            zh_msg = @"非采购审核通过的单子无法报错";
            break;
        case 1032:
            zh_msg = @"该单子无法被审核";
            break;
        case 1033:
            zh_msg = @"物资库存量不够";
            break;
        case 1034:
            zh_msg = @"找不到该品目";
            break;
        case 1035:
            zh_msg = @"错误的职位状态操作";
            break;
        case 1036:
            zh_msg = @"人员已经离职";
            break;
        case 1037:
            zh_msg = @"工资单未找到";
            break;
        case 1038:
            zh_msg = @"工资单状态错误";
            break;
        case 1039:
            zh_msg = @"三方公司名称已存在";
            break;
        case 1040:
            zh_msg = @"三方公司不存在";
            break;
        case 1041:
            zh_msg = @"结算模板创建失败";
            break;
        case 1043:
            zh_msg = @"未采购任何物资";
            break;
        case 1044:
            zh_msg = @"人员未负责任何百度商圈";
            break;
        case 1045:
            zh_msg = @"无此任务";
            break;
        case 1046:
            zh_msg = @"报废数量超过历史采购数量";
            break;
        case 1047:
            zh_msg = @"该城市存在未审核报废单无法提交报废";
            break;
        case 1048:
            zh_msg = @"不可绑定非本用户创建的人员";
            break;
        case 1049:
            zh_msg = @"kpi模板已存在";
            break;
        case 1050:
            zh_msg = @"商圈已有站长负责";
            break;
        case 1051:
            zh_msg = @"KPI导入失败";
            break;
        case 1052:
            zh_msg = @"骑士类型名称已经被占用";
            break;
        case 1053:
            zh_msg = @"替跑记录已经存在";
            break;
        case 1054:
            zh_msg = @"请删除该运力工号下的所有运力后，再停用";
            break;
        case 1055:
            zh_msg = @"结算模板使用了该骑士类型";
            break;
        case 1056:
            zh_msg = @"找不到审批人";
            break;
        case 1057:
            zh_msg = @"该骑士账号为运力工号，请联系该骑士上一站长停用运力工号后，方可入职，否则影响结算";
            break;
        case 1060:
            zh_msg = @"该角色正在被占用，请稍后处理";
            break;
        case 1062:
            zh_msg = @"试算类型无法操作";
            break;
        case 1070:
            zh_msg = @"角色名称已存在";
            break;
        case 1071:
            zh_msg = @"所需修改的骑士类型不存在";
            break;
        case 1073:
            zh_msg = @"供应商id已存在";
            break;
        case 1074:
            zh_msg = @"平台城市商圈参数不对应";
            break;
        case 1075:
            zh_msg = @"三方公司创建失败";
            break;
        case 1076:
            zh_msg = @"三方公司更新失败";
            break;
        case 1077:
            zh_msg = @"骑士类型更新失败";
            break;
        case 1078:
            zh_msg = @"供应商更新失败";
            break;
        case 1079:
            zh_msg = @"账户更新失败";
            break;
        case 1080:
            zh_msg = @"白名单已经存在";
            break;
        case 1081:
            zh_msg = @"不能切换到该账号";
            break;
        case 1082:
            zh_msg = @"科目名称已经存在";
            break;
        case 1083:
            zh_msg = @"审批流名称已经存在";
            break;
        case 1084:
            zh_msg = @"费用名称已经存在";
            break;
        case 1085:
            zh_msg = @"模板信息未找到";
            break;
        case 1086:
            zh_msg = @"费用申请单删除失败";
            break;
        case 1087:
            zh_msg = @"费用申请单保存失败";
            break;
        case 1088:
            zh_msg = @"账号不可用";
            break;
        case 1089:
            zh_msg = @"费用申请单查询失败";
            break;
        case 1090:
            zh_msg = @"创建人不匹配";
            break;
        case 1091:
            zh_msg = @"费用申请单更新失败";
            break;
        case 1092:
            zh_msg = @"当前科目有子科目无法停用";
            break;
        case 1093:
            zh_msg = @"上级科目状态不正常";
            break;
        case 1094:
            zh_msg = @"当前有未完成的审批流程";
            break;
        case 1095:
            zh_msg = @"科目级别不匹配";
            break;
        case 1096:
            zh_msg = @"你现在还不能审批！";
            break;
        case 1097:
            zh_msg = @"信息不匹配！";
            break;
        case 1098:
            zh_msg = @"结算任务创建失败！";
            break;
        case 1099:
            zh_msg = @"供应商商圈信息不匹配！";
            break;
        case 2000:
            zh_msg = @"服务费汇总审核异常";
            break;
        case 2001:
            zh_msg = @"财务申请错误！";
            break;
        case 2002:
            zh_msg = @"房屋已存在";
            break;
        case 2003:
            zh_msg = @"自定义金额错误";
            break;
        case 2004:
            zh_msg = @"时间未到不能续租";
            break;
        case 2005:
            zh_msg = @"审批单信息未找到";
            break;
        case 2006:
            zh_msg = @"续租失败(费用类型错误)";
            break;
        case 2007:
            zh_msg = @"当前科目有审批中的申请单";
            break;
        case 2008:
            zh_msg = @"当前科目有待提交的申请单";
            break;
        case 2009:
            zh_msg = @"当前科目有驳回的申请单";
            break;
        case 2010:
            zh_msg = @"续租已逾期不可续租";
            break;
        case 2011:
            zh_msg = @"合同时间错误";
            break;
        case 2012:
            zh_msg = @"合同时间和每月交租时间不能被整除";
            break;
        case 2013:
            zh_msg = @"科目不为最低等级";
            break;
        case 2014:
            zh_msg = @"成本中心详情重复";
            break;
        case 2015:
            zh_msg = @"房屋编号未找到";
            break;
        case 2016:
            zh_msg = @"银行卡位数错误";
            break;
        case 2017:
            zh_msg = @"提交失败无审批数据";
            break;
        case 2018:
            zh_msg = @"OA结算单已存在";
            break;
        case 2019:
            zh_msg = @"无效的_id";
            break;
        case 2020:
            zh_msg = @"骑士类型错误";
            break;
        case 401001:
            zh_msg = @"参数缺失或错误";
            break;
        case 401002:
            zh_msg = @"发送验证码过于频繁,请一分钟后再发";
            break;
        case 401007:
            zh_msg = @"身份证号已存在";
            break;
        case 401008:
            zh_msg = @"验证码错误";
            break;
        case 401009:
            zh_msg = @"手机号已存在";
            break;
        case 404001:
            zh_msg = @"未找到符合条件的数据";
            break;
        case 405001:
            zh_msg = @"该账号没有调用该接口的权限";
            break;
        case 405002:
            zh_msg = @"没有操作参数中角色或职位的权限";
            break;
        case 405003:
            zh_msg = @"账户信息不匹配";
            break;
        case 405004:
            zh_msg = @"被修改用户有待处理任务无法被修改";
            break;
        case 405005:
            zh_msg = @"没有操作参数中商圈的权限";
            break;
        case 405006:
            zh_msg = @"没有操作参数中平台的权限";
            break;
        case 408001:
            zh_msg = @"账号没有找到";
            break;
        case 408002:
            zh_msg = @"当前账号已禁用，请联系客服邮箱service@cityio.cn";
            break;
        case 408003:
            zh_msg = @"人员没有找到";
            break;
        case 408004:
            zh_msg = @"账号更新内容错误";
            break;
        case 408005:
            zh_msg = @"昵称错误没有找到";
            break;
        case 409001:
            zh_msg = @"App不可用";
            break;
        case 410001:
            zh_msg = @"Appkey不可用";
            break;
        case 415001:
            // tocken过期
            zh_msg = @"登录信息已经过期，请重新登录";
            break;
        case 415002:
            // tocken过期
            zh_msg = @"登录信息已经过期，请重新登录";
            break;
        case 416001:
            zh_msg = @"发送验证码失败";
            break;
        default:
            break;
    }
    return zh_msg;
}

@end
