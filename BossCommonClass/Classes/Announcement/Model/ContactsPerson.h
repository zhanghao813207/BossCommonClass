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
@property(nonatomic, copy)NSString *account_name;
@property(nonatomic, copy)NSString *head_img;
@property(nonatomic, copy)NSString *nick_name;
@property(nonatomic, assign)NSInteger sex;
@end

NS_ASSUME_NONNULL_END
