//
//  AnnoucementList.h
//  AFNetworking
//
//  Created by admin on 2019/4/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AnnoucementList : NSObject
@property(nonatomic, copy)NSString *_id;
@property(nonatomic, assign)NSInteger message_type;
@property(nonatomic, assign)NSInteger extra_type_id;
@property(nonatomic, copy)NSString *title;
@property(nonatomic, copy)NSString *content;
@property(nonatomic, copy)NSString *group_id;
@property(nonatomic, assign)NSInteger state;
@property(nonatomic, copy)NSString *sender;
@end

NS_ASSUME_NONNULL_END
