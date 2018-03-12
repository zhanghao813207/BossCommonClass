//
//  NNBBasicRequest.h
//  NNBar_knight
//
//  Created by 贾远潮 on 2017/9/19.
//  Copyright © 2017年 贾远潮. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NNBBasicRequest : NSObject

/** post请求 ,所有错误统一校验 再返回 */
+ (void)postJsonWithUrl:(NSString *)urlStr parameters:(id)parameters CMD:(NSString *)cmd success:(void (^)(id responseObject))success fail:(void (^)(id error))fail;

/** post请求 (使用NNBStatusView处理),所有错误统一校验 再返回 */
+ (void)postLoginJsonWithUrl:(NSString *)url parameters:(id)parameters CMD:(NSString *)cmd success:(void (^)(id))success fail:(void (^)(id))fail;


/** post请求, post请求,不做任何处理返回 */
+ (void)postJsonNativeWithUrl:(NSString *)url parameters:(id)parameters cmd:(NSString *)cmd success:(void (^)(id))success fail:(void (^)(id))fail;

@end
