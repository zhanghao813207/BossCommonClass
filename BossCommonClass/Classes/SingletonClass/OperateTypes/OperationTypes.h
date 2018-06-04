//
//  OperationTypes.h
//  NNBarKnight
//
//  Created by 贾远潮 on 2017/10/17.
//  Copyright © 2017年 贾远潮. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OperationTypes : NSObject

/**
 入库／入仓操作
 */
@property (nonatomic, strong, readonly) NSString *IN;

/**
 出库／出仓操作
 */
@property (nonatomic, strong, readonly) NSString *OUT;

/**
 领货操作
 */
@property (nonatomic, strong, readonly) NSString *PICKUP;

/**
 总数盘点操作
 */
@property (nonatomic, strong, readonly) NSString *STOCK_CHECK;

/**
 退货操作
 */
@property (nonatomic, strong, readonly) NSString *RETURN;

/**
 到店操作
 */
@property (nonatomic, strong, readonly) NSString *ARRIVE;

/**
 明细盘点操作
 */
@property (nonatomic, strong, readonly) NSString *STOCK_DETAILS_CHECK;

/**
 安装货架操作
 */
@property (nonatomic, strong, readonly) NSString *SHELF_INSTALL;

/**
 离店操作
 */
@property (nonatomic, strong, readonly) NSString *LEAVE;


+ (__kindof OperationTypes *)defaultType;

@end
