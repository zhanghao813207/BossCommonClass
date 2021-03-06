//
//  AnnoucementList.h
//  AFNetworking
//
//  Created by admin on 2019/4/22.
//

#import <Foundation/Foundation.h>
#import "Sender_info.h"
#import "Message_summary_info.h"
#import "Message_counter_info.h"
#import "ExtraDataModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface AnnoucementList : NSObject

/**
 是否回复收到
 */
@property(nonatomic, assign)BOOL is_copy;

/**
 是否已读
 */
@property(nonatomic, assign)BOOL is_read;

@property(nonatomic, strong)NSString *idField;


@property(nonatomic, strong)NSArray *media_info_list;
@property(nonatomic, strong)Message_counter_info *message_counter_info;

@property(nonatomic, strong)Message_summary_info *message_summary_info;


@property(nonatomic, strong) ExtraDataModel *extraDataModel;

@property(nonatomic, strong) Sender_info *sender_info;
@property(nonatomic, strong) NSString * message_id;


/// 是否全部标记为已读（本地字段）
@property (nonatomic, assign) BOOL isReadAll;

@property(nonatomic, assign)CGFloat progress;

@end


NS_ASSUME_NONNULL_END
