//
//  AnnouncementDetail.h
//  AFNetworking
//
//  Created by admin on 2019/4/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AnnouncementDetail : NSObject
@property(nonatomic, copy)NSString *_id;
@property(nonatomic, assign)NSInteger message_mime_kind;
@property(nonatomic, copy)NSString *content;
@property(nonatomic, strong)NSArray *assets;
@end

NS_ASSUME_NONNULL_END
