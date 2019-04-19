//
//  AddressBookCell.h
//  AFNetworking
//
//  Created by admin on 2019/4/17.
//

#import <UIKit/UIKit.h>
#import "TestGroupModel.h"
NS_ASSUME_NONNULL_BEGIN
@class AddressBookCell;
@protocol AddressBookCellDelegate <NSObject>

- (void)didSelectCell:(AddressBookCell *)cell model:(TestGroupModel *)model;

@end
@interface AddressBookCell : UITableViewCell
@property(nonatomic, strong)TestGroupModel *model;
@property(nonatomic, weak)id<AddressBookCellDelegate>delegate;
@end

NS_ASSUME_NONNULL_END
