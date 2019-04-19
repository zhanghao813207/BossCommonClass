//
//  PersonAddressBookCell.h
//  AFNetworking
//
//  Created by admin on 2019/4/17.
//

#import <UIKit/UIKit.h>
#import "TestPersonModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface PersonAddressBookCell : UITableViewCell
@property(nonatomic, strong)TestPersonModel *model;
@end

NS_ASSUME_NONNULL_END
