//
//  EntrustAccountRegistrationRequest.m
//  BossCommonClass
//
//  Created by 张浩 on 2019/5/22.
//

#import "EntrustAccountRegistrationRequest.h"
#import "NNBBasicRequest.h"
#import "BossBasicDefine.h"

@implementation EntrustAccountRegistrationRequest

+ (void)registerIndividualRegister:(nonnull successRegister)successBlock failBlock:(nonnull failBlock)failBlock{
    
    [NNBBasicRequest postJsonWithUrl:kUrl parameters:nil CMD:@"individual_register.individual_register.register" success:^(id responseObject) {
        NSLog(@"EntrustAccountRegistrationRequest->registerIndividualRegister->response:\n%@", responseObject);
        NSDictionary *dic = responseObject;
        IndividualRegisterResultModel *result = [[IndividualRegisterResultModel alloc] initWithDictionary:dic];
        successBlock(result);
    } fail:^(id error) {
        failBlock();
    }];
}

+ (void)getIndividualRegisterState:(successGetIndividualRegisterState)successBlock failBlock:(failBlock)failBlock{
    [NNBBasicRequest postJsonWithUrl:kUrl parameters:nil CMD:@"individual_register.individual_register.get" success:^(id responseObject) {
        NSLog(@"EntrustAccountRegistrationRequest->getIndividualRegisterState->response:\n%@", responseObject);
        NSDictionary *dic = responseObject;
        IndividualRegisterStateModel *result = [[IndividualRegisterStateModel alloc] initWithDictionary:dic];
        successBlock(result);
    } fail:^(id error) {
        failBlock();
    }];
}

@end
