//
//  BOPramaShareModel.h
//  Pods
//
//  Created by admin on 2019/7/18.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BOPramaShareModel : NSObject

@property (nonatomic, copy)NSString *teamID;
@property (nonatomic, copy)NSString *staffID;
+ (instancetype)sharedSingleton;


@end

NS_ASSUME_NONNULL_END
