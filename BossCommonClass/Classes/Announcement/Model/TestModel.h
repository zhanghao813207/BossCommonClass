//
//  TestModel.h
//  即时通讯界面
//
//  Created by admin on 2019/4/11.
//  Copyright © 2019 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TestModel : NSObject

/**
 是不是自己发的公告
 */
@property(nonatomic, assign)BOOL isMe;
@property(nonatomic, copy)NSString *title;
@property(nonatomic, copy)NSString *text;
@property(nonatomic, copy)NSString *imgUrl;
@end

NS_ASSUME_NONNULL_END
