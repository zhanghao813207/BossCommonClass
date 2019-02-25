//
//  BossAccount.h
//  AFNetworking
//
//  Created by 贾远潮 on 2018/7/16.
//

#import <Foundation/Foundation.h>
#import "BossBasicDefine.h"
#import "BossManagerAccountModel.h"
#import "BaseAccount.h"

@interface BossManagerAccount : BaseAccount <BaseAccount>

@property (nonatomic, strong) BossManagerAccountModel *accountModel;

@end
