//
//  TestGroupModel.h
//  AFNetworking
//
//  Created by admin on 2019/4/17.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TestGroupModel : NSObject


/**
 组内被选中的人数
 */
@property(nonatomic, assign)NSInteger selectCount;
@property(nonatomic, copy)NSString *name;
@end

NS_ASSUME_NONNULL_END
