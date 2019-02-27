//
//  Cache.m
//  AFNetworking
//
//  Created by 张浩 on 2019/2/21.
//

#import "BossCache.h"
#import "SaasModel.h"
#import "BossManagerAccount.h"
#import "BossKnightAccount.h"

@implementation BossCache

static BossCache *defaultCache = nil;

@synthesize currentSaasModel = _currentSaasModel;

@synthesize currentManagerAccount = _currentManagerAccount;

@synthesize currentKnightAccount = _currentKnightAccount;

@synthesize saasAccountList = _saasAccountList;

@synthesize lastLoginPhone = _lastLoginPhone;

+ (__kindof BossCache *)defaultCache
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        defaultCache = [[BossCache alloc] init];
    });
    return defaultCache;
}

- (SaasModel *)currentSaasModel
{
    
    if(!_currentSaasModel){
        NSDictionary *saasDic = [kUserDefault objectForKey:SAAS_KEY];
        if(saasDic){
            SaasModel *saasModel = [[SaasModel alloc] init];
            [saasModel setValuesForKeysWithDictionary:saasDic];
            _currentSaasModel = saasModel;
        }
    }
    return _currentSaasModel;
}

- (void)setCurrentSaasModel:(SaasModel *)currentSaasModel
{
    _currentSaasModel = currentSaasModel;
    
    [kUserDefault setObject:[_currentSaasModel decodeToDic] forKey:SAAS_KEY];
    [kUserDefault synchronize];
}

- (BossKnightAccount *)currentKnightAccount
{
    if(!_currentKnightAccount){
        NSDictionary *accountDic = [kUserDefault objectForKey:ACCOUNT_KEY];
        if(accountDic){
            BossKnightAccount *accountModel = [[BossKnightAccount alloc] init];
            [accountModel setValuesForKeysWithDictionary:accountDic];
            return accountModel;
        }
        return nil;
    }
    return _currentKnightAccount;
}

- (void)setCurrentKnightAccount:(BossKnightAccount *)currentKnightAccount
{
    _currentKnightAccount = currentKnightAccount;
    
    [kUserDefault setObject:[_currentKnightAccount decodeToDic] forKey:ACCOUNT_KEY];
    [kUserDefault synchronize];
}

- (BossManagerAccount *)currentManagerAccount
{
    if(!_currentManagerAccount){
        NSDictionary *accountDic = [kUserDefault objectForKey:ACCOUNT_KEY];
        if(accountDic){
            BossManagerAccount *accountModel = [[BossManagerAccount alloc] init];
            [accountModel setValuesForKeysWithDictionary:accountDic];
            return accountModel;
        }
        return nil;
    }
    return _currentManagerAccount;
}

- (void)setCurrentManagerAccount:(BossManagerAccount *)currentManagerAccount
{
    _currentManagerAccount = currentManagerAccount;
    
    [kUserDefault setObject:[_currentManagerAccount decodeToDic] forKey:ACCOUNT_KEY];
    [kUserDefault synchronize];
}

- (NSMutableArray<NSDictionary *> *)saasAccountList
{
    
    NSMutableArray *saasDicList = [kUserDefault mutableArrayValueForKey:ACCOUNT_LIST_KEY];
    if(!saasDicList){
        _saasAccountList = [NSMutableArray array];
    }else{
        _saasAccountList = saasDicList;
    }
    
    return _saasAccountList;
}

- (void)setLastLoginPhone:(NSString *)lastLoginPhone
{
    _lastLoginPhone = lastLoginPhone;
    [kUserDefault setObject:lastLoginPhone forKey:LAST_LOGIN_PHONE_KEY];
    [kUserDefault synchronize];
}

- (NSString *)lastLoginPhone
{
    _lastLoginPhone = [kUserDefault stringForKey:LAST_LOGIN_PHONE_KEY];
    return _lastLoginPhone;
}

