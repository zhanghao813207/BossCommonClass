//
//  TestGroupModel.h
//  AFNetworking
//
//  Created by admin on 2019/4/17.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger,SelectState) {
    SelectStateNo,//一个没选
    SelectStateAll,//全选
    SelectStateSubAll//部分选
};
NS_ASSUME_NONNULL_BEGIN

@interface TestGroupModel : NSObject
@property(nonatomic, assign)SelectState state;

/**
 组内被选中的人数
 */
@property(nonatomic, assign)NSInteger selectCount;
@property(nonatomic, copy)NSString *name;
@end

NS_ASSUME_NONNULL_END
