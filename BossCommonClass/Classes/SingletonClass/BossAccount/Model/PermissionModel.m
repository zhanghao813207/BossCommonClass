//
//  PermissionModel.m
//  BossCommonClass
//
//  Created by 贾远潮 on 2018/7/16.
//

#import "PermissionModel.h"

@implementation PermissionModel

- (void)setValue:(id)value forKey:(NSString *)key
{
    if (!value || value == [NSNull null]) {
        return;
    }
    
//    if ([key isEqualToString:@"sku_lines"]) {
//        PosInfoModel *model = [[PosInfoModel alloc] init];
//        [model setValuesForKeysWithDictionary:value];
//        self.sku_lines = model;
//        return;
//    }
    
    if ([key isEqualToString:@"permission_class"]) {
        NSMutableArray *array = [NSMutableArray array];
        for (NSDictionary *dic in value) {
            PermissionClassModel *model = [[PermissionClassModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [array addObject:model];
        }
        self.permission_class = [array copy];
        return;
    }
    
    
    [super setValue:value forKey:key];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

- (NSDictionary *)decodeToDic
{
    NSDictionary *localDic = @{
                               @"available":@([@(self.available) boolValue]),
                               @"gid":@(self.gid),
                               @"pid":@(self.pid),

                               @"create_at":self.create_at ? : @"",
                               @"current_pid":self.current_pid ? : @"",
                               @"desc":self.desc ? : @"",
                               @"name":self.name ? : @"",
                               @"update_at":self.update_at ? : @"",

                               @"permission_class" : [self encodeArrayToArray:self.permission_class]
                               };
    return localDic;
}

- (NSArray *)encodeArrayToArray:(NSArray *)array
{
    NSMutableArray *arrayM = [NSMutableArray array];
    for (id model in array) {
        if ([model respondsToSelector:@selector(decodeToDic)]) {
            NSDictionary *dic = [model decodeToDic];
            [arrayM addObject:dic];
        }
    }
    return [arrayM copy];
}



@end
