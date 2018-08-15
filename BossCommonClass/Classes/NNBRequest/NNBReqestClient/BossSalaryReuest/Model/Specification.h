//
//  Specification.h
//  AFNetworking
//
//  Created by 贾远潮 on 2018/8/13.
//

#import <Foundation/Foundation.h>
#import "SubItemBean.h"
@interface Specification : NSObject

@property (nonatomic, strong) NSString *item_name;

@property (nonatomic, assign) CGFloat item_value;

@property (nonatomic, strong) NSArray <SubItemBean *>*sub_item;



@end