- (NSString *)url
{
    if(self.currentSaasModel){
        return self.currentSaasModel.url;
    }
    return @"";
}

- (BOOL)checkLogin
{
#ifdef kBossKnight
    return self.currentKnightAccount != nil;
#elif defined kBossManager
    return self.currentManagerAccount != nil;
#else
    return NO;
#endif
}

- (void)addAccount:(NSDictionary *)accountDic
{
    NSDictionary *currentSaasDic = [kCache.currentSaasModel decodeToDic];
    // 检查是否保存过帐号
    if(self.saasAccountList.count <= 0){
        [[currentSaasDic objectForKey:@"accountList"] addObject:accountDic];
        [self.saasAccountList addObject:currentSaasDic];
    }else{
        // 检查saas是否存在
        int i = 0;
        for(NSDictionary* saasDic in self.saasAccountList){
            if([[currentSaasDic objectForKey:@"_id"] isEqualToString:[saasDic objectForKey:@"_id"]]){
                break;
            }
            i++;
        }
        
        // saas已存在
        if(i < self.saasAccountList.count){
            NSMutableDictionary *saasDic = [NSMutableDictionary dictionaryWithDictionary:self.saasAccountList[i]];
            NSMutableArray<NSDictionary *> *accountDicList = [NSMutableArray arrayWithArray:[saasDic objectForKey:@"accountList"]];
            // 检查account是否存在
            NSString *currentAccountId = [[accountDic objectForKey:@"account"] objectForKey:@"_id"];
            i = 0;
            for(NSDictionary* saveAccountDic in accountDicList){
                NSString *saveAccountId = [[saveAccountDic objectForKey:@"account"] objectForKey:@"_id"];
                if([currentAccountId isEqualToString: saveAccountId]){
                    break;
                }
                i++;
            }
            // account已存在
            if(i < accountDicList.count){
                [accountDicList replaceObjectAtIndex:i withObject:accountDic];
            }else{ // 不存在
                [accountDicList addObject:accountDic];
            }
            [saasDic setValue:accountDicList forKey:@"accountList"];
            i = 0;
            for(NSDictionary* saveSaasDic in self.saasAccountList){
                if([[saveSaasDic objectForKey:@"_id"] isEqualToString:[saasDic objectForKey:@"_id"]]){
                    break;
                }
                i++;
            }
            
            if(i < self.saasAccountList.count){
                [self.saasAccountList replaceObjectAtIndex:i withObject:saasDic];
            }
        }else{ // saas不存在
            [[currentSaasDic objectForKey:@"accountList"] addObject:accountDic];
            [self.saasAccountList addObject:currentSaasDic];
        }
        
    }
    
    [kUserDefault setObject:self.saasAccountList forKey:ACCOUNT_LIST_KEY];
    [kUserDefault synchronize];
}

- (void)removeAccount:(NSUInteger)saasIndex accountIndex:(NSUInteger)accountIndex
{
    NSMutableDictionary *saasDic = [NSMutableDictionary dictionaryWithDictionary:self.saasAccountList[saasIndex]];
    // 获取指定Saas下的帐号列表
    NSMutableArray<NSDictionary *> *accountDicList = [NSMutableArray arrayWithArray:[saasDic objectForKey:@"accountList"]];
    
    // 移除指定帐号
    [accountDicList removeObjectAtIndex:accountIndex];
    
    [saasDic setValue:accountDicList forKey:@"accountList"];
    
    [self.saasAccountList replaceObjectAtIndex:saasIndex withObject:saasDic];
    
    // 判断指定Saas下是否存在帐号
    if(accountDicList.count <= 0){
        // 不存在帐号，移除指定Saas
        [self.saasAccountList removeObjectAtIndex:saasIndex];
    }
    
    // 保存
    [kUserDefault setObject:self.saasAccountList forKey:ACCOUNT_LIST_KEY];
    [kUserDefault synchronize];
}

@end
