//
//  AddressBookVC.h
//  AFNetworking
//
//  Created by admin on 2019/4/17.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol AddressBookVCDelegate <NSObject>

/**
 

 @param modelArr 选中的数组
 @param select 是否全选
 */
- (void)select:(NSArray *)modelArr;

@end
@interface AddressBookVC : UIViewController
@property(nonatomic, weak)id<AddressBookVCDelegate>delegate;
@end

NS_ASSUME_NONNULL_END
