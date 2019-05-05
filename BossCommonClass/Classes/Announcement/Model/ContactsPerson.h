//
//  ContactsPerson.h
//  AFNetworking
//
//  Created by admin on 2019/4/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ContactsPerson : NSObject
@property(nonatomic, copy)NSString *_id;
@property(nonatomic, copy)NSString *head_img_url;
@property(nonatomic, copy)NSString *nick_name;
@property(nonatomic, assign)BOOL isSelect;
@end

NS_ASSUME_NONNULL_END
