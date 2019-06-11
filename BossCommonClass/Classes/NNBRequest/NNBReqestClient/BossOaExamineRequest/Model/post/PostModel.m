//
//  PostModel.m
//  AFNetworking
//
//  Created by 张浩 on 2019/6/10.
//

#import "PostModel.h"

@implementation PostModel

- (void)setValue:(id)value forKey:(NSString *)key
{
    if (!value || value == [NSNull null]) {
        return;
    }
    
    if ([key isEqualToString:@"account_info_list"]) {
        NSMutableArray *array = [NSMutableArray array];
        for (NSDictionary *dic in value) {
            AccountModel *model = [[AccountModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [array addObject:model];
        }
        self.account_info_list = [array copy];
        return;
    }
    
    [super setValue:value forKey:key];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

#pragma mark - getter

- (NSArray<AccountModel *> *)account_info_list {
    for (AccountModel *model in _account_info_list) {
        if(model){
            model.postId = self._id;
            model.postName = self.post_name;
        }
    }
    return _account_info_list;
}

@end
