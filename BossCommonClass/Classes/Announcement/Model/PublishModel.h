//
//  PublishModel.h
//  BossCommonClass
//
//  Created by admin on 2019/4/19.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PublishModel : NSObject

/**
 标题 必传
 */
@property(nonatomic, copy)NSString *title;

/**
 接受人列表 必传
 */
@property(nonatomic, strong)NSArray *members;

/**
 公告内容 必传
 */
@property(nonatomic, copy)NSString *content;

/**
 附件id列表  非必传
 */
@property(nonatomic, strong)NSArray *media_ids;
@end

NS_ASSUME_NONNULL_END
