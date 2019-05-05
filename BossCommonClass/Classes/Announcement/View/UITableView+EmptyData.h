//
//  UITableView+EmptyData.h
//  BossCommonClass
//
//  Created by admin on 2019/4/19.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITableView (EmptyData)
- (void) tableViewDisplayWitMsg:(NSString *)message imageName:(NSString *)imgName ifNecessaryForRowCount:(NSUInteger) rowCount;
@end

NS_ASSUME_NONNULL_END
