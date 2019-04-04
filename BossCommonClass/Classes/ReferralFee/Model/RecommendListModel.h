//
//  RecommendListModel.h
//  AFNetworking
//
//  Created by admin on 2019/4/1.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RecommendListModel : NSObject
@property(nonatomic, copy)NSString *_id;
@property(nonatomic, copy)NSString *name;
@property(nonatomic, copy)NSString *phone;
@property(nonatomic, copy)NSString *code;
@property(nonatomic, copy)NSString *address;
@property(nonatomic, assign)BOOL is_complete;
@property(nonatomic, assign)NSInteger position_id;
@property(nonatomic, copy)NSString *updated_at;
@property(nonatomic, copy)NSString *submited_at;
@property(nonatomic, copy)NSString *entry_date;
@end

NS_ASSUME_NONNULL_END
