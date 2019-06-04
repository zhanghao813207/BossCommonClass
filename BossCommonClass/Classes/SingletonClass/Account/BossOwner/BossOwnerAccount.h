//
//  BossOwnerAccount.h
//  BossOwnerLogin
//
//  Created by 高炀辉 on 2019/4/30.
//

#import <Foundation/Foundation.h>
#import "BossBasicDefine.h"
#import "BossOwnerUserModel.h"
#import "BaseAccount.h"

NS_ASSUME_NONNULL_BEGIN

@interface BossOwnerAccount : BaseAccount <BaseAccount>

@property (nonatomic, strong) BossOwnerUserModel *accountModel;

@end

NS_ASSUME_NONNULL_END
