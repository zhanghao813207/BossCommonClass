//
//  BOPramaShare.m
//  AFNetworking
//
//  Created by admin on 2019/7/18.
//

#import "BOPramaShare.h"

@implementation BOPramaShare
+ (instancetype)sharedSingleton
{
    static BOPramaShare *_pramaShare = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //不能再使用alloc方法
        //因为已经重写了allocWithZone方法，所以这里要调用父类的分配空间的方法
        _pramaShare = [[super allocWithZone:NULL] init];
    });
    return _pramaShare;
}

// 防止外部调用alloc 或者 new
+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    return [BOPramaShare sharedSingleton];
}

// 防止外部调用copy
- (id)copyWithZone:(nullable NSZone *)zone {
    return [BOPramaShare sharedSingleton];
}

@end
