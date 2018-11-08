//
//  OperationTypes.m
//  NNBarKnight
//
//  Created by 贾远潮 on 2017/10/17.
//  Copyright © 2017年 贾远潮. All rights reserved.
//

#import "OperationTypes.h"

@interface OperationTypes()

@property (nonatomic, strong) NSString *IN;

@property (nonatomic, strong) NSString *OUT;

@property (nonatomic, strong) NSString *PICKUP;

@property (nonatomic, strong) NSString *STOCK_CHECK;

@property (nonatomic, strong) NSString *RETURN;

@property (nonatomic, strong) NSString *ARRIVE;

@property (nonatomic, strong) NSString *STOCK_DETAILS_CHECK;

@property (nonatomic, strong) NSString *SHELF_INSTALL;

@property (nonatomic, strong) NSString *LEAVE;

@end

@implementation OperationTypes

+ (__kindof OperationTypes *)defaultType
{
    static OperationTypes *type = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        type = [[OperationTypes alloc] init];
        type.IN = @"in";
        type.OUT = @"out";
        type.PICKUP = @"pickup";
        type.STOCK_CHECK = @"stock_check";
        type.RETURN = @"return";
        type.ARRIVE = @"arrive";
        type.STOCK_DETAILS_CHECK = @"stock_details_check";
        type.SHELF_INSTALL = @"shelf_install";
        type.LEAVE = @"leave";
    });
    return type;
}

@end
