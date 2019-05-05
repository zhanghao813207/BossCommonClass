//
//  AnnounceListHeader.h
//  AFNetworking
//
//  Created by admin on 2019/4/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AnnounceListHeader : NSObject
@property(nonatomic, assign)BOOL has_more;
@property(nonatomic, assign)NSInteger page;
@property(nonatomic, assign)NSInteger page_size;
@property(nonatomic, assign)NSInteger result_count;
@end

NS_ASSUME_NONNULL_END
