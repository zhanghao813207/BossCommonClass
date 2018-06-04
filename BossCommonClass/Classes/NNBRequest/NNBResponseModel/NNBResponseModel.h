//
//  NNBResponseModel.h
//  NNBarKnight
//
//  Created by 贾远潮 on 2017/9/20.
//  Copyright © 2017年 贾远潮. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NNBResponseModel : NSObject

/**
 *  状态码
 */
@property (nonatomic, copy) NSString *code;
/**
 *  对应信息
 */
@property (nonatomic, copy) NSString *message;
/**
 *  转换成用于显示的文字信息
 */
@property (nonatomic, copy) NSString *illustrate;

@end
