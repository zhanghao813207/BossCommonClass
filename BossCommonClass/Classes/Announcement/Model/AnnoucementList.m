
//
//  AnnoucementList.m
//  AFNetworking
//
//  Created by admin on 2019/4/22.
//

#import "AnnoucementList.h"
#import "MJExtension.h"
@implementation AnnoucementList
- (instancetype)init
{
    self = [super init];
    if (self) {
        [AnnoucementList mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"media_info_list":@"Media_info"};
        }];
    }
    return self;
}
@end
