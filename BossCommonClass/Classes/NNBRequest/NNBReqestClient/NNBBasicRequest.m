//
//  NNBBasicRequest.m
//  NNBar_knight
//
//  Created by 贾远潮 on 2017/9/19.
//  Copyright © 2017年 贾远潮. All rights reserved.
//

#import "NNBBasicRequest.h"
#import "NNBRequestManager.h"
#import "QHErrorView.h"
#import "NNBResponseModel.h"
#import "NNBBasicDefine.h"

@implementation NNBBasicRequest

/**
 post请求 错误参数统一处理
 
 @param url URL
 @param parameters 请求参数
 @param success 成功返回参数
 @param fail 失败返回参数
 */
+ (void)postJsonWithUrl:(NSString *)url parameters:(id)parameters CMD:(NSString *)cmd success:(void (^)(id))success fail:(void (^)(id))fail
{
    [self postJsonNativeWithUrl:url parameters:parameters cmd:cmd success:^(id responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        if (dic[@"err_code"]) {
            dispatch_async(dispatch_get_main_queue(), ^{
                UIView *showView;
                if ([NNBSimpleToolClass getCurrentVC].parentViewController) {
                    showView = [NNBSimpleToolClass getCurrentVC].parentViewController.view;
                } else {
                    showView = [NNBSimpleToolClass getCurrentVC].view;
                }
                [[[QHErrorView alloc] initWithTitle:dic[@"zh_message"] ? : @"未知错误"] showInView:showView];
            });
            if (fail) {
                fail(dic);
            }
            return;
        }
        if (success) {
            success(dic);
        }
    } fail:^(id error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            UIView *showView;
            if ([NNBSimpleToolClass getCurrentVC].parentViewController) {
                showView = [NNBSimpleToolClass getCurrentVC].parentViewController.view;
            } else {
                showView = [NNBSimpleToolClass getCurrentVC].view;
            }
            [[[QHErrorView alloc] initWithTitle:@"网络连接错误"] showInView:showView];
        });
        if (fail) {
            fail(error);
        }
    }];
}

/**
 post请求 错误参数统一处理(使用NNBStatusView处理)
 
 @param url URL
 @param parameters 请求参数
 @param success 成功返回参数
 @param fail 失败返回参数
 */
+ (void)postLoginJsonWithUrl:(NSString *)url parameters:(id)parameters CMD:(NSString *)cmd success:(void (^)(id))success fail:(void (^)(id))fail
{
    [self postJsonNativeWithUrl:url parameters:parameters cmd:cmd success:^(id responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        if (dic[@"err_code"]) {
            NSLog(@"cmd = %@",cmd);
            NSLog(@"dic = %@",dic);
            dispatch_async(dispatch_get_main_queue(), ^{
                UIView *showView;
                if ([NNBSimpleToolClass getCurrentVC].parentViewController) {
                    showView = [NNBSimpleToolClass getCurrentVC].parentViewController.view;
                } else {
                    showView = [NNBSimpleToolClass getCurrentVC].view;
                }
                [showView showStatus:dic[@"zh_message"] ? : @"未知错误"];
                if (fail) {
                    fail(dic);
                }
            });
            return;
        }
        if (success) {
            success(dic);
        }
    } fail:^(id error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            UIView *showView;
            if ([NNBSimpleToolClass getCurrentVC].parentViewController) {
                showView = [NNBSimpleToolClass getCurrentVC].parentViewController.view;
            } else {
                showView = [NNBSimpleToolClass getCurrentVC].view;
            }
            [showView showStatus:@"网络连接错误"];
            if (fail) {
                fail(error);
            }
        });
    }];
}

/**
 post请求 结果不做任何处理
 
 @param url URL
 @param parameters 请求参数
 @param success 成功返回参数
 @param fail 失败返回参数
 */
+ (void)postJsonNativeWithUrl:(NSString *)url parameters:(id)parameters cmd:(NSString *)cmd success:(void (^)(id))success fail:(void (^)(id))fail
{
    NNBRequestManager *manager = [self configureManagerWithCMD:cmd];
    DLog(@"parameters = %@",parameters);
    [manager POST:url parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        DLog(@"requestSuccessUrl: %@ \n date:%@",task.currentRequest.URL,[NSDate date]);
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        DLog(@"requestErrorUrl: %@ \n date:%@",task.currentRequest.URL,[NSDate date]);
        DLog(@"%@",[error localizedDescription]);
        if (fail) {
            fail(error);
        }
    }];
    
}

#pragma mark -- praviteMethod

+ (NNBRequestManager *)configureManagerWithCMD:(NSString *)cmd
{
    NNBRequestManager *manager = [NNBRequestManager shareNNBRequestManager];
    
    [manager addTokenWithCMD:cmd];
        
    return manager;
}

+ (void)errorInfo:(NSError *)error
              url:(NSString *)url
         callBack:(void (^)(id response))result {
    if (!error){
        if (result) {
            NSError *err = [[NSError alloc] init];
            result(@{@"error":err});
        }
        return;
    }
    NSString *ErrorResponse = [[NSString alloc] initWithData:(NSData *)error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey] encoding:NSUTF8StringEncoding];
    NSError *err = nil;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:[ErrorResponse dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:&err];
    
    if (!err){
        err = [[NSError alloc] initWithDomain:@"" code:[dic[@"err_code"] integerValue] userInfo:dic];
    }
    if (result) {
        result(@{@"error":err});
    }
}

+ (void)handleErrorWithCMD:(NSString *)cmd response:(NSDictionary *)response fail:
(void (^)(id))fail
{
    NSInteger errorCode = [(NSError *)response[@"error"] code];
    NNBResponseModel *responseModel = [[NNBResponseModel alloc] init];
    responseModel.code = [NSString stringWithFormat:@"%ld",(long)errorCode];
    dispatch_async(dispatch_get_main_queue(), ^{
        UIView *showView;
        if ([NNBSimpleToolClass getCurrentVC].parentViewController) {
            showView = [NNBSimpleToolClass getCurrentVC].parentViewController.view;
        } else {
            showView = [NNBSimpleToolClass getCurrentVC].view;
        }
        [[[QHErrorView alloc] initWithTitle:responseModel.illustrate] showInView:showView];
    });
    if (fail) {
        fail(response);
    }
}

@end
