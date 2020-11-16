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
#import "BossOwnerAccount.h"
#import "YYCache.h"

@import boss_basic_common_ios;

@implementation BossCache

static BossCache *defaultCache = nil;

@synthesize currentSaasModel = _currentSaasModel;

@synthesize currentManagerAccount = _currentManagerAccount;

@synthesize currentKnightAccount = _currentKnightAccount;

@synthesize currentBossOwnerAccount = _currentBossOwnerAccount;

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
    if(_currentSaasModel){
        [kUserDefault setObject:[_currentSaasModel decodeToDic] forKey:SAAS_KEY];
        [kUserDefault synchronize];
    }
}

- (BossKnightAccount *)currentKnightAccount
{
    if(!_currentKnightAccount){
        NSDictionary *accountDic = [kUserDefault objectForKey:ACCOUNT_KEY];
        if(accountDic){
            BossKnightAccount *accountModel = [[BossKnightAccount alloc] init];
            [accountModel setValuesForKeysWithDictionary:accountDic];
            _currentKnightAccount = accountModel;
        }
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
            _currentManagerAccount = accountModel;
        }
    }
    return _currentManagerAccount;
}

- (BossOwnerAccount *)currentBossOwnerAccount
{
    if(!_currentBossOwnerAccount){
        NSDictionary *accountDic = [kUserDefault objectForKey:ACCOUNT_KEY];
        if(accountDic){
            BossOwnerAccount *accountModel = [[BossOwnerAccount alloc] init];
            accountModel.accountModel = [[BossOwnerUserModel alloc] initWithDictionary:accountDic[@"account"]];
//            [accountModel setValuesForKeysWithDictionary:accountDic];
            _currentBossOwnerAccount = accountModel;
        }
    }
    return _currentBossOwnerAccount;
   
}

- (void)setCurrentBossOwnerAccount:(BossOwnerAccount *)currentBossOwnerAccount{
    _currentBossOwnerAccount = currentBossOwnerAccount;
    
    [kUserDefault setObject:[_currentBossOwnerAccount decodeToDic] forKey:ACCOUNT_KEY];
    [kUserDefault synchronize];
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

- (NSMutableArray<NSString *> *)getlogoutPhoneList
{
    return [kUserDefault mutableArrayValueForKey:LOGOUT_PHONE_LIST_KEY];
}

- (void)addPhone:(NSString *)phone
{
    if([JYCSimpleToolClass stringIsEmpty:phone]){
        return;
    }
    NSMutableArray<NSString *> *logoutPhoneList = [kUserDefault mutableArrayValueForKey:LOGOUT_PHONE_LIST_KEY];
    if(!logoutPhoneList){
        logoutPhoneList = [NSMutableArray mutableCopy];
        [logoutPhoneList addObject:phone];
        return;
    }
    [logoutPhoneList addObject:phone];
    NSSet *logoutPhoneSet = [NSSet setWithArray:logoutPhoneList];
    [kUserDefault setObject:[logoutPhoneSet allObjects] forKey:LOGOUT_PHONE_LIST_KEY];
}

- (void)removePhone:(NSString *)phone
{
    NSMutableArray<NSString *> *logoutPhoneList = [kUserDefault mutableArrayValueForKey:LOGOUT_PHONE_LIST_KEY];
    if(!logoutPhoneList){
        return;
    }
    [logoutPhoneList removeObject:phone];
    if (logoutPhoneList.count == 0) {
        return;
    }
    [kUserDefault setObject:logoutPhoneList forKey:LOGOUT_PHONE_LIST_KEY];
}

- (void)initNetConfig:(nullable SaasModel *)saasModel
{
    _netConfig = saasModel ? @{
                               @"url":saasModel.url,
                               @"accessKey":saasModel.access_key,
                               @"secretKey":saasModel.secret_key
                               } : nil;
}

- (NSString *)url
{
    return [defaultCache getUrlByApiVersion:@"/2.0"];
}

- (NSString *)getUrlByApiVersion:(NSString *)apiVersion
{
    return _netConfig ? [NSString stringWithFormat:@"%@%@", [_netConfig objectForKey:@"url"], apiVersion] : BossBasicURLV2;
}

- (NSString *)accessKey
{
    return _netConfig ? [_netConfig objectForKey:@"accessKey"] : ACCESS_KEY;
}

- (NSString *)secretKey
{
    return _netConfig ? [_netConfig objectForKey:@"secretKey"] : SECRET_KEY;
}

- (NSString *)accessToken
{
    YYCache *cache = [[YYCache alloc] initWithName: @"QH"];
#ifdef kBossKnight
    return [cache objectForKey:@"accessToken"];
#elif defined kBossManager
    return self.currentManagerAccount.tokenModel.access_token;
#elif defined kBossOwner
    return [cache objectForKey:@"accessToken"];
#else
    return self.currentBossOwnerAccount.accountModel.accessToken;
#endif
}
#ifdef kBossManager

#else
- (BOOL)checkStartUMS{
    NSDictionary *dic = [CacheManager.manager getValueForKey:@"UMSKEY"];
    UmsAccessTokenModel *model = [[UmsAccessTokenModel alloc] initWithDictionary:dic];
    if (model){
        return true;
    }
    return false;
}
- (UmsAccessTokenModel*)umsAccessTokenModel{
    NSDictionary *dic = [CacheManager.manager getValueForKey:@"UMSKEY"];
    UmsAccessTokenModel *model = [[UmsAccessTokenModel alloc] initWithDictionary:dic];
    return model;
}
#endif

- (NSString *)umsAccessToken {
#ifdef kBossManager
    
#else
    NSDictionary *dic = [CacheManager.manager getValueForKey:@"UMSKEY"];
    self.umsAccessTokenModel = [[UmsAccessTokenModel alloc] initWithDictionary:dic];
#endif
    return self.umsAccessTokenModel ? self.umsAccessTokenModel.accessToken : @"";
}

- (NSString *)umsAccessKey {
#ifdef kBossManager
    
#else
    NSDictionary *dic = [CacheManager.manager getValueForKey:@"UMSKEY"];
    self.umsAccessTokenModel = [[UmsAccessTokenModel alloc] initWithDictionary:dic];
#endif
    return self.umsAccessTokenModel ? self.umsAccessTokenModel.accessKey : @"";
}

- (NSString *)umsSecretKey {
#ifdef kBossManager
    
#else
    NSDictionary *dic = [CacheManager.manager getValueForKey:@"UMSKEY"];
    self.umsAccessTokenModel = [[UmsAccessTokenModel alloc] initWithDictionary:dic];
#endif
    return self.umsAccessTokenModel ? self.umsAccessTokenModel.secretKey : @"";
}

- (BOOL)checkLogin
{
#ifdef kBossKnight
    return self.currentKnightAccount != nil;
#elif defined kBossManager
    return self.currentManagerAccount != nil;
#elif defined kBossOwner
    return self.currentBossOwnerAccount != nil;
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
            NSString *currentAccountPhone = [[accountDic objectForKey:@"account"] objectForKey:@"phone"];
            i = 0;
            for(NSDictionary* saveAccountDic in accountDicList){
                NSString *saveAccountId = [[saveAccountDic objectForKey:@"account"] objectForKey:@"_id"];
                NSString *saveAccountPhone = [[saveAccountDic objectForKey:@"account"] objectForKey:@"phone"];
                if([currentAccountId isEqualToString: saveAccountId] || [currentAccountPhone isEqualToString:saveAccountPhone]){
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
