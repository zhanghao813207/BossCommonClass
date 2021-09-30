//
//  NNBBasicRequest.h
//  基础请求
//
//  Created by 贾远潮 on 2017/9/19.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, ResultDealTypes) {
    ResultDealTypesNone           = 1, // 不做处理
    ResultDealTypesQHErrorView    = 2, // 使用QHErrorView弹出错误
    ResultDealTypesNNBStatusView  = 3, // 使用NNBStatusView弹出错误
};

@interface NNBBasicRequest : NSObject
/** post请求 ,所有错误不做统一校验 再返回 */
+ (void)postJsonNoneWithUrl:(NSString *)urlStr parameters:(id)parameters CMD:(NSString *)cmd success:(void (^)(id responseObject))success fail:(void (^)(id error))fail;

/** post请求 ,所有错误统一校验 再返回 */
+ (void)postJsonWithUrl:(NSString *)urlStr parameters:(id)parameters CMD:(NSString *)cmd success:(void (^)(id responseObject))success fail:(void (^)(id error))fail;

/** post请求 (使用NNBStatusView处理),所有错误统一校验 再返回 */
+ (void)postLoginJsonWithUrl:(NSString *)url parameters:(id)parameters CMD:(NSString *)cmd success:(void (^)(id responseObject))success fail:(void (^)(id error))fail;


/** post请求, post请求,不做任何处理返回 */
+ (void)postJsonNativeWithUrl:(NSString *)url parameters:(id)parameters cmd:(NSString *)cmd success:(void (^)(id responseObject))success fail:(void (^)(id error))fail;



@end
